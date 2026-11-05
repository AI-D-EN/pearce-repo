local path = os.getenv("HOME") .. "/.config/hypr/border_colors.conf"

local file = io.open(path, "r")

if not file then
    return
end

local active, inactive

for line in file:lines() do
    local key, value = line:match("^%s*%$([%w_]+)%s*=%s*(.-)%s*$")

    if key == "active_border" then
        active = value
    elseif key == "inactive_border" then
        inactive = value
    end
end

file:close()

if active and inactive then
    hl.config({
        general = {
            col = {
                active_border = active,
                inactive_border = inactive,
            },
        },
    })
end

