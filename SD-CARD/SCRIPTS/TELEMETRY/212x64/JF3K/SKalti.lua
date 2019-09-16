-- 212x64/JF3Kalti/SK.lua
-- Timestamp: 2019-09-14
-- Created by Jesper Frickmann

plugin.heightInt = 4 -- Interval for recording heights

local DrawGraph = ...

-- Convert time to minutes and seconds
local function MinSec(t)
	local m = math.floor(t / 60)
	return m, t - 60 * m
end -- MinSec()

local function Draw()
	local att
	
	DrawMenu(sk.taskName)
	DrawGraph(DOTTED)
	
	-- Timers
	lcd.drawText(LCD_W - 46, 15, "F")
	
	if sk.flightTimer < 0 then
		att = BLINK + INVERS
	else
		att = 0
	end
	
	lcd.drawTimer(LCD_W, 12, sk.flightTimer, MIDSIZE + RIGHT + att)

	lcd.drawText(LCD_W - 46, 33, "W")
	
	if sk.state == sk.STATE_FINISHED then
		att = BLINK + INVERS
	else
		att = 0
	end
	
	lcd.drawTimer(LCD_W, 30, sk.winTimer,  MIDSIZE  + RIGHT + att)

	-- QR and EoW
	if sk.eowTimerStop then
		lcd.drawText(LCD_W - 18, 48, "EoW", SMLSIZE + INVERS)
	end
	
	if sk.quickRelaunch then
		lcd.drawText(LCD_W - 33, 48, "QR", SMLSIZE + INVERS)
	end

	if plugin.launchHeight > 0 then
		lcd.drawText(126, 56, string.format("Launch %i m", plugin.launchHeight))
	end
	
	-- Scores
	for i = 1, sk.taskScores do
		local dy = 14
		
		if i > #sk.scores then
			lcd.drawText(126, dy * i, string.format("%i. - - -", i))
		elseif plugin.unit == "s" then
			lcd.drawText(126, dy * i, string.format("%i. %02i:%02i", i, MinSec(sk.scores[i].time)))
		else
			lcd.drawText(126, dy * i, string.format("%i. %4i%s", i, sk.scores[i].gain, plugin.unit))
		end
	end
end  --  Draw()
	
local function PromptScores()
	DrawMenu(" " .. sk.taskName .. " ")
	lcd.drawText(38, 15, "Save scores?", DBLSIZE)
	lcd.drawText(4, LCD_H - 16, "EXIT", MIDSIZE + BLINK)
	lcd.drawText(LCD_W - 3, LCD_H - 16, "SAVE", MIDSIZE + BLINK + RIGHT)
end -- PromptScores()

local function NotifyStopWindow()
	DrawMenu(" " .. sk.taskName .. " ")
	lcd.drawText(38, 18, "Stop window timer", MIDSIZE)
	lcd.drawText(38, 40, "before leaving task.", MIDSIZE)
end -- NotifyStopWindow()

local function NotifyStopFlight()
	DrawMenu(" " .. sk.taskName .. " ")
	lcd.drawText(30, 18, "Stop the flight timer", MIDSIZE)
	lcd.drawText(30, 40, "before pausing window.", MIDSIZE)
end -- NotifyStopFlight()

return Draw, PromptScores, NotifyStopWindow, NotifyStopFlight