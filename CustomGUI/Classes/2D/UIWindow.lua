UIWindow = Class("UIWindow",UIGeneral)

function UIWindow:initialize(x,y,width,height,name,isRelative)
	UIGeneral:initialize(x,y,width,height,isRelative)
	-- // Main
	self.name = name
	self.isMovable = true
	self.isSizable = true
	-- // Properties
	self.headerColor = tocolor(0,128,255)
	self.headerHeight = 18
	self.isCloseButtonAdded = false
	-- // Core
	self.element = nil
	self.headerTexture = nil
	self.closeButtonTexture = nil
	self.captX = nil
	self.captY = nil
end

function UIWindow:setCustomElement(element)
	self.element = element
end

function UIWindow:getMainColor()
	return self.mainColor
end

function UIWindow:getHeaderColor()
	return self.headerColor
end

function UIWindow:getCapturedDiff()
	return self.captX,self.captY
end

function UIWindow:setCapturedDiff(captX,captY)
	self.captX = captX
	self.captY = captY
end

function UIWindow:setPosition(x,y)
	self.x = x
	self.y = y
	guiSetPosition(self.mainTexture,x,y,self.isRelative)
end

function UIWindow:setMovable(isMovable)
	self.isMovable = isMovable
end

function UIWindow:setSizable(isSizable)
	self.isSizable = isSizable
end

function UIWindow:isMovable()
	return self.isMovable
end

function UIWindow:isSizable()
	return self.isSizable
end

function UIWindow:onClick(theButton,keyState,absoluteX,absoluteY)
	self:onClientGUIClickFixed(theButton,keyState,absoluteX,absoluteY)
	if isMouseInPosition(self.x,self.y,self.width,self.headerHeight) then
		if keyState == 'down' then
			local captX = absoluteX - self.x
			local captY = absoluteY - self.y
			self:setCapturedDiff(captX,captY)
			UIManager2DInstance:addCapturedElement(self.element)
		end
	end
end