PLUGIN = {
    name = "vfox-npm",
    version = "1.0.0", 
    description = "Vfox plugin for npm packages",
    author = "jdx",
    license = "MIT",
    
    -- Backend methods for plugin:tool format (CamelCase)
    BackendListVersions = function(ctx)
        local tool = BACKEND_CTX.tool
        local versions = {}
        
        -- Use npm view to get real versions
        local cmd = require("cmd")
        local result = cmd.exec("npm view " .. tool .. " versions --json 2>/dev/null")
        
        if result and result ~= "" and not result:match("npm ERR!") then
            -- Parse JSON response from npm using built-in json module
            local json = require("json")
            local success, npm_versions = pcall(json.decode, result)
            
            if success and npm_versions then
                if type(npm_versions) == "table" then
                    for i = #npm_versions, 1, -1 do
                        local version = npm_versions[i]
                        table.insert(versions, version)
                    end
                end
            end
        end
        
        if #versions == 0 then
            error("Failed to fetch versions for " .. tool .. " from npm registry")
        end
        
        return {versions = versions}
    end,
    
    BackendInstall = function(ctx)
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
    end,
    
    BackendExecEnv = function(ctx)
        local install_path = BACKEND_CTX.install_path
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
}
