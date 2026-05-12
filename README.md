# dsrc
Source-built container image for `dsrc`.

## Quick Usage

```bash
docker pull docker.io/picotainers/dsrc:latest
docker run --rm docker.io/picotainers/dsrc:latest dsrc --help
```

## Usage

```bash
# Mount the current directory so DSRC can read input files and write output files
docker run --rm -v "$(pwd):/data" -w /data docker.io/picotainers/dsrc:latest dsrc --help
```

## Building

```bash
docker build -t docker.io/picotainers/dsrc:latest .
```
