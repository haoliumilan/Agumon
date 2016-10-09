--
-- Author: Your Name
-- Date: 2016-10-08 18:03:46
-- 工具类
--
local TUtil = {}

--封装csb的BUTTON注册回调函数
function TUtil.registerBtnCallback(button,callback)
	button:addTouchEventListener(function(sender, state)
        local event = {x = 0, y = 0}
        if state == 0 then
            event.name = "began"
        elseif state == 1 then
            event.name = "moved"
        elseif state == 2 then
            event.name = "ended"    
            if callback then 
            	callback()
            end 
        else
            event.name = "cancelled"
        end
        event.target = sender
    end)
end

--实现Lua的枚举方法
--@local bt = {"Defaul","Normal"}
--@TUtil.createEnumTable(bt,1)
function TUtil.createEnumTable(tbl, index) 
    local enumtbl = {} 
    local enumindex = index or 0 
    for i, v in ipairs(tbl) do 
        enumtbl[v] = enumindex + i - 1
    end 
    return enumtbl 
end 

return TUtil