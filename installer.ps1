$ErrorActionPreference = 'Stop'
Write-Host "Starting docgen installation..."

# Ask to install Ollama if not found
if (-not (Get-Command "ollama" -ErrorAction SilentlyContinue)) {
    Write-Host "Ollama is not installed. It is highly recommended for local AI processing."
    $install_ollama = Read-Host "Would you like to install Ollama now? (y/n)"
    if ($install_ollama -match '^[Yy]') {
        Write-Host "Installing Ollama..."
        $ollama_installer = "$env:TEMP\OllamaSetup.exe"
        Invoke-WebRequest -Uri "https://ollama.com/download/OllamaSetup.exe" -OutFile $ollama_installer
        Start-Process -FilePath $ollama_installer -Wait -NoNewWindow
    } else {
        Write-Host "Skipping Ollama installation."
    }
} else {
    Write-Host "Ollama is already installed."
}

$InstallDir = "$env:USERPROFILE\.local\bin"
if (-not (Test-Path $InstallDir)) {
    New-Item -ItemType Directory -Path $InstallDir -Force | Out-Null
}

# Determine OS and Architecture
$OS = "windows"
$Arch = if ($env:PROCESSOR_ARCHITECTURE -match "AMD64|IA64") { "amd64" } elseif ($env:PROCESSOR_ARCHITECTURE -match "ARM64") { "arm64" } else { "x86" }

Write-Host "Fetching latest release information for docgen..."
$ReleaseUrl = "https://api.github.com/repos/alonsovm44/docgen/releases/latest"
try {
    $ReleaseData = Invoke-RestMethod -Uri $ReleaseUrl
    $Asset = $ReleaseData.assets | Where-Object { $_.name -match $OS -and $_.name -match $Arch } | Select-Object -First 1
    $DownloadUrl = $Asset.browser_download_url
} catch {
    Write-Host "Could not fetch release data."
    $DownloadUrl = $null
}

function Build-FromSource {
    Write-Host "Checking build dependencies..."
    
    $hasGpp = Get-Command "g++" -ErrorAction SilentlyContinue
    $hasClang = Get-Command "clang++" -ErrorAction SilentlyContinue
    if (-not $hasGpp -and -not $hasClang) {
        Write-Error "C++ compiler not found. Please install MinGW-w64 or Clang, and ensure it is in your PATH."
        exit 1
    }

    $makeCmd = if (Get-Command "make" -ErrorAction SilentlyContinue) { "make" } elseif (Get-Command "mingw32-make" -ErrorAction SilentlyContinue) { "mingw32-make" } else { $null }
    if (-not $makeCmd) {
        Write-Error "make utility not found. Please install make (or mingw32-make) and ensure it is in your PATH."
        exit 1
    }

    if ((Test-Path "src\main.cpp") -and (Test-Path "Makefile")) {
        Write-Host "Local source code detected. Building..."
        Invoke-Expression "$makeCmd all"
        Move-Item -Path "docgen.exe" -Destination "$InstallDir\docgen.exe" -Force
        Write-Host "docgen successfully built and installed to $InstallDir\docgen.exe"
    } else {
        Write-Host "Downloading source code..."
        $TmpDir = [System.IO.Path]::Combine([System.IO.Path]::GetTempPath(), [System.Guid]::NewGuid().ToString())
        New-Item -ItemType Directory -Path $TmpDir | Out-Null
        Set-Location $TmpDir

        Invoke-WebRequest -Uri "https://github.com/alonsovm44/docgen/archive/refs/heads/master.zip" -OutFile "source.zip"
        Expand-Archive -Path "source.zip" -DestinationPath "." -Force
        Set-Location "docgen-master"
        
        Write-Host "Downloading tree-sitter dependencies..."
        $repos = @("tree-sitter", "tree-sitter-c", "tree-sitter-cpp", "tree-sitter-python", "tree-sitter-javascript", "tree-sitter-typescript", "tree-sitter-go", "tree-sitter-rust")
        foreach ($repo in $repos) {
            Invoke-WebRequest -Uri "https://github.com/tree-sitter/$repo/archive/refs/heads/master.zip" -OutFile "$repo.zip"
            Expand-Archive -Path "$repo.zip" -DestinationPath "." -Force
            Rename-Item -Path "$repo-master" -NewName $repo
        }

        Write-Host "Building docgen from source..."
        Invoke-Expression "$makeCmd all"
        Move-Item -Path "docgen.exe" -Destination "$InstallDir\docgen.exe" -Force
        
        Set-Location $env:USERPROFILE
        Remove-Item -Path $TmpDir -Recurse -Force
        Write-Host "docgen successfully built and installed to $InstallDir\docgen.exe"
    }
}

if ($DownloadUrl) {
    Write-Host "Downloading pre-built binary for $OS-$Arch..."
    try {
        Invoke-WebRequest -Uri $DownloadUrl -OutFile "$InstallDir\docgen.exe"
        Write-Host "docgen successfully installed to $InstallDir\docgen.exe"
    } catch {
        Write-Host "Failed to download pre-built binary. Falling back to source build..."
        Build-FromSource
    }
} else {
    Write-Host "No pre-built binary found for $OS-$Arch. Falling back to source installation..."
    Build-FromSource
}

# Path warning
$currentPath = [Environment]::GetEnvironmentVariable("PATH", "User") + ";" + [Environment]::GetEnvironmentVariable("PATH", "Machine")
if ($currentPath -notmatch [regex]::Escape($InstallDir)) {
    Write-Host "==================================================" -ForegroundColor Yellow
    Write-Host "WARNING: $InstallDir is not in your PATH." -ForegroundColor Yellow
    Write-Host "Please add it to your Environment Variables:" -ForegroundColor Yellow
    Write-Host "[Environment]::SetEnvironmentVariable('PATH', `$env:PATH + ';$InstallDir', 'User')" -ForegroundColor Cyan
    Write-Host "==================================================" -ForegroundColor Yellow
}

Write-Host "Setup complete! Run 'docgen' to get started." -ForegroundColor Green