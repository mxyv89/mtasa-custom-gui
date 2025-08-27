local Manager = {}
local Manager_MT = {
	Manager.__index = Manager,
	Manager.__call = function(self,...)
		return self.New(...)
	end
}
setmetatable(Manager,Manager_MT)

function Manager:New()
	
end