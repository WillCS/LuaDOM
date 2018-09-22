local baseNode = {}

local function new()
    local node = {}

    node.attributes = {}
    node.readonly = {}

    local meta = {}
    meta.__index = node.attributes
    meta.__newindex = node.attributes
    setmetatable(node, meta)
    
    local attributeMeta = {}
    attributeMeta.__index = node.readonly
    setmetatable(node.attributes, attributeMeta)

    local readonlyMeta = {}
    readonlyMeta.__index = baseNode
    setmetatable(node.readonly, readonlyMeta)

    return node
end

Node = {
    -- Type Constants
    ELEMENT_NODE = 1,
    ATTRIBUTE_NODE = 2
    TEXT_NODE = 3,
    CDATA_SECTION_NODE = 4,
    ENTITY_REFERENCE_NODE = 5,      -- historical
    ENTITY_NODE = 6,                -- historical
    PROCESSING_INSTRUCTION_NODE = 7,
    COMMENT_NODE = 8,
    DOCUMENT_NODE = 9,
    DOCUMENT_TYPE_NODE = 10,
    DOCUMENT_FRAGMENT_NODE = 11,
    NOTATION_NODE = 12,             -- Historical

    -- Position Constants
    DOCUMENT_POSITION_DISCONNECTED = 0x01,
    DOCUMENT_POSITION_PRECEDING = 0x02,
    DOCUMENT_POSITION_FOLLOWING = 0x04,
    DOCUMENT_POSITION_CONTAINS = 0x08,
    DOCUMENT_POSITION_CONTAINED_BY = 0x10,
    DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC = 0x20,
    
    -- Functions
    new = new
}