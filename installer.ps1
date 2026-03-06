$ErrorActionPreference = "Stop"

Write-Host "Checking for prerequisites..."

if (-not (Get-Command curl -ErrorAction SilentlyContinue)) {
    Write-Warning "curl not found. docgen requires curl to make API requests."
}

if (-not (Get-Command ollama -ErrorAction SilentlyContinue)) {
    $install = Read-Host "Ollama not found. Do you want to install it? (y/n)"
    if ($install -eq 'y') {
        Write-Host "Downloading OllamaSetup.exe..."
        $installerPath = "$env:TEMP\OllamaSetup.exe"
        Invoke-WebRequest -Uri "https://ollama.com/download/OllamaSetup.exe" -OutFile $installerPath
        Write-Host "Running installer..."
        Start-Process -FilePath $installerPath
    }
}

Write-Host "Compiling docgen..."

if (Get-Command g++ -ErrorAction SilentlyContinue) {
    Write-Host "Using g++..."
    g++ -std=c++17 -o docgen.exe src/main.cpp
} elseif (Get-Command cl -ErrorAction SilentlyContinue) {
    Write-Host "Using MSVC (cl)..."
    # /EHsc: Enable C++ exceptions
    # /std:c++17: Use C++17 standard
    # /Fe:docgen.exe: Output executable name
    cl /EHsc /std:c++17 /Fe:docgen.exe src/main.cpp
} else {
    Write-Error "No C++ compiler found. Please install g++ (MinGW) or MSVC."
    exit 1
}

if (Test-Path docgen.exe) {
    Write-Host "Build complete. Run .\docgen.exe to start."
} else {
    Write-Error "Build failed."
    exit 1
}