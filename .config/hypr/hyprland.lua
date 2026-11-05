-- ==========================================
-- Hyprland Lua configuration
-- Target: Hyprland 0.57.1
-- ==========================================

-- Load Matugen-generated border colors.
-- border_colors.lua reads ~/.config/hypr/border_colors.conf.
--dofile(os.getenv("HOME") .. "/.config/hypr/border_colors.lua")

-- ------------------------------------------
-- Monitor
-- ------------------------------------------

hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = 1,
})

-- ------------------------------------------
-- Environment variables
-- ------------------------------------------

hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("HYPRCURSOR_SIZE", "24")

hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_STYLE_OVERRIDE", "kvantum")
hl.env("KVANTUM_THEME", "Matugen")

-- ------------------------------------------
-- General, decoration, input and gestures
-- ------------------------------------------

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 10,
        border_size = 2,
        layout = "dwindle",
    },

    dwindle = {
    preserve_split = true,
    smart_split = false,
    smart_resizing = true,
    },
    
    decoration = {
        rounding = 20,
        active_opacity = 0.95,
        inactive_opacity = 0.87,

        blur = {
            enabled = true,
            size = 8,
            passes = 3,
            new_optimizations = true,
        },

        shadow = {
            enabled = true,
            range = 18,
            render_power = 4,
            color = "rgba(00000040)",
        },
    },

    input = {
        kb_layout = "us",
        follow_mouse = 1,

        touchpad = {
            natural_scroll = true,
            disable_while_typing = true,
            tap_to_click = true,
            scroll_factor = 0.3,
        },
    },

    gestures = {
        workspace_swipe_touch = true,
        workspace_swipe_distance = 300,
        workspace_swipe_invert = false,
        workspace_swipe_create_new = false,
    },

    misc = {
        force_default_wallpaper = 0,
        animate_manual_resizes = true,
        animate_mouse_windowdragging = true,
    },
})
dofile(os.getenv("HOME") .. "/.config/hypr/border_colors.lua")
-- ------------------------------------------
-- Animations (converted from snappy.conf)
-- ------------------------------------------

hl.curve("snap", {
    type = "bezier",
    points = { { 0.2, 0.9 }, { 0.3, 1.0 } },
})

hl.curve("snapOut", {
    type = "bezier",
    points = { { 0.4, 0.0 }, { 1.0, 1.0 } },
})

hl.curve("smoothFade", {
    type = "bezier",
    points = { { 0.3, 0.0 }, { 0.1, 1.0 } },
})

hl.animation({ leaf = "global", enabled = true,speed = 4, bezier = "snap" })
hl.animation({ leaf = "windows", enabled = true, speed = 4, bezier = "snap" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "snapOut" })
hl.animation({ leaf = "border", enabled = true, speed = 8, bezier = "snap" })
hl.animation({ leaf = "fade", enabled = true, speed = 4, bezier = "smoothFade" })
hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 5,
    bezier = "snap",
    style = "slidefade",
})

-- ------------------------------------------
-- Window rules
-- ------------------------------------------

hl.window_rule({
    name = "kitty-float",
    match = { class = "^(kitty-float)$" },
    float = true,
    center = true,
    size = { 900, 550 },
    fullscreen_state = "0 0",
})
hl.window_rule({
    name = "kitty-no-maximize",
    match = { class = "^(kitty)$" },
    fullscreen_state = "0 0",
})

hl.window_rule({
    name = "waypaper-float",
    match = { title = "^(Waypaper)$" },
    float = true,
    center = true,
    size = { 850, 650 },
})

hl.window_rule({
    name = "blueman-manager-float",
    match = { class = "^(blueman-manager)$" },
    float = true,
    size = { 365, 365 },
    move = { 1452, 68 },
})

hl.window_rule({
    name = "localsend-float",
    match = { title = "^(LocalSend)$" },
    float = true,
    center = true,
    size = { 900, 600 },
})

hl.window_rule({
    name = "thunar-opacity",
    match = { class = "^(thunar)$" },
    opacity = "0.95 0.92",
})

-- ------------------------------------------
-- Keybindings
-- ------------------------------------------

-- Applications
hl.bind("SUPER + T", hl.dsp.exec_cmd("kitty --class kitty-float"))
hl.bind("SUPER + RETURN", hl.dsp.exec_cmd("kitty"))
hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + E", hl.dsp.exec_cmd("thunar"))
hl.bind("SUPER + R", hl.dsp.exec_cmd("rofi -show drun"))
hl.bind("SUPER + ESCAPE", hl.dsp.exec_cmd("wlogout --protocol layer-shell"))
hl.bind("SUPER + P", hl.dsp.exec_cmd("grimblast copy area"))
hl.bind("SUPER + SHIFT + P", hl.dsp.exec_cmd(
    'grimblast save area "$HOME/Pictures/Screenshots/$(date +%Y-%m-%d-%H%M%S).png"'
))

-- Focus movement
hl.bind("SUPER + LEFT", hl.dsp.focus({ direction = "l" }))
hl.bind("SUPER + RIGHT", hl.dsp.focus({ direction = "r" }))
hl.bind("SUPER + UP", hl.dsp.focus({ direction = "u" }))
hl.bind("SUPER + DOWN", hl.dsp.focus({ direction = "d" }))

-- Move windows
hl.bind("SUPER + SHIFT + LEFT", hl.dsp.window.move({ direction = "l" }))
hl.bind("SUPER + SHIFT + RIGHT", hl.dsp.window.move({ direction = "r" }))
hl.bind("SUPER + SHIFT + UP", hl.dsp.window.move({ direction = "u" }))
hl.bind("SUPER + SHIFT + DOWN", hl.dsp.window.move({ direction = "d" }))

-- Fullscreen
hl.bind("SUPER + F", hl.dsp.window.fullscreen({ action = "toggle" }))

-- Workspaces 1-6
for i = 1, 6 do
    local workspace = tostring(i)
    hl.bind("SUPER + " .. workspace, hl.dsp.focus({ workspace = workspace }))
    hl.bind("SUPER + SHIFT + " .. workspace,
        hl.dsp.window.move({ workspace = workspace }))
end

-- Volume keys (repeat and work while locked, matching bindel behavior)
hl.bind("XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("swayosd-client --output-volume +2"),
    { locked = true, repeating = true })

hl.bind("XF86AudioLowerVolume",
    hl.dsp.exec_cmd("swayosd-client --output-volume -2"),
    { locked = true, repeating = true })

hl.bind("XF86AudioMute",
    hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"),
    { locked = true })

-- Brightness keys
hl.bind("XF86MonBrightnessUp",
    hl.dsp.exec_cmd("swayosd-client --brightness raise"),
    { locked = true, repeating = true })

hl.bind("XF86MonBrightnessDown",
    hl.dsp.exec_cmd("swayosd-client --brightness lower"),
    { locked = true, repeating = true })

-- Mouse window movement and resize
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Workspace scrolling
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Hyprlock
hl.bind("SUPER + L", hl.dsp.exec_cmd("hyprlock"))

-- Wallpaper menu
hl.bind("SUPER + W", hl.dsp.exec_cmd("~/.config/hypr/scripts/wallpaper-menu.sh"))

-- Browser
hl.bind("SUPER + B", hl.dsp.exec_cmd("firefox"))

-- Yazi
hl.bind("SUPER + SHIFT + E", hl.dsp.exec_cmd("kitty -e yazi"))

-- VS Code
hl.bind("SUPER + C", hl.dsp.exec_cmd("code"))

-- ------------------------------------------
-- Autostart
-- ------------------------------------------

hl.on("hyprland.start", function()
    --hl.exec_cmd("awww-daemon")
    hl.exec_cmd("bash -c 'pgrep -x awww-daemon >/dev/null || awww-daemon'")
    hl.exec_cmd("hypridle")

    hl.exec_cmd("sleep 1 && waybar")
    hl.exec_cmd("sleep 7 && nm-applet")
    hl.exec_cmd("sleep 4 && blueman-applet")

    hl.exec_cmd("swaync")
    hl.exec_cmd("/usr/bin/swayosd-server")

    hl.exec_cmd("bash -c 'while true; do ~/.config/hypr/scripts/cover.sh; sleep 2; done'")
    hl.exec_cmd("kitty --listen-on unix:/tmp/kitty-aiden")

    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=Hyprland")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
end)
