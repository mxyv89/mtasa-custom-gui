UIManager2D = Class("UIManager2D")

function UIManager2D:initialize()
	-- // Classes
	self.UIWindow = {}
	self.UIEdit = {}
	self.UIComboBox = {}
	-- // Texture Data
	self.texturesData = {}
	-- // Other global data
	self.capturedElement = nil
	self.selectedElement = nil
end

function UIManager2D:setCapturedElement(element)
	self.capturedElement = element
end

function UIManager2D:getCapturedElement()
	return self.capturedElement
end

function UIManager2D:setSelectedElement(element)
	self.selectedElement = element
end

function UIManager2D:getSelectedElement()
	return self.selectedElement
end

function UIManager2D:getElementFromTexture(texture)
	return self.texturesData[texture]
end

function UIManager2D:addElement(class,element,instance,textures)
	self[class][element] = instance
	for texID = 1,#textures do 
		local guiTexture = textures[texID]
		self.texturesData[guiTexture] = element
	end
end

function UIManager2D:removeElement(element)
	for tex,elem in pairs(self.texturesData) do
		if elem == element then
			self.texturesData[tex] = nil
		end
	end
	local className = getElementType(element)
	self[className][element] = nil
end