FROM mcr.microsoft.com/devcontainers/cpp:1-debian-12

# Install additional OS packages.
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends curl \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/*