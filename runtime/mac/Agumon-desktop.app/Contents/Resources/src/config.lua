
-- 0 - disable debug info, 1 - less debug info, 2 - verbose debug info
DEBUG = 2

-- use framework, will disable all deprecated API, false - use legacy API
CC_USE_FRAMEWORK = true

-- show FPS on screen
CC_SHOW_FPS = true

-- disable create unexpected global variable
CC_DISABLE_GLOBAL = true

local winSize =  cc.Director:getInstance():getWinSize()
-- for module display
CC_DESIGN_RESOLUTION = {
    width = 640,--winSize.width,
    height = winSize.height * 640/winSize.width,
    autoscale = "FIXED_WIDTH",
    callback = function(framesize)
        -- local ratio = framesize.width / framesize.height
        -- if ratio <= 1.34 then
        --     return {autoscale = "SHOW_ALL"}
        -- end
    end
}


--设置是否DEBUG模式
TDEBUG = true