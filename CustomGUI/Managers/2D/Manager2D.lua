UIManager2D = Class("UIManager2D")

function UIManager2D:initialize()
	self.UIWindow = {}
	self.textures = {}
	self.captured = nil
end

function UIManager2D:getElementFromTexture(texture)
	return self.textures[texture]
end

function UIManager2D:addCapturedElement(element)
	self.captured = element
end

function UIManager2D:addElement(class,element,instance,textures)
	self[class][element] = instance
	for texID = 1,#textures do 
		local guiTexture = textures[texID]
		self.textures[guiTexture] = element
	end
end

function UIManager2D:removeElement(element)
	for tex,elem in pairs(self.textures) do
		if elem == element then
			self.textures[tex] = nil
		end
	end
	local className = getElementType(element)
	self[className][element] = nil
end

function UIManager2D:moveElementByCursor(absoluteX,absoluteY)
	if self.captured then
		local element = self.captured
		local class = getElementType(element)
		local instance = self[class][element]
		local captDiffX,captDiffY = instance:getCapturedDiff()
		if class == 'UIWindow' then
			local posX = absoluteX - captDiffX
			local posY = absoluteY - captDiffY
			self[class][element]:setPosition(posX,posY)
		end
	end
end

function UIManager2D:checkForBeingCaptured(theButton,absoluteX,absoluteY)
	if self.captured then
		local element = self.captured
		if theButton == 'left' then
			local class = getElementType(element)
			self[class][element]:setCapturedDiff(nil,nil)
			self.captured = nil
		end
	end
end