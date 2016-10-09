require("app.init")

local MyApp = class("MyApp", cc.load("mvc").AppBase)

function MyApp:onCreate()
    math.randomseed(os.time())
end

function MyApp:run()
	local scene = require("app.views.MainScene").new()
   	display.runScene(scene)
end

return MyApp
