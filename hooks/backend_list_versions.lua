function PLUGIN:BackendListVersions(ctx)
    local tool = ctx.tool
    local versions = {}
    
    -- -- Use npm view to get real versions
    -- local cmd = require("cmd")
    -- local result = cmd.exec("npm view " .. tool .. " versions --json 2>/dev/null")
    
    -- if result and result ~= "" and not result:match("npm ERR!") then
    --     -- Parse JSON response from npm using built-in json module
    --     local json = require("json")
    --     local success, npm_versions = pcall(json.decode, result)
        
    --     if success and npm_versions then
    --         if type(npm_versions) == "table" then
    --             for i = #npm_versions, 1, -1 do
    --                 local version = npm_versions[i]
    --                 table.insert(versions, version)
    --             end
    --         end
    --     end
    -- end
    
    -- if #versions == 0 then
    --     error("Failed to fetch versions for " .. tool .. " from npm registry")
    -- end
    
    return {versions = versions}
end
