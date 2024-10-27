local sb = require("./commands.lua")
local Utilities = require("../util.lua")

--[[
	Example command and properties:
	https://github.com/Rage-32/discordia-skeleton-bot
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