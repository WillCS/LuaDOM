local testSuites = {
    "setTest"
}

local totalTests = 0
local totalPassed = 0
local totalFailed = 0

for i, v in ipairs(testSuites) do
    local tests = require("../test/" .. v)

    local numTests = 0
    local numPassed = 0
    local numFailed = 0

    io.write("Running Test Suite " .. v .. "\n\n")

    for name, test in pairs(tests) do
        numTests = numTests + 1
        io.write("-" .. name .. "-\n")
        io.flush()
        local startTime = os.clock()
        local passed, msg = pcall(test)
        local timeTaken = os.clock() - startTime

        if passed then
            numPassed = numPassed + 1
            io.write(" > passed in " .. timeTaken .. " sec\n")
        else
            numFailed = numFailed + 1
            io.write(" > failed in " .. timeTaken .. " sec\n")
            io.write(" >> " .. msg .. "\n")
        end
        io.flush()
    end

    io.write("\n")
    io.write("Passed " .. numPassed .. "/" .. numTests .. "\n\n")
    io.flush()

    totalTests = totalTests + numTests
    totalPassed = totalPassed + numPassed
    totalFailed = totalFailed + numFailed
end

io.write("Testing finished\n")
io.write("Passed " .. totalPassed .. "/" .. totalTests .. "\n")
io.write("Failed " .. totalFailed .. "/" .. totalTests .. "\n")