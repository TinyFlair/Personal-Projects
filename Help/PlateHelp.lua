-- by: @TinyFlairr 5/15/24 4:00pm.

local TweenService = game:GetService('TweenService')

local Plate = script.Parent

local startingPosition = Vector3.new(0, 3, 0)
local goalPosition  = Vector3.new(10, 3, 0)

local movingPart_TweenInfo = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true, 1)

local debounce = false

local function whenHopped(object)
    if not object then return end -- Stops code from running if object is not passed

    -- Sets properties
    Plate.Anchored  = true
    Plate.Position = startingPosition
    
    -- Tween stuff
    local movingPart_Tween = TweenService:Create(Plate, movingPart_TweenInfo, {Position = goalPosition})
    movingPart_Tween:Play()

    -- Unless you do movingPart_Tween:Stop() the tween will now continue running endlessly. The next 2 lines are just incase you do decide to do movingPart_Tween:Stop()

    movingPart_Tween.Completed:Wait()
    debounce = false
end

-- Now before the plate can be touched we need to set some more properties.

Plate.CanTouch = true
Plate.CanCollide = true -- Setting collisions to true assuming this is what is prefered.

-- Callbacks

Plate.Touched:Connect(function(object)
    if not object then return end -- Once again, will stop the code if no object was found or in other words object = nil
   
    if object.Parent:FindFirstChildWhichIsA('Humanoid') then
        if debounce == false then -- You could also do if not debounce but this way usually makes more sense to me.

            debounce = true

            whenHopped(object)
        end
    end
end)


-- Note: This code hasn't been tested, if any issues occur contact me @TinyFlairr, goodluck!