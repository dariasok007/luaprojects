local i = 0
local h = {}
function fib(n)
    if h[n] ~= nil then
        return h[n]
    end
    i = i + 1
    if n == 0 or n == 1 then
        h[n] = 1
        return 1
    end
    h[n] = fib(n - 1) + fib(n - 2)
    return h[n]
end

print(fib(500), i)