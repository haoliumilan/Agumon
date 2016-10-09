--
-- Author: Your Name
-- Date: 2016-10-09 15:50:40
-- 机型UI适配策略
--

--[[
	雏形策略
	主要支持分辨率
	640 * 960 iphone4s
	768 * 1024 ipad
	640 * 1136 iphone5s 及以上
	
	1.背景图片 768 * 1136
		a.ipad适配已宽768
		b.其他640
		c.居中显示
	2.上下对齐
	3.弹出框居中
	4.部分细节如列表展示，用公式完成

	CC_DESIGN_RESOLUTION = {
	    width = 640,
	    height = winSize.height * 640/winSize.width,
	    autoscale = "FIXED_WIDTH",
	    callback = function(framesize)
	        -- local ratio = framesize.width / framesize.height
	        -- if ratio <= 1.34 then
	        --     return {autoscale = "SHOW_ALL"}
	        -- end
	    end
	}

]]
local UIAdaption = {}


return UIAdaption