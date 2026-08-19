hl.config({
    general = {
        gaps_in = 1,
        gaps_out = 5,
        border_size = 2,
        col = {
            active_border = { colors = { "rgba(33ccffee)", "rgba(9911aaee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },
        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    },
    decoration = {
        rounding = 0,
        rounding_power = 0,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        dim_inactive = false,
        shadow = {
            enabled = false
        },
        blur = {
            enabled = false,
        },
    },
    animations = {
        enabled = false,
    },
    misc = {
        font_family = "Terminess Nerd Font",
    },
    input = {
        touchpad = {
            natural_scroll = true,
            disable_while_typing = false
        }
    }
})

local is_touchpad_enabled = true

function toggle_touchpad()
    if is_touchpad_enabled then
        is_touchpad_enabled = false
        hl.exec_cmd('notify-send -u normal "Disabling Touchpad"')
        hl.device({
            name = "ascp1201:00-093a:3017-touchpad",
            enabled = false
        })
    else
        is_touchpad_enabled = true
        hl.exec_cmd('notify-send -u normal "Enabling Touchpad"')
        hl.device({
            name = "ascp1201:00-093a:3017-touchpad",
            enabled = true
        })
    end
end

hl.bind("SUPER + F2", toggle_touchpad)

hl.on("hyprland.start", function()
    hl.exec_cmd("/home/nickname/.cargo/bin/pwsp-daemon")
    hl.exec_cmd("/usr/bin/pwsp-cli set volume 0.35 && /usr/bin/pwsp-cli set input alsa_input.usb-C-Media_Electronics_Inc._USB_Audio_Device-00.mono-fallback")
end)

require("hyprland.pwsp-binds")

