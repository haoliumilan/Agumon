--
-- Author: Your Name
-- Date: 2016-10-09 10:58:58
--
local BaseNode = require("app.UIBase.BaseNode")

local BottomPanel = class("BottomPanel",BaseNode)

function BottomPanel:ctor(callback)
	BottomPanel.super.ctor(self)
	self.CSBPath = "Csb/MainPage/BottomPanel.csb"
	self:setCSBNode()
	self:setButtonCallback()

	self.callback = callback 
end

function BottomPanel:setButtonCallback()
	--战斗 军营 主城 抽奖 任务
	local tb = {[1] = "Fight",[3]= "City",[2]="MonHouse"}
	for i=1,5 do
		local btnName = "ccs".."Button"..i
		self[btnName]:setTag(i)
		TUtil.registerBtnCallback(self[btnName],function ()
			self.callback(tb[i])
		end)
	end
end

return BottomPanel