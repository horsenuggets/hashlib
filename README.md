# hashlib

A hashing library for Luau.

Based on [boatbomber/HashLib](https://github.com/boatbomber/HashLib), originally by Egor
Skriptunoff, boatbomber, and howmanysmall. Ported with full Luau type annotations.

## Supported algorithms

- MD5
- SHA-1
- SHA-224, SHA-256, SHA-384, SHA-512, SHA-512/224, SHA-512/256
- SHA3-224, SHA3-256, SHA3-384, SHA3-512
- SHAKE128, SHAKE256
- HMAC (applicable to any hash function except SHAKE)

## Usage

```luau
local HashLib = require("@packages/HashLib")

local hash = HashLib.sha256("hello world")
print(hash) -- "b94d27b9934d3e08a52e52d7da7dabfac484efe37a5380ee9088f7ace2efcde9"
```

## Installation

Add to your `wally.toml`:

```toml
[dependencies]
HashLib = "horsenuggets/hashlib@0.0.2"
```
