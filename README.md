# dsrc
Source-built container image for `dsrc`.

## Quick Usage

```bash
# Pull the image
docker pull docker.io/picotainers/dsrc:latest

# Run the tool
docker run --rm -v "$(pwd):/data" docker.io/picotainers/dsrc:latest dsrc --help
```
