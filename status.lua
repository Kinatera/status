repeat
    wait()
until game:IsLoaded()
local Camera = game:GetService("Workspace").CurrentCamera
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local ST = game:GetService("Stats")

if status then
    getgenv().Text = Drawing.new("Text")
    Text.Color = Color3.new(0, 1, 1)
    Text.Font = 1
    Text.Outline = true
    Text.OutlineColor = Color3.new(0, 0, 0)
    Text.Position = Vector2.new(0, 0)
    Text.Size = 25
    Text.Text = "Test"
    Text.Visible = false
end

Camera:GetPropertyChangedSignal("ViewportSize"):Connect(
    function()
        local X, Y = Text.TextBounds.X, Text.Position.Y
        Text.Position = Vector2.new(Camera.ViewportSize.X / X, Y)
    end
)

local A =
    RunService.RenderStepped:Connect(
    function(v)
        pcall(
            function()
                if status then
                    Text.Visible = true
                    Text.Text =
                        " Server uptime: " ..
                        math.floor(Workspace.DistributedGameTime) ..
                                                    (" Ping: " ..
                                                        ST.Network.ServerStatsItem["Data Ping"]:GetValueString(
                                                            math.round(2 / v)
                                                        )) ..
                                                        "  " .. ("FPS: " .. math.round(1 / v))

                    Text.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
                elseif not status then
                    Text:Remove()
                end
            end
        )
    end
)
