
local HWButton = class("HWButton", function ()
	local layer = display.newNode()
	return layer
end)

function HWButton:ctor(imgNormal,imgSelected,callBack,bLongPress,longCallBack,longEndCallBack)
	self.callBack = callBack
	self.imgNormal = imgNormal
	self.imgSelected = imgSelected
	self.m_bTouched = false
	self.m_bMoved = false
	self.m_preTouchPt = nil
	self.textLb = nil
	self.bLongPress = bLongPress --长按可以出效果
	self.hasLongPress = false
	self.longCallBack = longCallBack --长按回调
	self.longEndCallBack = longEndCallBack --长按结束回调
	self.isDisable = false
	self.swall = true

	self.btnSp = display.newSprite(imgNormal, 0, 0)
	self:addChild(self.btnSp)

	self:setSelectSacle()

    local function onNodeEvent(event)
        if "enter" == event then
            self:onEnter()
        elseif "exit" == event then
            self:onExit()
        end
    end
    self:registerScriptHandler(onNodeEvent)
end

function HWButton:onExit()

end

function HWButton:onEnter()
	--触摸
    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(handler(self, self.onTouchBegan),cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(handler(self, self.onTouchEnded),cc.Handler.EVENT_TOUCH_ENDED )
    listener:registerScriptHandler(handler(self, self.onTouchMoved),cc.Handler.EVENT_TOUCH_MOVED )
    listener:setSwallowTouches(true)
    
    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)
end


function HWButton:setTouchSwallowed(b)
	self.swall  = b 
	self:setTouchSwallowEnabled(b)
end

function HWButton:setSelectSacle( sc )
	self.sc  = sc or 0.9
end


----Touch------>>>>>
function HWButton:onTouchBegan(touch, event)
      -- distance = touch:getLocation().x - VisibleRect:center().x
    local x = touch:getLocation().x
    local y = touch:getLocation().y 
	local rect = self.bigRect or self.btnSp:getBoundingBox()
	local touchPt = cc.p(x, y)
	touchPt = self:convertToNodeSpace(touchPt)
	local touchWorldPt = cc.p(x,y)

	if cc.rectContainsPoint(rect ,touchPt) == true and self.isDisable == false then
		--print("begin",self:getTag())
		self.hasCallback = false
		self.hasLongPress = false
		self.m_preTouchPt = touchPt
		self.m_preTouchWorldPt = touchWorldPt
		self.m_bMoved = false
		self.m_bTouched = true
		self.btnSp:setScale(self.sc)
		local texture = display.newSprite(self.imgSelected):getTexture()
		self.btnSp:setTexture(texture)
		--self:playerMuiscType()
		if self.bLongPress == true then
			self:schedule(handler(self, self.longPress), 0.3)
		end
		
		return true
	else
		return false
	end

    return true
end

function HWButton:onTouchMoved(touch, event)
    local x = touch:getLocation().x
    local y = touch:getLocation().y 
	local rect = self.bigRect or self.btnSp:getBoundingBox()
	local touchPt = cc.p(x, y)
	touchPt = self:convertToNodeSpace(touchPt)
	local touchWorldPt = cc.p(x,y)

	if self.m_preTouchPt == nil  then
		return
	end

	if  math.abs(touchWorldPt.y - self.m_preTouchWorldPt.y) > 10 or
		math.abs(touchWorldPt.x - self.m_preTouchWorldPt.x) > 10  then
		self.m_bMoved = true
	end
end

function HWButton:onTouchEnded(touch, event)
    local x = touch:getLocation().x
    local y = touch:getLocation().y 
	local rect = self.bigRect or self.btnSp:getBoundingBox()
	local touchPt = cc.p(x, y)
	touchPt = self:convertToNodeSpace(touchPt)
	local touchWorldPt = cc.p(x,y)

	if self.bLongPress == true then
		self:stopAllActions()
	end
   	if self.hasLongPress == true then 
   		self.btnSp:setScale(1.0)
		local texture = display.newSprite(self.imgNormal):getTexture()
		self.btnSp:setTexture(texture)
   		self.longEndCallBack()
		return
	end
	self.btnSp:setScale(1.0)
	local texture = display.newSprite(self.imgNormal):getTexture()
	self.btnSp:setTexture(texture)	
	if cc.rectContainsPoint(rect ,touchPt) == true then
		if self.m_bTouched == true  and
		    self.m_bMoved == false then
	   		self.hasCallback = true
			if self.isOpenGuide ~= true then
				self.callBack(self:getTag())
	   		end
		end
	end
end

----Touch------>>>>>
function HWButton:setText(text,size,color,bOutline,outlineColor,outlinePx)
	self.text = text or ""
	self.textSize = size 
	self.textColor = color
	self.bOutline = bOutline or false
	self.ountlineColor = outlineColor or  cc.c4b(255,255,255,255)
	if self.textLb ~= nil then
		self.textLb:removeFromParent()
	end
	self.textLb = display.newTTFLabel({text = text,
				font = FONTFAMILYNAME ,
				align = cc.TEXT_ALIGNMENT_CENTER,
				color = color,
				size = size})
	if self.bOutline == true then
		self.textLb:enableOutline(self.ountlineColor, outlinePx+2);
		
	end
	self.textLb:setAnchorPoint(cc.p(0.5, 0.5))	
	self.textLb:setPosition(cc.p(self.btnSp:getContentSize().width/2,
								self.btnSp:getContentSize().height/2 + 0))
	self.btnSp:addChild(self.textLb)

end

function HWButton:setTextEx(str)
	if self.textLb then
		self.text = str or ""
		self.textLb:setString(self.text)
		return  self.textLb
	end
end

function HWButton:setNormalImage(filename)
	if filename == self.imgNormal then
		return
	end
	self.imgNormal = filename 
	self.btnSp:removeFromParent()
	self.btnSp = display.newSprite(self.imgNormal, 0, 0)
	self.textLb = nil
	self:addChild(self.btnSp)
	if self.text then 
		self:setText(self.text,self.textSize,self.textColor,self.bOutline,self.ountlineColor,2)
	end
end

function HWButton:setImgSelected(filename)
	self.imgSelected = filename 
end

function HWButton:setImg(filename)
	self:setNormalImage(filename)
	self:setImgSelected(filename)
end

function HWButton:setBtnTextOutColor(color)

	if self.textLb then
		self.textLb:enableOutline(color, 2);
	end

end


function HWButton:setGray()
	self.btnSp:removeFromParent()
	self.btnSp = cc.GraySprite:create(self.imgNormal)
	self.textLb = nil
	self:addChild(self.btnSp)

	if self.text then 
		self:setText(self.text,self.textSize,self.textColor,self.bOutline,self.ountlineColor,2)
	end
end

function HWButton:setFlipX(bFlipX)
	self.btnSp:setFlipX(bFlipX)
end

function HWButton:setBtnOpacity(i)
	self.btnSp:setOpacity(i)
end

function HWButton:showSelectedAnim()
	if self.particle == nil then 
		self.particle = cc.ParticleSystemQuad:create("Particle/btnSelected.plist")
		self.btnSp:addChild(self.particle)
		self.particle:setPosition(5,5)
		self.particle:runAction(
				cc.RepeatForever:create(transition.sequence({
					cc.MoveBy:create(0.3,cc.p(0,self.btnSp:getContentSize().height-10)),
					cc.MoveBy:create(0.4,cc.p(self.btnSp:getContentSize().width-10,0)),
					cc.MoveBy:create(0.3,cc.p(0,-self.btnSp:getContentSize().height+10)),
					cc.MoveBy:create(0.4,cc.p(-self.btnSp:getContentSize().width +10,0))
				})))	
		self.particle:setPositionType(kCCPositionTypeRelative)
	end
end

function HWButton:hideSelectedAnim()
	if self.particle then 
		self.particle:removeFromParent()
		self.particle = nil
	end
end

function HWButton:setBtnEnabled(b)
	self:setTouchEnabled(b)
	if b == false then 
		self.btnSp:removeFromParent()
		self.textLb = nil
		self.btnSp = display.newGraySprite(self.imgNormal)
		self:addChild(self.btnSp)
		if self.text ~= nil then
			self:setText(self.text,self.textSize,self.textColor,self.bOutline,self.ountlineColor,2)
		end
	else 
		self.btnSp:removeFromParent()
		self.textLb = nil
		self.btnSp = display.newSprite(self.imgNormal)
		self:addChild(self.btnSp)
		if self.text ~= nil then
			self:setText(self.text,self.textSize,self.textColor,self.bOutline,self.ountlineColor,2)
		end
	end
end

function HWButton:setBtnDisable(b)
	self.isDisable = b
end

function HWButton:longPress()
	if self.hasCallback == false and self.m_bMoved == false then 
		self.hasLongPress = true
		self.longCallBack(self:getTag())
		self:stopAllActions()
	end
end


-----适配----UIButtonEx----->------------
function HWButton.create(params)

	local  myparams   = params or {}
	local  image      = myparams.image 
	assert(image      ~= nil, string.format("图片不能为空"))
	local  text       = myparams.text or ""
	local  color      = myparams.color or display.COLOR_WHITE 
	local  font       = myparams.font or FONTFAMILYNAME
	local  size       = myparams.size or 35
	local  func       = myparams.func  or function ( event )   end
	local  labOutLine = myparams.labOutLine 
	local  labLinesize   = myparams.labLinesize or 2

	local button  = HWButton.new(image,image,func)
	if labOutLine then
		button:setText(text,size,color,true,labOutLine,labLinesize)
	else
		button:setText(text,size,color,false,labOutLine,labLinesize)		
	end
  
	return button
end

function HWButton:mysetScale( sc )
	self:setScale(sc or 1)
end

function HWButton:mysetScaleX( sc )
	self:setScaleX( sc or 1)
end

function HWButton:mysetScaleY( sc )
	self:setScaleY( sc or 1)
end

function HWButton:setButtonLabelOffset(x, y)

end

-------------<-----------------------------

return HWButton