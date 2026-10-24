--[[

Base64

Encodes and decodes strings to and from Base64 representation.

Original source by Reselim.

--]]

const Alphabet = {}
const Indexes = {}

-- A-Z
for index = 65, 90 do
    table.insert(Alphabet, index)
end

-- a-z
for index = 97, 122 do
    table.insert(Alphabet, index)
end

-- 0-9
for index = 48, 57 do
    table.insert(Alphabet, index)
end

table.insert(Alphabet, 43) -- +
table.insert(Alphabet, 47) -- /

for index, character in ipairs(Alphabet) do
    Indexes[character] = index
end

const bit32_band = bit32.band
const bit32_lshift = bit32.lshift
const bit32_rshift = bit32.rshift

const Base64 = {}

function Base64.encode(input: string): string
    assert(type(input) == "string", "argument #1 must be a string")

    const output = {}
    local length = 0

    for index = 1, #input, 3 do
        const c1, c2, c3 = string.byte(input, index, index + 2)

        const a = bit32_rshift(c1, 2)
        const b = bit32_lshift(bit32_band(c1, 3), 4) + bit32_rshift(c2 or 0, 4)
        const c = bit32_lshift(bit32_band(c2 or 0, 15), 2) + bit32_rshift(c3 or 0, 6)
        const d = bit32_band(c3 or 0, 63)

        length += 1
        output[length] = Alphabet[a + 1]

        length += 1
        output[length] = Alphabet[b + 1]

        length += 1
        output[length] = if c2 then Alphabet[c + 1] else 61

        length += 1
        output[length] = if c3 then Alphabet[d + 1] else 61
    end

    const newOutput = {}
    local newLength = 0

    for index = 1, length, 4096 do
        newLength += 1
        const endIndex = index + 4096 - 1
        newOutput[newLength] = string.char(table.unpack(output, index, if endIndex > length then length else endIndex))
    end

    return table.concat(newOutput)
end

function Base64.decode(input: string): string
    assert(type(input) == "string", "argument #1 must be a string")

    const output = {}
    local length = 0

    for index = 1, #input, 4 do
        const c1, c2, c3, c4 = string.byte(input, index, index + 3)

        const i1 = Indexes[c1] - 1
        const i2 = Indexes[c2] - 1
        const i3 = (Indexes[c3] or 1) - 1
        const i4 = (Indexes[c4] or 1) - 1

        const a = bit32_lshift(i1, 2) + bit32_rshift(i2, 4)
        const b = bit32_lshift(bit32_band(i2, 15), 4) + bit32_rshift(i3, 2)
        const c = bit32_lshift(bit32_band(i3, 3), 6) + i4

        length += 1
        output[length] = a

        if c3 ~= 61 then
            length += 1
            output[length] = b
        end

        if c4 ~= 61 then
            length += 1
            output[length] = c
        end
    end

    const newOutput = {}
    local newLength = 0

    for index = 1, length, 4096 do
        newLength += 1
        const endIndex = index + 4096 - 1
        newOutput[newLength] = string.char(table.unpack(output, index, if endIndex > length then length else endIndex))
    end

    return table.concat(newOutput)
end

return Base64
