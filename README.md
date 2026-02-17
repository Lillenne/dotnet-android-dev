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

## Full Image (with Android SDK)

For a self-contained image with Android SDK 36 pre-installed:

```bash
# Build the full image (builds on avalonia-dev)
podman build -t avalonia-dev-full -f Containerfile.full .

# Run with the helper script
./run-full.sh                    # Prompts for directory (defaults to current dir)
./run-full.sh /path/to/project   # Use specific directory

# Or run manually
podman run -it -v /path/to/project:/workspace avalonia-dev-full
```

This image includes Android SDK 36, platform-tools, and build-tools, so you don't need to mount `/opt/android-sdk`.

## Environment Variables

- `ANDROID_HOME=/opt/android-sdk` — mount your SDK here
- `JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64`
- `PATH` includes Android SDK tools
