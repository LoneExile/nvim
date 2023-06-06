# nvim

> top bar [TMUX](https://github.com/LoneExile/dotfiles/blob/main/.tmux.conf)

![2023-04-29_17-11](https://user-images.githubusercontent.com/82561297/235297373-37da0035-7280-42b6-81c8-92911c0b92c5.png)
![2023-04-29_17-04](https://user-images.githubusercontent.com/82561297/235297100-d2535c59-0299-4e52-8d51-acdf4b72e056.png)
![2023-04-29_17-08](https://user-images.githubusercontent.com/82561297/235297225-a4184b69-86c7-4e27-8e7d-757a49f0865e.png)
![2023-04-29_17-15](https://user-images.githubusercontent.com/82561297/235297549-1ce0183c-d03b-4d44-a634-30eb6e3f2767.png)
![2023-04-30_17-20](https://user-images.githubusercontent.com/82561297/235347973-8e1b7b26-2117-4902-b3ac-72c473aae185.png)

## How to use this configuration

By default, `.config/nvim/init.lua` should be set up like this:

```lua
require('<YOUR_CONFIG_NAME>').setup({
  plugin = 'minimal',
})

```

The `plugin` option can be one of the following from this directory:
`.config/nvim/lua/<YOUR_CONFIG_NAME>/core/settings/plugins/`

You're also free to change `<YOUR_CONFIG_NAME>` to any name you prefer. Adjust
the path `.config/nvim/lua/<YOUR_CONFIG_NAME>/` accordingly, and the
configuration will automatically load based on the name you've set.
