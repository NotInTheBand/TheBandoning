local espLib = {}

function espLib:drawESP()
    print("DRAWING")
    -- Synapse Only code
    if syn then
        -- Must be ran near start of rs() so it will update properly
        if JSON.esp_Players then
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
                    if JSON.esp_Distance then
                        label.Text = label.Text.. " [".. math.ceil(getMagnitudeFromPlayer(v.Character.Head)).. "]"
                    end

                    if JSON.esp_HP and v.Character.CurrentHealth.Value > 0 then
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