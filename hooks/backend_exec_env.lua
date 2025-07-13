function PLUGIN:BackendExecEnv(ctx)
    local install_path = ctx.install_path
    -- Add node_modules/.bin to PATH for npm-installed binaries
    local bin_path = install_path .. "/node_modules/.bin"
    return {
        env_vars = {
            {key = "PATH", value = bin_path}
        }
    }
end
