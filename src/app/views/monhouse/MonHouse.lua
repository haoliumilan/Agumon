--
-- Author: Your Name
-- Date: 2016-10-09 11:45:44
--
local MainUIModuleBase = import("..common.MainUIModuleBase")

local MonHouse = class("MonHouse",MainUIModuleBase)

function MonHouse:ctor()
	MonHouse.super.ctor(self)	
	self.CSBPath = "Csb/MonHouse/MonHouse.csb"
	self:setCSBNode()
end

return MonHouse