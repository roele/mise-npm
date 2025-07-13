function PLUGIN:BackendExecEnv(ctx)
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
