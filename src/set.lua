local baseSet = {}
baseSet.__index = baseSet

-- If the Lua version supports it, #set returns the size of this set.
function baseSet.__len(table)
    return table.size
end

-- Any attempts to iterate over a set should instead iterate over its
-- members. The method Set.iterator should be used instead of this.
function baseSet.__pairs(table)
    return pairs(table.members)
end

-- Any attempts to iterate over a set should instead iterate over its
-- members. The method Set.iterator should be used instead of this.
function baseSet.__ipairs(table)
    return ipairs(table.members)
end

-- Sets don't support direct indexing. Adding and removing elements must be
-- done with the add and remove methods.
function baseSet.__newIndex(table, key, value)
    -- You're not allowed to put stuff in here
end

-- Extensionality says that any two sets with the same elements are in fact
-- the same set. Rules are rules.
function baseSet.__eq(t1, t2)
    for e in t1:iterator() do
        if not t2:contains(e) then
            return false
        end
    end

    return true
end

-- Checks to see whether or not this set contains the given element.
function baseSet:contains(element)
    return self.members[element]
end

-- Adds the given element to this set. If this set already contains the
-- element, this method does nothing.
function baseSet:add(element)
    if not self:contains(element) then
        self.members[element] = true
        self.size = self.size + 1
    end
end

-- Removes the given element from this set. If this set does not contain
-- the element, this method does nothing.
function baseSet:remove(element)
    if self:contains(element) then
        self.members[element] = false
        self.size = self.size - 1
    end
end

-- Returns a copy of this set.
function baseSet:copy()
    local newSet = new()
    for e in self:iterator() do
        newSet:add(e)
    end

    return new
end

-- Puts every element in the given set into this set. 
function baseSet:unite(set)
    for e in set:iterator() do
        self:add(e)
    end
end

-- Removes every element in this set that is not also in the given set.
function baseSet:intersect(set)
    for e in set:iterator() do
        if not self:contains(e) then
            self:remove(e)
        end
    end
end

-- Removes every element in this set that is also in the given set.
function baseSet:exclude(set)
    for e in set:iterator() do
        if self:contains(e) then
            self:remove(e)
        end
    end
end

-- Used to iterate over every element in this set easily.
function baseSet:iterator()
    return function(k)
        local newK = k
        local actuallyContains = false

        while not (actuallyContains or newK == nil) do
            newK, actuallyContains = next(self.members, newK)
        end

        return newK
    end, nil
end

-- Who doesn't love aliases?
baseSet.include = baseSet.unite
baseSet.addAll = baseSet.unite

baseSet.removeAll = baseSet.exclude

-- Construct a new set object and return it.
local function new()
    local set = {}
    set.size = 0
    set.members = {}

    setmetatable(set, baseSet)

    return set
end

-- Returns the union of the two given sets.
local function union(set1, set2)
    local newSet = set1:copy()
    newSet:unite(set2)
    return newSet
end

-- Returns the intersection of the two given sets.
local function intersection(set1, set2)
    local newSet = set1:copy()
    newSet:intersect(set2)
    return newSet
end

-- Exports <3
Set = {
    new = new,
    union = union,
    intersection = intersection
}