local thisResourceName = getResourceName(getThisResource())
local isEventHandlersAdded = false
local _createElement = createElement
UIManager2DInstance = UIManager2D()

function eventHandlersOption(theOption)
	_G[theOption..'EventHandler']('onClientGUIMouseDown',getResourceRootElement(getThisResource()),onClientGUIMouseDown_Handler)
	_G[theOption..'EventHandler']('onClientGUIMouseUp',getResourceRootElement(getThisResource()),onClientGUIMouseUp_Handler)
	_G[theOption..'EventHandler']('onClientCursorMove',getRootElement(),onClientCursorMove_Handler)
	_G[theOption..'EventHandler']('onClientElementDestroy',getResourceRootElement(getThisResource()),onClientElementDestroy_Handler)
end

function createElement(...)
	if isEventHandlersAdded == false then
		eventHandlersOption('add')
		isEventHandlersAdded = true
	end
	return _createElement(...)
end

function onClientElementDestroy_Handler()
	local elementType = getElementType(source)
	if UIManager2DInstance[elementType] then
		local mainTexture = callElementMethod(source,"getMainTexture")
		UIManager2DInstance:removeElement(source)
		destroyElement(mainTexture)
	end
	local totalSize = 0
	for className,classTable in pairs(UIManager2DInstance) do 
		local tSize = table.size(classTable)
		totalSize = totalSize + tSize
	end
	if totalSize == 0 then 
		eventHandlersOption('remove')
		isEventHandlersAdded = false
	end
end

function onClientGUIClick_Handler(theButton,keyState,absoluteX,absoluteY)
	local guiElement = UIManager2DInstance:getElementFromTexture(source)
	local className = getElementType(guiElement)
	UIManager2DInstance[className][guiElement]:onClick(theButton,keyState,absoluteX,absoluteY)
end

function onClientGUIMouseDown_Handler(theButton,absoluteX,absoluteY)
	onClientGUIClick_Handler(theButton,'down',absoluteX,absoluteY)
end

function onClientGUIMouseUp_Handler(theButton,absoluteX,absoluteY)
	onClientGUIClick_Handler(theButton,'up',absoluteX,absoluteY)
	UIManager2DInstance:checkForBeingCaptured(theButton,absoluteX,absoluteY)
end

function onClientCursorMove_Handler(_,_,absoluteX,absoluteY)
	UIManager2DInstance:moveElementByCursor(absoluteX,absoluteY)
end

local window = createCustomWindow(100,100,300,200,'Hello World',false)
