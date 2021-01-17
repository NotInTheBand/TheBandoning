local player = game.Players.LocalPlayer

local desiredPlaceId = 6002047566
local version = 1.0
local applicationName = "TB_SFS".. tostring(version)

local SaveName = applicationName.. "_Config_".. player.Name.. ".json" --The name of our file that will be in our exploits workspace folder

--local JSON = getgenv().JSON
-- JSON = game:service'HttpService':JSONDecode(readfile(SaveName)) --This will return a table populated with our contents, so now you could do JSON.DidTeleport and it would print true
--[[
if JSON then
print("JSON FOUND")
end
--]]

local espLib = {}

local espT = {
    syn = {

    }
}

function isSafezone(iPlayer)
    local rv
    local ZoneModule = require(game.ReplicatedStorage.Modules:FindFirstChild("ZoneModule"))
    if iPlayer.Character then
        local hrp = iPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            rv = ZoneModule.SafeZone(hrp.position)
        end
    end
    return rv
end

function getScreenVector2(obj)
    if obj then
        if obj.ClassName == "Part" then
            local camera = workspace.CurrentCamera
            local worldPoint = obj.Position
            local vector, onScreen = camera:WorldToScreenPoint(worldPoint)
            
            local screenPoint = Vector2.new(vector.X, vector.Y)
            local depth = vector.Z
            return {point = screenPoint, depth = depth}
        end
    end
end

function getMagnitudeFromPlayer(obj)
    if obj then
        if player.Character:FindFirstChild("HumanoidRootPart") then
            return (obj.position - player.Character.HumanoidRootPart.position).Magnitude
        end
    end
end

function NumberSuffix(Num)
    local List = {
        "K","M","B","T","Qd","Qn","Sx","Sp","O","N" --List of your suffixes in order of 1000's
        }

    local ListCount = 0
    -- while we're not at the correct suffix do
    while Num / 1000 >= 1 do
        -- increment the suffix from the array
        ListCount = ListCount + 1
        -- divide the number so we can continue with it.
        Num = Num / 1000
    end
    -- if the initial number was < 1000 return the number.
    if ListCount == 0 then
        return Num
    end
    -- returns the number, with the suffix  added at the end
    return math.floor(Num*10)/10 ..List[ListCount].."+"
end



function espLib:drawESP()
    -- Synapse Only code
    if syn then
        -- Must be ran near start of rs() so it will update properly :C
        if true then
            -- ESP
            local pTable = game.Players:GetPlayers()
            for i,v in pairs(espT.syn) do
                v:Remove()
            end
            espT.syn = {
                
            }
            for i,v in pairs(pTable) do
                local screenpoint
                if v.Character then
                    if v.Character:FindFirstChild("Head") and v.Character:FindFirstChild("CurrentHealth") then
                        screenpoint = getScreenVector2(v.Character.Head)
                    end
                end
                if v ~= player and screenpoint and screenpoint.depth > 0 then
                    local label = Drawing.new("Text")

                    label.Text = v.Name
                    if getgenv().JSON.esp_Distance then
                        label.Text = label.Text.. " [".. math.ceil(getMagnitudeFromPlayer(v.Character.Head)).. "]"
                    end

                    if getgenv().JSON.esp_HP and v.Character.CurrentHealth.Value > 0 then
                        label.Text = label.Text.. "\n["..NumberSuffix(v.Character.CurrentHealth.Value) .. "]"
                    elseif getgenv().JSON.esp_HP then
                        label.Text = label.Text.. "\n[DEAD]"
                    end

                    -- Manages Color
                    if isSafeZone(v) then
                        label.Color = Color3.fromRGB(8, 245, 79)
                    elseif v.Character.CurrentHealth.Value > 0 then
                        if v.Character.MaxHealth.Value > player.Character.MaxHealth.Value then
                            label.Color = Color3.fromRGB(235, 135, 42)
                        else
                            label.Color = Color3.fromRGB(42, 103, 235)
                        end
                    else then
                        label.Color = Color3.fromRGB(233, 33, 33)
                    end



                    label.Size = 24
                    label.Center = true
                    label.Outline = true
                    label.OutlineColor = Color3.fromRGB(29, 29, 29)
                    if not getgenv().JSON.ShowSafeZone then
                        if isSafeZone(v) then
                            label.Visible = false
                        end
                    else
                        label.Visible = true
                    end
                    
                    label.Position = screenpoint.point

                    

                    table.insert(espT.syn, label)
                end
            end
        end
    end
end

function espLib:clearESP()
    if #espT.syn > 0 then
        for i,v in pairs(espT.syn) do
            v:Remove()
        end
        espT.syn = {
            
        }
    end
end

function updater5()
    while true do
        JSON = game:service'HttpService':JSONDecode(readfile(SaveName)) --This will return a table populated with our contents, so now you could do JSON.DidTeleport and it would print true
        wait(5)
    end
end

-- spawn(updater10)

return espLib