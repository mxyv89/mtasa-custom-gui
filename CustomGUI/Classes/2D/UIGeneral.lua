UIGeneral = Class("UIGeneral")

function UIGeneral:initialize(x,y,width,height,isRelative)
	-- // Main
	self.x = x
	self.y = y
	self.width = width
	self.height = height
	self.isRelative = isRelative
	-- // Properties
	self.mainColor = tocolor(255,255,255,204)
	-- // Core
	self.mainTexture = nil
end

function UIGeneral:getPosition()
	return self.x,self.y
end

function UIGeneral:getSize()
	return self.width,self.height
end

function UIGeneral:setPosition(x,y)
	self.x = x
	self.y = y
	guiSetPosition(self.mainTexture,x,y,self.isRelative)
end

function UIGeneral:setSize(width,height)
	self.width = width
	self.height = height
	guiSetSize(self.mainTexture,width,height,self.isRelative)
end

function UIGeneral:getMainColor()
	return self.mainColor
end

function UIGeneral:setCustomElement(element)
	self.element = element
end

function UIGeneral:getMainTexture()
	return self.mainTexture
end

function UIGeneral:setElementTexture(texture)
	self.mainTexture = texture
end

function UIGeneral:onGUIMouseMove(cursorX,cursorY)
	triggerEvent('onCustomGUIMouseMove',self.element,cursorX,cursorY)
end

function UIGeneral:onGUIMouseEnter(cursorX,cursorY,leftGUI)
	UIManager2D:setSelectedElement(self.element)
	triggerEvent('onCustomGUIMouseEnter',self.element,cursorX,cursorY,leftGUI)
end

function UIGeneral:onGUIMouseLeave(cursorX,cursorY,enteredGUI)
	UIManager2D:setSelectedElement(nil)
	triggerEvent('onCustomGUIMouseLeave',self.element,cursorX,cursorY,enteredGUI)
end

function UIGeneral:onGUIClick(button,state,absoluteX,absoluteY)
	triggerEvent('onCustomGUIClick',self.element,button,state,absoluteX,absoluteY)
end