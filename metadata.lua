--- !!! DO NOT EDIT OR RENAME !!!
PLUGIN = {}

--- !!! MUST BE SET !!!
--- Plugin name
PLUGIN.name = "vfox-npm"
--- Plugin version
PLUGIN.version = "1.0.0"
--- Plugin repository
PLUGIN.homepage = "https://github.com/jdx/mise"
--- Plugin license
PLUGIN.license = "MIT"
--- Plugin description
PLUGIN.description = "Vfox plugin for npm packages"

--- !!! OPTIONAL !!!
--- minimum compatible vfox version
PLUGIN.minRuntimeVersion = "0.3.0"
--- Some things that need user to be attention!
PLUGIN.notes = {}

--- List legacy configuration filenames for determining the specified version of the tool.
PLUGIN.legacyFilenames = {}

-- Backend methods for plugin:tool format (CamelCase)
PLUGIN.BackendListVersions = function(ctx)
    -- Simplified version for testing
    return {
        versions = {"3.0.0", "2.8.0", "2.7.0"}
    }
end

PLUGIN.BackendInstall = function(ctx)
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

PLUGIN.BackendExecEnv = function(ctx)
    local install_path = ctx.install_path
    if install_path then
        -- Add node_modules/.bin to PATH for npm-installed binaries
        local bin_path = install_path .. "/node_modules/.bin"
        return {
            env_vars = {
                {key = "PATH", value = bin_path}
            }
        }
    else
        return {env_vars = {}}
    end
end
