function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
 end

local function add(h, x)
    local i = #h + 1
    h[i] = x
    while i > 1 do
        -- print("INDEX", i)
        local pi = math.floor(i / 2)
        if h[pi] > h[i] then
            -- h[pi], h[i] = h[i], h[pi]
            local tmp = h[i]
            h[i] = h[pi]
            h[pi] = tmp
            i = pi
        else
            break
        end
    end
end

local function pop(h)
    
end

a = {}
add(a, 12)
print(dump(a))
add(a, 10)
print(dump(a))
add(a, 20)
print(dump(a))
add(a, 1)
print(dump(a))