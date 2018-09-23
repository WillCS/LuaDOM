require("../src/set")

tests = {}

function tests.same_equality()
    local set = Set.new()

    assert(set == set, "A set is not equal to itself.")
end

function tests.empty_equality()
    local set1 = Set.new()
    local set2 = Set.new()

    assert(set1 == set2, "Two empty sets are not equal.")
end

function tests.single_equality()
    local set1 = Set.new()
    local set2 = Set.new()

    set1:add(1)
    set2:add(1)

    assert(set1 == set2, "Two sets containing the same element aren't equal.")
end

function tests.multiple_equality()
    local set1 = Set.new()
    local set2 = Set.new()

    for i = 1, 1000000 do
        set1:add(i)
        set2:add(i)
    end

    assert(set1 == set2, "Two sets containing the same four elements aren't equal.")
end

return tests