-- Day 3 of Advent of Code.

function readFile(path)
   local f = io.open(path, "rb")
   if not f then return nil end
   content = {}
   for line in io.lines(path) do
    content[#content + 1] = line
   end
   f:close()
   return content
end


function binaryToNum(string)
    return tonumber(string, 2)
end

function part1(data)

    local strLen = string.len(data[1])

    local firstStr = ""
    local secondStr = ""

    for j = 1, strLen do
        local zero = 0
        local one = 0
        for i = 1, #data do
            if string.byte(data[i], j) == 48 
                then zero = zero + 1
                else one = one + 1
            end
        end
        if zero > one 
            then 
                firstStr = firstStr .. 0
                secondStr = secondStr .. 1
            else 
                firstStr = firstStr .. 1
                secondStr = secondStr .. 0
        end
    end
    
    local firstNum = binaryToNum(firstStr)
    local secondNum = binaryToNum(secondStr)
    return firstNum * secondNum
end

function findMostCommon(data, i)

    local zero = 0
    local one = 0
    for j = 1, #data do
        if string.byte(data[j], i) == 48
            then zero = zero + 1
        elseif string.byte(data[j], i) == 49
            then one = one + 1 
        else 
        end
    end

    if zero == one then return -1
    elseif zero > one then return 0
    else return 1
    end

end

function part2(data)
    local a = makeTable(data, 1, "1", false)
    local b = makeTable(data, 1, "0", true)

    return binaryToNum(a) * binaryToNum(b)
end

function makeTable(data, poz, deafault, invert)

    --Find the most common bit
    bit = findMostCommon(data, poz)

    --if we're searching for opposite, invert the bit
    if invert then
        if bit == -1 then bit = deafault
                elseif bit == 1 then bit = 0
                else bit = 1 end 
    end
    
    if bit == -1 then bit = deafault end

    if #data == 1
        then
        return data[1] end

    newTable = {}
           
    for i = 1, #data do
        if string.byte(data[i], poz) == string.byte(bit, 1) 
            then 
                newTable[#newTable + 1] = data[i]
            else
                end 
        end
    return makeTable(newTable, (poz + 1), deafault, invert)
end


function main()
    local data = readFile("input.txt")
    print(part1(data))
    print(part2(data))

end

main()