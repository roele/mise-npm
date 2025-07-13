function PLUGIN:BackendInstall(ctx)
    local tool = ctx.tool
    local version = ctx.version
    local install_path = ctx.install_path
    
    -- Create install directory
    os.execute("mkdir -p " .. install_path)
    
    -- Install the package directly using npm install
    local cmd = require("cmd")
    local npm_cmd = "cd " .. install_path .. " && npm install " .. tool .. "@" .. version .. " --no-package-lock --no-save --silent 2>/dev/null"
    local result = cmd.exec(npm_cmd)
    
    -- If we get here, the command succeeded
    return {}
end
