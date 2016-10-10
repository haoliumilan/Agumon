--
-- Author: Your Name
-- Date: 2016-09-29 19:00:43
--
local BaseNode = require("app.uibase.BaseNode")

local MainNode = class("MainNode",BaseNode)

MainNode.RESOURCE_FILENAME = "csb/MainScene.csb"

function MainNode:ctor()
	MainNode.super.ctor(self)
end

return MainNode

