local zmeika = {
    tail = {
        {x = 20, y = 20},
        {x = 19, y = 20}
    },
    color = { r = 248/255, g = 190/255, b = 192/255 },
    dir = {x = 1, y = 0},
    speed = 41 * 15 / 5,
    dist = 0,
}

CHERRIES_PER_SECOND = 1 / 10

local cherries = {
    list = {{x = 10, y = 10}},
    color = { r = 1, g = 0, b = 0},
}

local NX = 41
local NY = 41

local SQUARE_SIZE = 15
local FIELD_X0 = 100
local FIELD_Y0 = 50

function love.load()
    love.window.setMode(800, 800, {
        resizable=false, vsync=true, minwidth=800, minheight=600, highdpi = true,
    })
end

local function add_cherry()
    local x = love.math.random(NX - 1)
    local y = love.math.random(NY - 1)
    print(x, y)
    cherries.list[#cherries.list+1] = { x = x, y = y }
end

local function draw_cherries()
    love.graphics.setColor(cherries.color.r, cherries.color.g, cherries.color.b)
    for index, cherry in ipairs(cherries.list) do
        local x = cherry.x * SQUARE_SIZE + FIELD_X0 + SQUARE_SIZE / 2
        local y = cherry.y * SQUARE_SIZE + FIELD_Y0 + SQUARE_SIZE / 2
        love.graphics.circle("fill", x, y, SQUARE_SIZE/2)
    end
end

local function draw_field()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle('line',
        FIELD_X0,
        FIELD_Y0,
        NX * SQUARE_SIZE,
        NY * SQUARE_SIZE
    )
end

local function draw_zmeika(zmeika)
    love.graphics.setColor(zmeika.color.r, zmeika.color.g, zmeika.color.b)
    for i, p in ipairs(zmeika.tail) do
        local x = p.x * SQUARE_SIZE + FIELD_X0
        local y = p.y * SQUARE_SIZE + FIELD_Y0
        love.graphics.rectangle('fill', x, y, SQUARE_SIZE, SQUARE_SIZE)
    end
end

local function move_zmeika(zmeika)
    local keep_tail = false
    local head = {
        x = zmeika.tail[1].x + zmeika.dir.x,
        y = zmeika.tail[1].y + zmeika.dir.y,
    }
    for i = 1, #cherries.list do
        local c = cherries.list[i]
        if c.x == head.x and c.y == head.y then
            keep_tail = true
            for j = i, #cherries.list - 1 do
                cherries.list[j] = cherries.list[j+1]
            end
        end
    end
    for i = #zmeika.tail, 1, -1 do
        zmeika.tail[i + 1] = zmeika.tail[i]
    end
    zmeika.tail[1] = head
    if not keep_tail then
        zmeika.tail[#zmeika.tail] = nil
    end
end

function love.keypressed(key, scancode, isrepeat)
    if key == "left" then
        if zmeika.dir.x == 1 then
            zmeika.dir.x = 0
            zmeika.dir.y = -1
        elseif zmeika.dir.y == -1 then
            zmeika.dir.y = 0
            zmeika.dir.x = -1
        elseif zmeika.dir.x == -1 then
            zmeika.dir.x = 0
            zmeika.dir.y = 1
        elseif zmeika.dir.y == 1 then
            zmeika.dir.y = 0
            zmeika.dir.x = 1
        end
    end

    if key == "right" then
        if zmeika.dir.x == 1 then
            zmeika.dir.x = 0
            zmeika.dir.y = 1
        elseif zmeika.dir.y == 1 then
            zmeika.dir.y = 0
            zmeika.dir.x = -1
        elseif zmeika.dir.x == -1 then
            zmeika.dir.x = 0
            zmeika.dir.y = -1
        elseif zmeika.dir.y == -1 then
            zmeika.dir.y = 0
            zmeika.dir.x = 1
        end
    end
end

function love.update(dt)
    zmeika.dist = zmeika.dist + zmeika.speed * dt
    if zmeika.dist > SQUARE_SIZE then
        move_zmeika(zmeika)
        zmeika.dist = zmeika.dist - SQUARE_SIZE
    end
    -- p * 1 / dt == CHERRIES_PER_SECOND
    if #cherries.list == 0 then
        add_cherry()
    end
end

function love.draw()
    draw_field()
    draw_cherries()
    draw_zmeika(zmeika)
end
