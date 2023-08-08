-- Observer v1.0
-- Spirit Dice Productions
-- 2023
-- Load to _G

local Observer = {}
Observer.__index = Observer

Observer.new = function(Value)
    if Value == nil then warn("Observer Error - Code 1") return end
    local self = setmetatable({},Observer)
    self.OBSValue = Value
    self.Connections = {}
    return self
end

Observer.set = function(self,Value)
    if self == nil or Value == nil then warn("Observer Error - Code 2") return end
    if self.OBSValue ~= Value then
        self.OBSValue = Value
        for index,OBSfunction in pairs(self.Connections) do
            OBSfunction(self)
        end
    end
end

Observer.connect = function(self,ConName,ConFunc)
    if self == nil or ConName == nil or ConFunc == nil then warn("Observer Error - Code 3") return end
    self.Connections[ConName] = ConFunc
end

Observer.disconnect = function(self,ConName)
    if self == nil or ConName == nil then warn("Observer Error - Code 4") return end
    self.Connections[ConName] = nil
end

Observer.disconnectAll = function(self)
    if self == nil then warn("Observer Error - Code 5") return end
    table.clear(self.Connections)
end

Observer.destroy = function(self,Silent)
    if self == nil then warn("Observer Error - Code 6") return end
    if Silent == nil or Silent == true then
        print("Object Destroyed - " .. self.OBSValue)
    end
    self = nil
end

return Observer
