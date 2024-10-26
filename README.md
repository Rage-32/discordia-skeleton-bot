# Discordia API Wrapper Skeleton

A lightweight skeleton for building Discord bots in Lua, based on the [Discordia](https://github.com/SinisterRectus/Discordia) library. This template includes a command handler, configuration file, and a help command, making it easy to start developing custom Discord bots.

# Features

- **Command Handler**: Easily add, manage, and execute bot commands.
- **Configuration Support**: Centralize and customize bot settings in a single file.
- **Help Command**: A pre-existing command to display all commands.

# Requirements

- Lua (5.1+)
- [Discordia Library](https://github.com/SinisterRectus/Discordia)
- [Luvit](https://luvit.io/install.html)

# Usage
## Config
- Edit things like prefix, token, status/activity, and bot owner user ID!
- To make config changes of your likings, head over to src/core/config.lua. 
## Command Handler
- Add your commands into `src/core/Commands/RegisterCommands.lua`<br>

Example Command:
```lua
sb.RegisterCommand("commandName", function(message)
 -- do something here
end)
:SetDescription("Test description") -- Set your command description (can by nil)
:SetCooldown(10) -- Set the command cooldown (in seconds) (default 0 if no value)
:SetPermission("kickMembers") -- Set the permissions (can by nil) (https://github.com/SinisterRectus/Discordia/blob/90a80701780523f57b88f5cc70746d4dc47f630d/libs/enums.lua#L171)
:SetBotOwner(true) -- Should this command only be ran by the owner? (default false if no value)
```
```lua
sb.RegisterCommand("ping", function(message)
	Utilities.Reply(message, 'Pong!')
end)
:SetDescription("Ping pong!")
```

# Contributing
Feel free to open issues and submit pull requests to help improve this skeleton.
# Support
For support you can join the Stellar Discord!<br>
[![Discord](https://discord.com/api/guilds/1056023066246914078/widget.png?style=banner2)](https://discord.gg/aZEGSPKQMk)
