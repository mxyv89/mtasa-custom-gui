UIWindow = Class("UIWindow",UIGeneral)

function UIWindow:initialize(x,y,width,height,name,isRelative)
	UIGeneral:initialize(x,y,width,height,isRelative)
	-- // Main data
	self.name = name
	self.isMovable = true
	self.isSizable = true
	-- // Properties
	self.headerColor = tocolor(0,128,255)
	self.headerHeight = 18
	self.isCloseButtonAdded = false
	self.resizeBorder = 5
	 -- // Capture element data
	self.captureX = nil
	self.captureY = nil
	self.isMoving = false
	self.isResizeRight = false
	self.isResizeLeft = false
	self.isResizeDown = false
	-- // Element textures
	self.headerTexture = nil
	self.closeButtonTexture = nil
	-- // Other
	self.element = nil
end

function UIWindow:getCaptureData()
	return {
		captureX = self.captureX,
		captureY = self.captureY,
		isMoving = self.isMoving,
		isResizeRight = self.isResizeRight,
		isResizeLeft = self.isResizeLeft,
		isResizeDown = self.isResizeDown
	}
end

function UIWindow:addCloseButton(isAdd)
	self.isCloseButtonAdded = isAdd
end

function UIWindow:setHeaderColor(color)
	self.headerColor = color
end

function UIWindow:setHeaderHeight(height)
	self.headerHeight = height
end

function UIWindow:setMovable(isMovable)
	self.isMovable = isMovable
end

function UIWindow:setSizable(isSizable)
	self.isSizable = isSizable
end

function UIWindow:getHeaderHeight()
	return self.headerHeight
end

function UIWindow:getHeaderColor()
	return self.headerColor
end

function UIWindow:isMovable()
	return self.isMovable
end

function UIWindow:isSizable()
	return self.isSizable
end

function UIWindow:onClick(button,state,cursorX,cursorY)
	self:onGUIClick(button,state,cursorX,cursorY)
	if state == "down" then
		if cursorY <= self.y + self.headerHeight then
			if self.isMovable then
				self.isMoving = true
				self.captureX = cursorX - self.x
				self.captureY = cursorY - self.y
			end
		else
			if self.isSizable then 
				if cursorX > self.x + self.width - self.resizeBorder then 
					self.isResizeRight = true
					self.captureX = self.x + self.width - cursorX
				elseif cursorX < self.x + self.resizeBorder then
					self.isResizeLeft = true
					self.captureX = cursorX - self.x
				end
				if cursorY > self.y + self.height - self.resizeBorder then 
					self.isResizeDown = true
					self.captureY = self.y + self.height - cursorY
				end
			end
		end
		if self.isMoving or self.isResizeRight or self.isResizeLeft or self.isResizeDown then 
			UIManager2DInstance:setCapturedElement(self.element)
		end
	else
		local captElem = UIManager2DInstance:getCapturedElement()
		if captElem then
			self.captureX = nil
			self.captureY = nil
			self.isMoving = false
			self.isResizeRight = false
			self.isResizeLeft = false
			self.isResizeDown = false
			UIManager2DInstance:setCapturedElement(nil)
		end
	end
end

function UIWindow:onMouseMove(cursorX,cursorY)
	self:onGUIMouseMove(cursorX,cursorY)
end

function UIWindow:onMouseEnter(cursorX,cursorY,leftGUI)
	self:onGUIMouseEnter(cursorX,cursorY,leftGUI)
end

function UIWindow:onMouseLeave(cursorX,cursorY,enteredGUI)
	self:onGUIMouseLeave(cursorX,cursorY,enteredGUI)
end