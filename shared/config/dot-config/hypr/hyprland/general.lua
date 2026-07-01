hl.monitor({
    output = "",
    mode = "highres",
    position = "auto",
    scale = "1",
})

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

hl.window_rule({
    match = {
        class = "^(firefox|google-chrome|chromium)$",
    },
    render_unfocused = true
})

hl.config({
    xwayland = {
        force_zero_scaling = true,
    },
    dwindle = {
        preserve_split = true, -- You probably want this
        smart_split = true,
    },
    master = {
        new_status = "master",
    },
    misc = {
        force_default_wallpaper = -1, -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo = true, -- If true disables the random hyprland logo / anime girl background. :(
        disable_splash_rendering = true,
        disable_autoreload = true,
    },
    input = {
        kb_layout = "us,ru",
        kb_options = "grp:win_space_toggle",
        kb_variant = "",
        kb_model = "",
        kb_rules = "",
        follow_mouse = 1,
        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.
    },
    ecosystem = {
        no_donation_nag = 1,
        no_update_news = 1,
    },
})


