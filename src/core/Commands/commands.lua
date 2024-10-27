local ch = {}
local CommandsMeta = {}
local Commands = {}
local CommandsCount = 0

function ch.RegisterCommand(name, callback)
	local command = {
		Id = CommandsCount,
		Name = name,
		Description = nil,
		Aliases = nil,
		Cooldown = nil,
		Permission = nil,
		BotOwner = false,
		Callback = callback
	}

	CommandsCount = CommandsCount + 1

	setmetatable(command, {__index = CommandsMeta})
	Commands[name] = command

	return command
end

function ch.GetCommand(name)
	return Commands[name]
end

function ch.GetCommands()
    return Commands
end

function CommandsMeta:SetDescription(description)
	self.Description = description

	return self
end

function CommandsMeta:SetAliases(aliases)
	self.Aliases = aliases

	return self
end

function CommandsMeta:SetCooldown(seconds)
	self.Cooldown = seconds

	return self
end

function CommandsMeta:SetPermission(permission)
	self.Permission = permission

	return self
end

function CommandsMeta:SetBotOwner()
	self.BotOwner = true

	return self
end

return ch