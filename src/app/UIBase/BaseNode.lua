--
-- Author: Your Name
-- Date: 2016-09-29 18:43:55
--
local TCSLoader = import(".TCSLoader")

local BaseNode = class("BaseNode",cc.load("mvc").ViewBase)

function BaseNode:ctor()
	BaseNode.super.ctor(self)
	self.CSBPath = "" -- 当前NODE的csb的路径
end

--生成csb的NODE
function BaseNode:setCSBNode()
    local node = TCSLoader:loadCSB(self.CSBPath,self)
    self:addChild(node,10)
end

--封装onEnter 和 onExit的方法
function BaseNode:setNodeEventEnabel()
    local function onNodeEvent(event)
        if "enter" == event then
            self:onEnter()
        elseif "exit" == event then
            self:onExit()
        end
    end
    self:registerScriptHandler(onNodeEvent)
end

--智能跳转
function BaseNode:cfgJump()

end

--显示NODE，区域
function BaseNode:showCoverTint()
	local layerColor = cc.LayerColor:create(cc.c4b(math.random(1,255),math.random(1,255),math.random(1,255),255),display.width,display.height)
	self:addChild(layerColor,50)
end

------------------------------------
-------------Method get-------------
------------------------------------
function BaseNode:getClassName()
	return self.__cname
end

------------------------------------
------------------------------------
------------------------------------

function BaseNode:onEnter()
	
end

function BaseNode:onExit()
	
end



return BaseNode