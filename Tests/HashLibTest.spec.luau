--[[

HashLibTest

Tests for the HashLib module using known test vectors from NIST and RFC
documents.

--]]

local HashLib = require("@hashlib")

return function()
    describe("md5", function()
        it("should hash empty string", function()
            expect(HashLib.md5("")).to.equal("d41d8cd98f00b204e9800998ecf8427e")
        end)

        it("should hash simple strings", function()
            expect(HashLib.md5("a")).to.equal("0cc175b9c0f1b6a831c399e269772661")
            expect(HashLib.md5("abc")).to.equal("900150983cd24fb0d6963f7d28e17f72")
            expect(HashLib.md5("message digest")).to.equal("f96b697d7cb7938d525a2f31aaf161d0")
        end)

        it("should hash longer strings", function()
            expect(HashLib.md5("abcdefghijklmnopqrstuvwxyz")).to.equal("c3fcd3d76192e4007dfb496cca67e13b")
        end)
    end)

    describe("sha1", function()
        it("should hash empty string", function()
            expect(HashLib.sha1("")).to.equal("da39a3ee5e6b4b0d3255bfef95601890afd80709")
        end)

        it("should hash simple strings", function()
            expect(HashLib.sha1("abc")).to.equal("a9993e364706816aba3e25717850c26c9cd0d89d")
        end)

        it("should hash longer strings", function()
            expect(HashLib.sha1("abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq")).to.equal(
                "84983e441c3bd26ebaae4aa1f95129e5e54670f1"
            )
        end)
    end)

    describe("sha256", function()
        it("should hash empty string", function()
            expect(HashLib.sha256("")).to.equal("e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855")
        end)

        it("should hash simple strings", function()
            expect(HashLib.sha256("abc")).to.equal("ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad")
        end)

        it("should hash longer strings", function()
            expect(HashLib.sha256("abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq")).to.equal(
                "248d6a61d20638b8e5c026930c3e6039a33ce45964ff2167f6ecedd419db06c1"
            )
        end)
    end)

    describe("sha224", function()
        it("should hash simple strings", function()
            expect(HashLib.sha224("abc")).to.equal("23097d223405d8228642a477bda255b32aadbce4bda0b3f7e36c9da7")
        end)
    end)

    describe("sha384", function()
        it("should hash simple strings", function()
            expect(HashLib.sha384("abc")).to.equal(
                "cb00753f45a35e8bb5a03d699ac65007272c32ab0eded1631a8b605a43ff5bed" .. "8086072ba1e7cc2358baeca134c825a7"
            )
        end)
    end)

    describe("sha512", function()
        it("should hash empty string", function()
            expect(HashLib.sha512("")).to.equal(
                "cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce"
                    .. "47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e"
            )
        end)

        it("should hash simple strings", function()
            expect(HashLib.sha512("abc")).to.equal(
                "ddaf35a193617abacc417349ae20413112e6fa4e89a97ea20a9eeee64b55d39a"
                    .. "2192992a274fc1a836ba3c23a3feebbd454d4423643ce80e2a9ac94fa54ca49f"
            )
        end)
    end)

    describe("sha3x256", function()
        it("should hash empty string", function()
            expect(HashLib.sha3x256("")).to.equal("a7ffc6f8bf1ed76651c14756a061d662f580ff4de43b49fa82d80a4b80f8434a")
        end)

        it("should hash simple strings", function()
            expect(HashLib.sha3x256("abc")).to.equal("3a985da74fe225b2045c172d6bd390bd855f086e3e9d525b46bfe24511431532")
        end)
    end)

    describe("sha3x512", function()
        it("should hash empty string", function()
            expect(HashLib.sha3x512("")).to.equal(
                "a69f73cca23a9ac5c8b567dc185a756e97c982164fe25859e0d1dcc1475c80a6"
                    .. "15b2123af1f5f94c11e3e9402c3ac558f500199d95b6d3e301758586281dcd26"
            )
        end)
    end)

    describe("hmac", function()
        it("should compute HMAC-SHA256", function()
            local result = HashLib.hmac(HashLib.sha256, "key", "The quick brown fox jumps over the lazy dog")
            expect(result).to.equal("f7bc83f430538424b13298e6aa6fb143ef4d59a14946175997479dbc2d1a3cd8")
        end)

        it("should compute HMAC-MD5", function()
            local result = HashLib.hmac(HashLib.md5, "", "")
            expect(result).to.equal("74e6f7298a9c2d168935f58c001bad88")
        end)
    end)

    describe("utility functions", function()
        it("should convert hex to binary", function()
            local bin = HashLib.hexToBin("48656c6c6f")
            expect(bin).to.equal("Hello")
        end)

        it("should convert binary to base64", function()
            local b64 = HashLib.binToBase64("Hello")
            expect(b64).to.equal("SGVsbG8=")
        end)

        it("should convert base64 to binary", function()
            local bin = HashLib.base64ToBin("SGVsbG8=")
            expect(bin).to.equal("Hello")
        end)

        it("should encode and decode base64", function()
            local encoded = HashLib.base64Encode("Hello, World!")
            expect(encoded).to.equal("SGVsbG8sIFdvcmxkIQ==")

            local decoded = HashLib.base64Decode(encoded)
            expect(decoded).to.equal("Hello, World!")
        end)
    end)
end
