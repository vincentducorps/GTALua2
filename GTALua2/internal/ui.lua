-- Simple ui implementation
ui = {}

-- Variables for tracking text position of DrawTextBlock
ui.TextBlockInfo = {
	TextX = 0,				-- X coordinate for tracking DrawTextBlock
	TextY = 0,				-- Y coordinate for tracking DrawTextBlock
	TextFont = 0,
	TextScale = .3,
	TextColor = COLOR_WHITE,
	TextBlink = false
}

-- Draws a text onscreen with the option to have it blink
function ui.DrawTextUI(text, x, y, font, scale, color, blink)
	font = font or FontChaletComprimeCologne
	scale = scale or .5
	color = color or {r=255, g=255, b=255, a=255}

	local draw = not blink

	if math.floor(game.GetSeconds()/10)%2 == 0 or draw then
		natives.UI.SET_TEXT_FONT(font)
		natives.UI.SET_TEXT_SCALE(0.0, scale)
		natives.UI.SET_TEXT_COLOUR(color.r, color.g, color.b, color.a)
		natives.UI.SET_TEXT_CENTRE(false)
		natives.UI.SET_TEXT_OUTLINE()
		natives.UI.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
		natives.UI.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(string.format("%s",text))
		natives.UI.END_TEXT_COMMAND_DISPLAY_TEXT(x, y)
	end
end

-- Draws a text block
function ui.DrawTextBlock(text, x, y, font, scale, color, blink, increment)
	ui.TextBlockInfo.TextX = x or ui.TextBlockInfo.TextX
	ui.TextBlockInfo.TextY = y or ui.TextBlockInfo.TextY
	ui.TextBlockInfo.TextFont = font or ui.TextBlockInfo.TextFont
	ui.TextBlockInfo.TextScale = scale or ui.TextBlockInfo.TextScale
	ui.TextBlockInfo.TextColor = color or ui.TextBlockInfo.TextColor
	if blink~=nil then
		ui.TextBlockInfo.TextBlink = blink
	end
	ui.DrawTextUI(text, ui.TextBlockInfo.TextX, ui.TextBlockInfo.TextY, ui.TextBlockInfo.TextFont, ui.TextBlockInfo.TextScale, ui.TextBlockInfo.TextColor, ui.TextBlockInfo.TextBlink)
	if not increment then
		ui.TextBlockInfo.TextY = ui.TextBlockInfo.TextY + (ui.TextBlockInfo.TextScale/20)
	else
		ui.TextBlockInfo.TextY = ui.TextBlockInfo.TextY + increment
	end
end

-- Prints a message above the game map
function ui.MapMessage(text)
	natives.UI.SET_TEXT_OUTLINE()
	natives.UI._SET_NOTIFICATION_TEXT_ENTRY("STRING")
	natives.UI.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(string.format("%s",text))
	natives.UI._DRAW_NOTIFICATION(false, false)
end

-- Reads a line from the onscreen keyboard
function ui.OnscreenKeyboard(title, size)
	size = size or 20
	natives.GAMEPLAY.DISPLAY_ONSCREEN_KEYBOARD(1, "", "", "", "", "", "", size)
	while (natives.GAMEPLAY.UPDATE_ONSCREEN_KEYBOARD() == 0) do 
		Wait(10)
		if title then
			ui.DrawTextUI(title, .3, .36)
		end
	end
	return natives.GAMEPLAY.GET_ONSCREEN_KEYBOARD_RESULT()
end

-- Draws a 3D point
function ui.Draw3DPoint(p, size, color, blink)
	size = size or 1
	local cx = color or COLOR_RED
	local cy = color or COLOR_GREEN
	local cz = color or COLOR_BLUE
	local offset = size/2
	local px1 = p.x-offset
	local px2 = p.x+offset
	local py1 = p.y-offset
	local py2 = p.y+offset
	local pz1 = p.z-offset
	local pz2 = p.z+offset
	-- X line
	ui.Draw3DLine({x=px1, y=p.y, z=p.z}, {x=px2, y=p.y, z=p.z}, cx, blink)
	-- Y line
	ui.Draw3DLine({x=p.x, y=py1, z=p.z}, {x=p.x, y=py2, z=p.z}, cy, blink)
	-- Z line
	ui.Draw3DLine({x=p.x, y=p.y, z=pz1}, {x=p.x, y=p.y, z=pz2}, cz, blink)
end

-- Draws a 3D line
function ui.Draw3DLine(p1, p2, color, blink)
	color = color or COLOR_WHITE
	local draw = not blink
	if math.floor(game.GetSeconds()/10)%2 == 0 or draw then
		natives.GRAPHICS.DRAW_LINE(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z, color.r, color.g, color.b, color.a)
	end
end

