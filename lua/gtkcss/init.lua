-- gtkcss.nvim - GTK CSS syntax support for Neovim
-- Provides syntax highlighting for GTK3/GTK4 CSS with @define-color support

local M = {}

M.config = {
    -- File extensions to detect as gtkcss
    extensions = { "gtk.css", "gtk.scss", "gtk.less" },
    -- Additional filename patterns
    patterns = {},
    -- Header markers to detect gtkcss in any css file
    headers = { "gtk-css", "gtkcss", "gtk css" },
}

-- Check if file contains gtkcss header marker
local function check_header(bufnr)
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, 5, false)
    for _, line in ipairs(lines) do
        local lower = line:lower()
        for _, header in ipairs(M.config.headers) do
            if lower:find(header, 1, true) then
                return true
            end
        end
        -- Also detect @define-color as GTK CSS marker
        if line:match("^%s*@define%-color") then
            return true
        end
    end
    return false
end

function M.setup(opts)
    M.config = vim.tbl_deep_extend("force", M.config, opts or {})

    -- Build pattern table from extensions
    local pattern_table = {}
    for _, ext in ipairs(M.config.extensions) do
        -- Convert extension to lua pattern: "gtk.css" -> ".*%.gtk%.css"
        local lua_pattern = ".*%." .. ext:gsub("%.", "%%.")
        pattern_table[lua_pattern] = "gtkcss"
    end

    -- Add custom patterns
    for _, pat in ipairs(M.config.patterns) do
        local lua_pattern = pat:gsub("%.", "%%."):gsub("%*", ".*")
        pattern_table[lua_pattern] = "gtkcss"
    end

    -- Register filetype detection by extension/pattern
    vim.filetype.add({
        pattern = pattern_table,
    })

    -- Register autocommand for header detection in css/scss/less files
    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = { "*.css", "*.scss", "*.less" },
        callback = function(args)
            -- Skip if already gtkcss or matches gtk extension
            local filename = args.file
            if filename:match("%.gtk%.") then
                return
            end
            -- Check header
            if check_header(args.buf) then
                vim.bo[args.buf].filetype = "gtkcss"
            end
        end,
    })
end

return M
