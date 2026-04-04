# Changelog

## 0.0.4
- Remove .luaurc from Wally package to fix transitive dependency resolution
- Bump dependencies and update submodules

## 0.0.3
- Standardized test runner with code coverage
- Included .luaurc in Wally package
- Bumped lune to 0.10.4-horse.13.0
- Bumped luau-lsp to 1.63.0-horse.1.4
- Added branch name validation to CI
- Renamed public API to camelCase

## 0.0.2
- Renamed all public API functions from snake_case to camelCase

## 0.0.1
- Initial release based on boatbomber/hashlib with full Luau type annotations
- Added MD5, SHA-1, SHA-224, SHA-256, SHA-384, SHA-512, SHA-512/224, SHA-512/256
- Added SHA3-224, SHA3-256, SHA3-384, SHA3-512, SHAKE128, SHAKE256
- Added HMAC support for all hash functions except SHAKE
- Added utility functions for hex, base64, and binary conversions
