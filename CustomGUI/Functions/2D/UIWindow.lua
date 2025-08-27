function createCustomWindow(x,y,width,height,name,isRelative)
	local checkArgs = argumentsChecker("createCustomWindow",{
										{x,"number"},
										{y,"number"},
										{width,"number"},
										{height,"number"},
										{name,"string"},
										{isRelative,"boolean"}
	})
	if checkArgs then
		 -- // Create element data
		local element = createElement('UIWindow')
		local instance = UIWindow(x,y,width,height,name,isRelative)
		-- // Create static images
		local window = guiCreateStaticImage(x,y,width,height,'Images/BaseTexture.png',isRelative)
		local header = guiCreateStaticImage(0,0,width,instance.headerHeight,'Images/BaseTexture.png',false,window)
		local title = guiCreateLabel(0,0,width,18,name,false,header)
		 -- // Set properties to widgets
		local headerColor = fromColor(instance.headerColor)
		local headerHexColor = RGBToHex(unpack(headerColor)):sub(2,7)
		outputChatBox(headerHexColor)
		guiSetProperty(header,"ImageColours", "tl:FF"..headerHexColor.." tr:FF"..headerHexColor.." bl:FF"..headerHexColor.." br:FF"..headerHexColor)
		 -- // Default widgets settings
		guiLabelSetHorizontalAlign(title,"center")
		guiLabelSetVerticalAlign(title,"center")
		guiSetFont(title,"default-bold-small")
		guiSetAlpha(window,0.8)
		 -- // Save data to manager
		instance:setCustomElement(element)
		instance:setElementTexture(window)
		UIManager2DInstance:addElement('UIWindow',element,instance,{window,header,title})
		return element
	end
	return checkArgs
end

function customWindowSetMovable(element,isMovable)
	assert(getElementType(element) == "UIWindow","Bad argument @'customWindowSetMovable' expected a 'UIWindow' element at argument 1, got "..getElementType(element))
	callElementMethod(element,"setMovable",isMovable)
end

function customWindowSetSizable(element,isSizable)
	assert(getElementType(element) == "UIWindow","Bad argument @'customWindowSetSizable' expected a 'UIWindow' element at argument 1, got "..getElementType(element))
	callElementMethod(element,"setSizable",isSizable)
end

function customWindowIsSizable(element)
	assert(getElementType(element) == "UIWindow","Bad argument @'customWindowIsSizable' expected a 'UIWindow' element at argument 1, got "..getElementType(element))
	return callElementMethod(element,"isSizable")
end

function customWindowIsMovable(element)
	assert(getElementType(element) == "UIWindow","Bad argument @'customWindowIsMovable' expected a 'UIWindow' element at argument 1, got "..getElementType(element))
	return callElementMethod(element,"isMovable")
end