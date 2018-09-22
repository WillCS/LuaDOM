local tests = {
    "setTest"
}

for i, v in ipairs(tests) do
    require("../test/" .. v)()
end