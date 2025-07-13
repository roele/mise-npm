function PLUGIN:BackendListVersions(ctx)
    local tool = ctx.tool
    
    -- Use npm view to get real versions
    local cmd = require("cmd")
    local result = cmd.exec("npm view " .. tool .. " versions --json 2>/dev/null")
    local json = require("json")
    local versions = json.decode(result)
    
    return {versions = versions}
end
