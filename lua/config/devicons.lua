require'nvim-web-devicons'.setup {
  -- your personnal icons can go here (to override)
  -- DevIcon will be appended to `name`
  override = {
    js = {
      icon = "󰌞",
      color = "#cbcb41",
      name = "js",
    },
    rake = {
      icon = "",
      color = "#cc3e44",
      name = "Rakefile"
    },
    Rakefile = {
      icon = "",
      color = "#cc3e44",
      name = "Rakefile"
    },
    rb = {
      icon = "",
      color = "#cc3e44",
      name = "Rb"
    },
    jbuilder = {
      icon = "",
      color = "#cc3e44",
      name = "jbuilder"
    },
    Gemfile = {
      icon = "",
      color = "#cc3e44",
      name = "Gemfile"
    },
    lock = {
      icon = "",
      color = "#6d8086",
      name = "lockfile"
    },
    default_icon = {
      icon = "",
      color = "#6d8086",
      name = "Default",
    }
  };
  -- globally enable default icons (default to false)
  -- will get overriden by `get_icons` option
  default = true;
}
