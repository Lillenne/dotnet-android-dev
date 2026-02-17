# Avalonia Dev Environment

A containerized development environment for building Avalonia UI applications targeting WASM, Desktop, and Android.

## Build the Image

```bash
podman build -t avalonia-dev -f Containerfile .
```

## Run the Container

Use the provided script:

```bash
./run.sh                    # Prompts for directory (defaults to current dir)
./run.sh /path/to/project   # Use specific directory
```

Or manually mount your project and Android SDK:

```bash
podman run -it \
  -v /opt/android-sdk:/opt/android-sdk \
  -v /path/to/your/project:/workspace \
  avalonia-dev
```

Then build your app inside the container:

```bash
cd /workspace
dotnet build
```

## What's Included

- .NET SDK 10.0
- Workloads: `android`, `wasm-tools`, `wasm-experimental`
- OpenJDK 21
- GitHub Copilot CLI
- Git

## Environment Variables

- `ANDROID_HOME=/opt/android-sdk` — mount your SDK here
- `JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64`
- `PATH` includes Android SDK tools
