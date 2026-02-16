FROM debian:trixie

ENV DEBIAN_FRONTEND=noninteractive

# Install base dependencies
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y \
        curl \
        wget \
        unzip \
        git \
        openjdk-17-jdk \
    && rm -rf /var/lib/apt/lists/*

# Install .NET SDK 10.0
RUN wget https://packages.microsoft.com/config/debian/13/packages-microsoft-prod.deb -O /tmp/packages-microsoft-prod.deb && \
    dpkg -i /tmp/packages-microsoft-prod.deb && \
    rm /tmp/packages-microsoft-prod.deb && \
    apt-get update && \
    apt-get install -y dotnet-sdk-10.0 && \
    rm -rf /var/lib/apt/lists/*

# Install .NET workloads for Android, WASM, and Desktop
RUN dotnet workload install android wasm-tools wasm-experimental

# Android SDK environment (mounted at runtime via -v /opt/android-sdk:/opt/android-sdk)
ENV ANDROID_HOME=/opt/android-sdk
ENV PATH="${PATH}:${ANDROID_HOME}/cmdline-tools/latest/bin:${ANDROID_HOME}/platform-tools"

# Java environment
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64

# Install GitHub Copilot CLI
RUN curl -fsSL https://gh.io/copilot-install | bash

# Create a working directory for mounted repos
WORKDIR /workspace

ENTRYPOINT ["/bin/bash"]
