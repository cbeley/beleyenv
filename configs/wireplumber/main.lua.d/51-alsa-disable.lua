table.insert(alsa_monitor.rules, {
  matches = {
    {
      { "device.name", "equals", "alsa_card.usb-046d_Logitech_BRIO_5ECB3AF7-03" },
    },
  },
  apply_properties = {
    ["device.disabled"] = true,
  },
})