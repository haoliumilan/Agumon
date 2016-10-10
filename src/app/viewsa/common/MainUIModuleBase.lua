--
-- Author: Your Name
-- Date: 2016-10-09 14:01:09
-- 五个主界面的基类
--
local BaseNode = require("app.uibase.BaseNode")

local MainUIModuleBase = class("MainUIModuleBase",BaseNode)

function MainUIModuleBase:ctor()
	MainUIModuleBase.super.ctor(self)
end

return MainUIModuleBase