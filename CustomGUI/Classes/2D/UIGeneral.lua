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

function UIGeneral:getMainTexture()
	return self.mainTexture
end

function UIGeneral:setElementTexture(texture)
	self.mainTexture = texture
end

function UIGeneral:onClientGUIClickFixed(theButton,keyState,absoluteX,absoluteY)
	if keyState == 'down' then
		triggerEvent('onClientGUIClick',self.element,theButton,keyState,absoluteX,absoluteY)
	end
end