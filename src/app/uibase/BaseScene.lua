--
-- Author: Your Name
-- Date: 2016-09-29 18:43:42
--
local BaseScene = class("BaseScene",function ( )
	return display.newScene()
end)

function BaseScene:ctor()

end

function BaseScene:onCreate()

end

--加载资源
function BaseScene:loadRes()
	
end

--卸载资源
function BaseScene:unloadRes()

end


return BaseScene