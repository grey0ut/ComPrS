# Changelog for ComPrS

The format is based on and uses the types of changes according to [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Fixed

- Replaced `out-string` with `[System.Environment]::NewLine` to fix issue with additional newline character being created.
also required switching to a `system.collections.generic.list` for pipeline object collection.
