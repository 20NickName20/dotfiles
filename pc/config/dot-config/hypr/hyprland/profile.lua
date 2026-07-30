hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1.0 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })
hl.animation({
    leaf = "global",
    enabled = true,
    speed = 10,
    bezier = "default",
})
hl.animation({
    leaf = "border",
    enabled = true,
    speed = 5.39,
    bezier = "easeOutQuint",
})
hl.animation({
    leaf = "windows",
    enabled = true,
    speed = 4.79,
    bezier = "easeOutQuint",
})
hl.animation({
    leaf = "windowsOut",
    enabled = true,
    speed = 1.49,
    bezier = "linear",
    style = "popin 87%",
})
hl.animation({
    leaf = "fadeIn",
    enabled = true,
    speed = 1.73,
    bezier = "almostLinear",
})
hl.animation({
    leaf = "fadeOut",
    enabled = true,
    speed = 1.46,
    bezier = "almostLinear",
})
hl.animation({
    leaf = "fade",
    enabled = true,
    speed = 3.03,
    bezier = "quick",
})
hl.animation({
    leaf = "layers",
    enabled = true,
    speed = 3.81,
    bezier = "easeOutQuint",
})
hl.animation({
    leaf = "layersIn",
    enabled = true,
    speed = 4,
    bezier = "easeOutQuint",
    style = "fade",
})
hl.animation({
    leaf = "layersOut",
    enabled = true,
    speed = 1.5,
    bezier = "linear",
    style = "fade",
})
hl.animation({
    leaf = "fadeLayersIn",
    enabled = true,
    speed = 1.79,
    bezier = "almostLinear",
})
hl.animation({
    leaf = "fadeLayersOut",
    enabled = true,
    speed = 1.39,
    bezier = "almostLinear",
})
hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 8,
    bezier = "default",
    style = "slide",
})
hl.animation({
    leaf = "windowsIn",
    enabled = true,
    speed = 2,
    bezier = "easeInOutCubic",
    style = "popin 87%",
})

hl.layer_rule({
    match = { namespace = "rofi" },
    blur = true
})

hl.config({
    general = {
        gaps_in = 1,
        gaps_out = 5,
        border_size = 0,
        col = {
            active_border = { colors = { "rgba(ff3366ee)", "rgba(dd1188ee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },
        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    },
    decoration = {
        rounding = 8,
        rounding_power = 2,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        dim_inactive = true,
        dim_strength = 0.1,
        shadow = {
            enabled = false,
            range = 2,
            render_power = 1,
            color = "rgba(ff33a0aa)",
            color_inactive = "rgba(595959aa)",
        },
        blur = {
            enabled = true,
            size = 2,
            passes = 1,
            vibrancy = 0.1696,
            new_optimizations = true,
        },
    },
    animations = {
        enabled = true,
    },
    misc = {
        font_family = "0xProto Nerd Font",
    },
})

hl.window_rule({
  name = "make windowkill window non blur",
  match = {
    class = "windowkill"
  },
  no_blur = true
})

hl.on("hyprland.start", function()
    hl.exec_cmd("/home/nickname/.cargo/bin/pwsp-daemon")
    hl.exec_cmd("/home/nickname/.cargo/bin/pwsp-cli set volume 0.15 && /home/nickname/.cargo/bin/pwsp-cli set input alsa_input.usb-C-Media_Electronics_Inc._USB_Audio_Device-00.mono-fallback")
end)

require("hyprland.pwsp-binds")

