-- Day 3 of Advent of Code.
-- At the time of writing I wasn't experienced with Lua, therefore the solutions is less than ideal

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

--Ugly solution
function part2(data, data2)

    a = makeTable(data, 1, "1")
    b = makeTable2(data2, 1, "0")

    -- print(a .. " " .. b)


end

-- for some reasion this recursions does not return the table even though the return part is called
function makeTable(data, poz, deafault)

    bit = findMostCommon(data, poz)
    if bit == -1 then bit = deafault end

    if #data == 1
        then
            -- print( binaryToNum(data[1])) 
            _G.first = data[1]
        return data[1] end

    newTable = {}
           
    for i = 1, #data do
        if string.byte(data[i], poz) == string.byte(bit, 1)
            then 
                newTable[#newTable + 1] = data[i]
            else
                end 
        end
    makeTable(newTable, (poz + 1), deafault)
end

--Not ideal solution
function makeTable2(data, poz, deafault)


   
    bit = findMostCommon(data, poz)
    if bit == -1 then bit = deafault
    elseif bit == 1 then bit = 0
    else bit = 1 end 
    if #data == 1
        then
            -- print( binaryToNum(data[1])) 
            _G.second = data[1]
        return data end

    newTable = {}
           
    for i = 1, #data do
        if string.byte(data[i], poz) == string.byte(bit, 1)
            then 
                newTable[#newTable + 1] = data[i]
            else end 
    end
    makeTable2(newTable, (poz + 1), deafault)
end


function main()
    local data = readFile("input.txt")
    print(part1(data))
    local data2 = readFile("input.txt")
    part2(data, data2)
    print("\n\n\n" .. binaryToNum(_G.first) * binaryToNum(_G.second))

end

main()