local sb = require("./commands.lua")
local Utilities = require("../util.lua")

--[[
	sb.RegisterCommand("commandName", function(message)
		do something here
	end)
	:SetDescription("Test description") -- Set your command description (can by nil)
	:SetCooldown(10) -- Set the command cooldown (in seconds) (default 0 if no value)
	:SetPermission("kickMembers") -- Set the permissions (can by nil) (https://github.com/SinisterRectus/Discordia/blob/90a80701780523f57b88f5cc70746d4dc47f630d/libs/enums.lua#L171)
	:SetBotOwner(true) -- Should this command only be ran by the owner? (default false if no value)
]]

sb.RegisterCommand("ping", function(message)
	Utilities.Reply(message, 'Pong!')
end)
:SetDescription("Ping pong!")

sb.RegisterCommand("help", function(message)
	local commands = sb.GetCommands()

	local embed = {
		title = "Discordia Lua Bot - Help",
		color = 0x000000,
		fields = {},
		author = {
			name = message.guild.name,
			icon_url = message.guild.iconURL
		},
	}

	local count = 0
	for name, obj in pairs(commands) do
		if (obj.Permission and not message.member:hasPermission(message.channel, obj.Permission)) then goto continue end

		count = count + 1
		local desc = obj.Description or "No Description"
		local coolDown = obj.Cooldown or "No Cooldown"

		table.insert(embed.fields, {
			name = name,
			value = "Description: " .. desc .. "\n" .. "Cooldown: " .. coolDown,
		})

		::continue::
	end

	embed.description = "There is a total of `" .. count .. "` commands!"

	Utilities.Reply(message, "test", embed, false)
end)
:SetDescription("Show the commands list.")