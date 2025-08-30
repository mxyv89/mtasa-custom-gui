function isMouseInPosition ( x, y, width, height )
	if ( not isCursorShowing( ) ) then
		return false
	end
	local sx, sy = guiGetScreenSize ( )
	local cx, cy = getCursorPosition ( )
	local cx, cy = ( cx * sx ), ( cy * sy )
	return ( ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) )
end

function isCursorOverText(posX, posY, sizeX, sizeY)
	if ( not isCursorShowing( ) ) then
		return false
	end
	local cX, cY = getCursorPosition()
	local screenWidth, screenHeight = guiGetScreenSize()
	local cX, cY = (cX*screenWidth), (cY*screenHeight)
	return ( (cX >= posX and cX <= posX+(sizeX - posX)) and (cY >= posY and cY <= posY+(sizeY - posY)) )
end

function table.size(tab)
    local length = 0
    for _ in pairs(tab) do length = length + 1 end
    return length
end

function fromColor(color)
	if color then
		local blue = bitExtract(color, 0, 8)
		local green = bitExtract(color, 8, 8)
		local red = bitExtract(color, 16, 8)
		local alpha = bitExtract(color, 24, 8)
		return { red, green, blue, alpha }
	end
end

function RGBToHex(red, green, blue, alpha)
	if( ( red < 0 or red > 255 or green < 0 or green > 255 or blue < 0 or blue > 255 ) or ( alpha and ( alpha < 0 or alpha > 255 ) ) ) then
		return nil
	end
	if alpha then
		return string.format("#%.2X%.2X%.2X%.2X", red, green, blue, alpha)
	else
		return string.format("#%.2X%.2X%.2X", red, green, blue)
	end
end

function callElementMethod(element,f,...)
	local elementType = getElementType(element)
	local instance = UIManager2DInstance[elementType][element]
	return instance[f](instance,...)
end

function argumentsChecker(funcName,argTable)
	for argID = 1,#argTable do 
		local argVal = argTable[argID][1]
		local argType = argTable[argID][2]
		if type(argVal) ~= argType then
			outputDebugString("Bad argument @'"..funcName.."' expected a "..argType.." at argument "..argID..", got "..type(argVal),1)
			return false
		end
	end
	return true
end