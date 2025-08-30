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
	return false
end

function customWindowSetMovable(element,isMovable)
	local checkArgs = argumentsChecker("customWindowSetMovable",{
										{element,"UIWindow"},
										{isMovable,"boolean"}
	})
	if checkArgs then
		callElementMethod(element,"setMovable",isMovable)
		return true
	end
	return false
end

function customWindowSetSizable(element,isSizable)
	local checkArgs = argumentsChecker("customWindowSetSizable",{
										{element,"UIWindow"},
										{isSizable,"boolean"}
	})
	if checkArgs then 
		callElementMethod(element,"setSizable",isSizable)
		return true
	end
	return false
end

function customWindowIsSizable(element)
	local checkArgs = argumentsChecker("customWindowIsSizable",{
										{element,"UIWindow"}
	})
	if checkArgs then
		callElementMethod(element,"isSizable")
		return true
	end
	return false
end

function customWindowIsMovable(element)
	local checkArgs = argumentsChecker("customWindowIsMovable",{
										{element,"UIWindow"}
	})
	if checkArgs then
		callElementMethod(element,"isMovable")
		return true
	end
	return false
end