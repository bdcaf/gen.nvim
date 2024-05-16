#! /usr/bin/env lua
--
-- memory.lua
-- Copyright (C) 2024 Clemens Ager <clemens.ager@uibk.ac.at>
--
-- Distributed under terms of the MIT license.
--

local memory = {}

function memory.recall(memfile)
    local file = io.open(memfile, "r")
    if not file then return nil end

    local content = file:read()

    file:close()
    local out = vim.fn.json_decode(content)
    return out
end

function memory.keep(memfile, context)
    local file = io.open(memfile, "w+")
    if not file then return nil end

    local out = vim.fn.json_encode(context)
    local content = file:write(out)

    file:close()
end

return memory
