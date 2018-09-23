require("../src/set")

tests = {}

function tests.add()
    local set = Set.new()
    
    set:add(1)

    assert(set.size == 1, "Adding an element to a set does not properly change its size.")
    assert(set:contains(1), "Adding an element to a set does not make it contain that element.")
end

function tests.remove()
    local set = Set.new()
    
    set:add(1)
    set:remove(1)

    assert(set.size == 0, "Removing an element from a set does not properly change its size.")
    assert(not set:contains(1), "Sets still contain elements after they are removed.")
end

function tests.copy()
    local set = Set.new()
    
    set:add(1)

    local copy = set:copy()
    
    assert(set == copy, "A set is not equal to a copy of itself.")

    copy:remove(1)

    assert(set ~= copy, "Changes made to a copy affect the original set.")
end

function tests.same_equality()
    local set = Set.new()

    assert(set == set, "Sets are not equal to themselves.")
end

function tests.empty_equality()
    local set1 = Set.new()
    local set2 = Set.new()

    assert(set1 == set2, "Empty sets are not equal.")
end

function tests.single_equality()
    local set1 = Set.new()
    local set2 = Set.new()

    set1:add(1)
    set2:add(1)

    assert(set1 == set2, "Sets containing the same element are not equal.")
end

function tests.multiple_equality()
    local set1 = Set.new()
    local set2 = Set.new()

    for i = 1, 1000000 do
        set1:add(i)
        set2:add(i)
    end

    assert(set1 == set2, "Sets with the same contents are not equal.")
end

function tests.iterate()
    local set = Set.new()
    
    for i = 1, 10 do
        set:add(i)
    end

    local newSet = Set.new()

    for e in set:iterator() do
        newSet:add(e)
    end

    assert(set == newSet, "Not every element in a set is iterated.")
end

function tests.union()
    local set1 = Set.new()
    local set2 = Set.new()

    set1:add(1)
    set2:add(2)

    local union = Set.union(set1, set2)
    assert(union.size == 2, "Union does not resize properly.")
    assert(union:contains(1), "Union does not include the correct elements.")
end

function tests.intersection()
    local set1 = Set.new()
    local set2 = Set.new()

    set1:add(1)
    set1:add(2)

    set2:add(2)
    set2:add(3)

    local intersection = Set.intersection(set1, set2)
    assert(intersection.size == 1, "Intersection does not resize properly.")
    assert(intersection:contains(2), "Intersection does not retain the correct elements.")
    assert(not intersection:contains(1), "Intersection does not remove the correct elements.")
end

function tests.exclusion()
    local set1 = Set.new()
    local set2 = Set.new()

    set1:add(1)
    set1:add(2)

    set2:add(2)

    set1:exclude(set2)
    assert(set1.size == 1, "Exclusion does not resize properly.")
    assert(set1:contains(1), "Exclusion does not retain the correct elements.")
    assert(not set1:contains(2), "Exclusion does not remove the correct elements.")
end

return tests