local espLib = {}

local espT = {
    syn = {

    }
}


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
                    if parent.JSON.esp_Distance then
                        label.Text = label.Text.. " [".. math.ceil(getMagnitudeFromPlayer(v.Character.Head)).. "]"
                    end

                    if parent.JSON.esp_HP and v.Character.CurrentHealth.Value > 0 then
                        label.Text = label.Text.. "\n["..NumberSuffix(v.Character.CurrentHealth.Value) .. "]"
                    elseif JSON.esp_HP then
                        label.Text = label.Text.. "\n[DEAD]"
                    end

                    label.Color = Color3.fromRGB(233, 33, 33)
                    label.Size = 24
                    label.Center = true
                    label.Outline = true
                    label.OutlineColor = Color3.fromRGB(29, 29, 29)
                    label.Visible = true
                    label.Position = screenpoint.point

                    table.insert(espT.syn, label)
                end
            end
        end
    end
end

return espLib