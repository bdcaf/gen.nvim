#! /usr/bin/env lua
--
-- memory.lua
-- Copyright (C) 2024 Clemens Ager <clemens.ager@uibk.ac.at>
--
-- Distributed under terms of the MIT license.
--

local memory = {}

function memory.keep(memfile, context)
    local file = io.open(memfile, "w+")
    if not file then return nil end

    local out = vim.fn.json_encode(context)
    local content = file:write(out)

    file:close()
end

function memory.builder(kind, arg)
    if kind == "file" then
        local memfile = arg or ".llcontext"
        return {
            recall = function()
                local file = io.open(memfile, "r")
                if not file then return nil end

                local content = file:read()

                file:close()
                local out = vim.fn.json_decode(content)
                return out
            end,
            keep = function(context)
                local file = io.open(memfile, "w+")
                if not file then return nil end
                local out = vim.fn.json_encode(context)
                file:write(out)
                file:close()
            end
        }
    end
    return {
        recall = function() return nil end,
        keep = function(...) end
    }
end

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
