local Utilities = require("./util.lua")
require("./Commands/RegisterCommands.lua")

local sb = require("./Commands/commands.lua")
local Config = require("./config.lua")
local discordia = require('discordia')

local client = discordia.Client()

local commandCooldowns = { -- Does not save upon bot restarts
	Time = nil,
	CommandId = nil
}

client:on('ready', function()
	client:info('Logged in as '.. client.user.username .. "#" .. client.user.discriminator)

	client:setActivity(Config.Activity)
	client:setStatus(Config.Status)
end)

client:on('messageCreate', function(message)
	if (not string.starts(message.content, Config.Prefix)) then return end

	local commandName = message.content:sub(2):lower()
	local commandsTable = sb.GetCommands()
	local commandObj = sb.GetCommand(commandName)

	-- Check for command aliases
	if not commandObj then
		for _, cmd in pairs(commandsTable) do
			if cmd.Aliases then 
				for _, alias in ipairs(cmd.Aliases) do
					if alias == commandName then
						commandObj = cmd
						break
					end
				end
			end
			if commandObj then break end
		end
	end

	if (not commandObj) then return end

	if (commandObj.BotOwner and message.author.id ~= Config.BotOwnerID) then
		Utilities.Reply(message, "You need to be the Bot Owner to run the command `" .. commandName .. "`.")
		return
	end

	local commandPermission = commandObj.Permission
	if (commandPermission and not message.member:hasPermission(message.channel, commandPermission)) then
		Utilities.Reply(message, "You need permission " .. "`" .. commandPermission .. "` to run command " .. commandName .. "`.")
		return
	end

	if (commandCooldowns[message.author.id] and commandCooldowns[message.author.id].CommandId == commandObj.Id and commandCooldowns[message.author.id].Time > os.time()) then
		Utilities.Reply(message, "You are on cooldown from command " .. "`" .. commandObj.Name .. "`" .. ". You may use it again " .. "<t:" .. commandCooldowns[message.author.id].Time .. ":R>.")
		return
	end

	commandObj.Callback(message)

	if (commandObj.Cooldown ~= nil) then
		commandCooldowns[message.author.id] = {
			Time = os.time() + commandObj.Cooldown,
			CommandId = commandObj.Id
		}
	end

	if (not Config.LogCommands) then return end
	client:info("Ran command '" .. commandName .. "' executed by '" .. message.author.name .. "(" .. message.author.id .. ")' in guild '" .. message.guild.name .. "'")
end)

client:run("Bot " .. Config.Token)