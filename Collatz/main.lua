local function collatz(n)
    while n ~= 1 do
        print(n)
        if n % 2 == 0 then
            n = n / 2
        else
            n = n * 3 + 1
        end
    end
    print(n)
end

collatz(10200000)