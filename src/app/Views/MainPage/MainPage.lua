--
-- Author: Your Name
-- Date: 2016-10-09 10:23:32
-- 包含顶部的信息栏和底部的操作栏
--
local MainUIModuleBase = import("..Common.MainUIModuleBase")
local BottomPanel = import(".BottomPanel")

--各个主模块
local City = import("..City.City")
local MonHouse = import("..MonHouse.MonHouse")

local MainPage = class("MainPage",MainUIModuleBase)

function MainPage:ctor()
	MainPage.super.ctor(self)

	self.CSBPath = "Csb/MainPage/MainPage.csb"
	self:setCSBNode()
	self.csbNode:setPosition(cc.p(display.cx,display.cy))

	self.bottomPanel = BottomPanel.new(handler(self,self.goMainModule))
	self:addChild(self.bottomPanel,100)
	self.bottomPanel:setPosition(cc.p(display.cx,50))

	--MainPage控制参数
	self.curModule = nil
end

--进入各个子模块
function MainPage:goMainModule(mName)
	local funcName = "go"..mName
	if self[funcName] then 
		local func = handler(self,self[funcName])
		if func then 
			self:removeCurrentModule()
			func()
		end 
	end 
end

function MainPage:removeCurrentModule()
	if self.curModule then 
		self.curModule:removeFromParent()
		self.curModule = nil
	end 
end

function MainPage:goCity()
	self.city = City.new()
	self:addChild(self.city,50)
	self.city:setPosition(display.cx,display.cy)
	self.curModule = self.city
end

function MainPage:goMonHouse()
	self.monHouse = MonHouse.new()
	self:addChild(self.monHouse,50)
	self.curModule = self.monHouse
	self.monHouse:setPosition(display.cx,display.cy)
end


return MainPage