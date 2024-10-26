local Utilities = {}

function string.starts(String,Start)
	return string.sub(String,1,string.len(Start))==Start
end 

function table.count(table)
	local count
	for _, _ in pairs(table) do
		count = count + 1
	end

	return count or 0
end

function Utilities.Reply(msg, txt, embed, mention)
	msg:reply({content = txt, embed = embed or nil, reference = {message = msg, mention = mention or false}})
end

return Utilities