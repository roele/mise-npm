function PLUGIN:BackendInstall(ctx)
    local tool = BACKEND_CTX.tool
    local version = BACKEND_CTX.version
    local install_path = BACKEND_CTX.install_path
    
    -- Create install directory
    os.execute("mkdir -p " .. install_path)
    
    -- Install the package directly using npm install
    local cmd = require("cmd")
    local npm_cmd = "cd " .. install_path .. " && npm install " .. tool .. "@" .. version .. " --no-package-lock --no-save --silent 2>/dev/null"
    local result = cmd.exec(npm_cmd)
    
    -- If we get here, the command succeeded
    return {}
end
