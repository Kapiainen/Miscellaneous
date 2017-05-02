function Initialize()
	local hFile = io.open(SKIN:GetVariable('@') .. 'timestamp.txt', 'r')
	if hFile ~= nil then
		hFile:close()
	else
		SetTimestamp('')
	end
end

function Update()
	if GetTimestamp() ~= nil then
		SKIN:Bang('[!SetVariable "ContextTitleSkinStatus" "Deactivate"]')
	end
end

function ToggleSkin()
	if GetTimestamp() == nil then
		SetTimestamp(0)
		SKIN:Bang('[!SetVariable "ContextTitleSkinStatus" "Deactivate"][!UpdateMeasure "OSUptime"]')
	else
		SetTimestamp('')
		SKIN:Bang('[!SetVariable "ContextTitleSkinStatus" "Activate"]')
	end
end

function LoadRandomLayout(anUptime, abOverride)
	local nBootTime = os.time() - anUptime
	abOverride = abOverride or false
	if not abOverride then
		local nOldTimestamp = GetTimestamp()
		if nOldTimestamp == nil then
			return
		end
		if math.abs(nBootTime - nOldTimestamp) < 10 then
			return
		end
	end
	if SetTimestamp(nBootTime) then
		local tLayouts = { -- Add layouts to this table
			'Layout1',
			'Layout2',
			'Layout3'
		}
		SKIN:Bang('[!LoadLayout "' .. tLayouts[math.random(#tLayouts)] .. '"]')
	end
end

function GetTimestamp()
	local hFile = io.open(SKIN:GetVariable('@') .. 'timestamp.txt', 'r')
	if hFile ~= nil then
		local nTimestamp = tonumber(hFile:read('*l'))
		hFile:close()
		return nTimestamp
	end
	return nil
end

function SetTimestamp(anTimestamp)
	local hFile = io.open(SKIN:GetVariable('@') .. 'timestamp.txt', 'w')
	if hFile ~= nil then
		hFile:write(anTimestamp)
		hFile:close()
		return true
	end
	return false
end
