function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ', '
       end
       return s .. '} '
    else
       return tostring(o)
    end
 end

local xs = {'a' , 'b' , 'c'}
local function reverse(h)
    local r = {}
    for i = #h , 1 , -1 do
        r[#r + 1] = h[i]
    end
    return r
end

local function copy(h)
    local r = {}
    for i = #h , 1 , -1 do
        r = h[i]
    end
    return r
end

print(dump(reverse(xs)))