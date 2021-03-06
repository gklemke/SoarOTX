-- 212x64/JF3K/CENTER.lua
-- Timestamp: 2019-09-29
-- Created by Jesper Frickmann

local function Draw(ail, brk)
	soarUtil.InfoBar(" Flaperon centering ")

	lcd.drawText(5, 12, "Use the throttle trim to ", 0)
	lcd.drawText(5, 24, "center the flaperons to", 0)
	lcd.drawText(5, 36, "their maximum reflex", 0)
	lcd.drawText(5, 48, "position (Speed mode).", 0)

	lcd.drawLine(155, 8, 155, LCD_H, SOLID, FORCE)		

	lcd.drawText(164, 12, "Ail")
	lcd.drawNumber(LCD_W, 12, ail, RIGHT)
	lcd.drawText(164, 24, "Brk")
	lcd.drawNumber(LCD_W, 24, brk, RIGHT)
end -- Draw()

return Draw