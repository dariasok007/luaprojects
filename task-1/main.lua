local function powers ()
    local num = 0
    local x = 1
    while num < 30 do
        if num % 2 == 1 then
            print(x, num)
        end
        x = x * 2
        num = num + 1
    end
end
powers()

