
local image = nil
local height = 600
local width = 600

local function white_noise(t)
    local imageData = love.image.newImageData(width, height)
    for px = 0, width - 1 do
        for py = 0, height - 1 do
            imageData:setPixel(px, py,
                (math.random() * 0.2 + 0.8) * math.sin(px / 100 + t / 3) * math.sin(py / 100 + t / 4) * math.cos(t / 3),
                (math.random() * 0.2 + 0.8)* math.cos(px / 100 + t / 3) * math.cos(py / 100 + t / 4) * math.sin(t / 3),
                (math.random() * 0.2 + 0.8)* math.cos((px + py) / 100) * math.sin(t / 6),
            1)
        end
    end
    image = love.graphics.newImage(imageData)
end

function love.load()
    white_noise(0.0)
end

local t = 0
function love.update(dt)
    t = t + dt
    white_noise(t)
end

function love.draw()
    love.graphics.draw(image, 0, 0)
end