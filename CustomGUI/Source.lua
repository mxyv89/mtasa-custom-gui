local isEventHandlersAdded = false
local _createElement = createElement
local guiElementSelected = nil
local guiClassSelected = nil
UIManager2DInstance = UIManager2D()

function eventHandlersOption(theOption)
	_G[theOption..'EventHandler']('onClientClick',getRootElement(),onClientClick_Handler)
	_G[theOption..'EventHandler']('onClientMouseMove',getResourceRootElement(getThisResource()),onClientMouseMove_Handler)
	_G[theOption..'EventHandler']('onClientMouseEnter',getResourceRootElement(getThisResource()),onClientMouseEnter_Handler)
	_G[theOption..'EventHandler']('onClientMouseLeave',getResourceRootElement(getThisResource()),onClientMouseLeave_Handler)
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
	local className = getElementType(source)
	if UIManager2DInstance[className] then
		local mainTexture = UIManager2DInstance[className][source]:getMainTexture()
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

function onClientMouseMove_Handler(cursorX,cursorY)
	local element = UIManager2DInstance:getElementFromTexture(source)
	callElementMethod(element,"onMouseMove",cursorX,cursorY)
end

function onClientClick_Handler(theButton,keyState,absoluteX,absoluteY)
	local selectedElem = UIManager2DInstance:getSelectedElement()
	if selectedElem then 
		callElementMethod(selectedElem,"onClick",theButton,keyState,absoluteX,absoluteY)
	end
end

function onClientMouseEnter_Handler(cursorX,cursorY,leftGUI)
	local element = UIManager2DInstance:getElementFromTexture(source)
	callElementMethod(element,"onMouseEnter",cursorX,cursorY,leftGUI)
end

function onClientMouseLeave_Handler(cursorX,cursorY,enteredGUI)
	local element = UIManager2DInstance:getElementFromTexture(source)
	callElementMethod(element,"onMouseLeave",cursorX,cursorY,enteredGUI)
end

function onClientCursorMove_Handler(_,_,absoluteX,absoluteY)
	local captElem = UIManager2DInstance:getCapturedElement()
	if captElem then 
		local className = getElementType(captElem)
		local guiInstance = UIManager2DInstance[className][captElem]
		local captData = guiInstance:getCaptureData()
		local posX,posY = guiInstance:getPosition()
		if className == "UIWindow" then
			if captData.isMoving == true then
				posX = absoluteX - captData.captureX
				posY = absoluteY - captData.captureY
				guiInstance:setPosition(posX,posY)
			else
				local sizeX,sizeY = guiInstance:getSize()
				if captData.isResizeRight == true then
					sizeX = absoluteX - posX + captData.captureX
					guiInstance:setSize(sizeX,sizeY)
				elseif captData.isResizeLeft == true then
					
				end
				if captData.isResizeDown == true then 
					sizeY = absoluteY - posY + captData.captureY
					guiInstance:setSize(sizeX,sizeY)
				end
			end
		end
	end
end

--setTimer(function()
	window = createCustomWindow(200,200,500,500,'Hello World',false)
--end,1000,1)
