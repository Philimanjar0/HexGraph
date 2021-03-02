HexGraph = {}

-- Get the coordinates of hexagonal neighbor locations relative to the given node.
local function getAllNeighbors(x, y)
    return {
        {x + 1, y + 0},
        {x + 1, y + -1},
        {x + 0, y + -1},
        {x + -1, y + 0},
        {x + -1, y + 1},
        {x + 0, y + 1},
    }
end

-- Turn a node (x, y) into a string in the form "x;y;" to be used as a table key value
local function getKeyForNode(x, y)
    local node = ""
    for _,iKey in pairs({x,y}) do
        node = node .. tostring(iKey) .. ";"
    end
    return node
end

-- Parse a key string from getKeyForNode() and convert into a list in integers.
local function split (inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={}
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                table.insert(t, str)
        end
        return t
end

setmetatable(HexGraph, {
    __call = function()
        self = {}

        -- The collection of nodes in the graph.
        -- Maps a node to its neighbors.
        self.nodes = {}

        -- Add a node to the graph. Will automatically connect to adjacent nodes that are also in the graph.
        -- @param x The x value of the node to add in axial hex coordinates.
        -- @param y The y value of the node ot add in axial hex coordinates.
        function self.addNode(x, y)
            node = getKeyForNode(x, y)
            --print(node)
            self.nodes[node] = {}
            for _,neighbor in pairs(getAllNeighbors(x, y)) do
                neighborKey = getKeyForNode(neighbor[1], neighbor[2])
                if self.nodes[neighborKey] then
                    table.insert(self.nodes[node], neighbor)
                    table.insert(self.nodes[neighborKey], {x, y})
                end
            end
        end

        -- Remove a node from the graph. Will automatically remove all edges.
        -- @param x The x value of the node to remove in axial hex coordinates.
        -- @param y The y value of the node ot remove in axial hex coordinates.
        function self.removeNode(x, y)
            for _,neighbor in pairs(getAllNeighbors(x, y)) do
                nKey = getKeyForNode(neighbor[1], neighbor[2])
                if self.nodes[nKey] then
                    for i,node in pairs(self.nodes[nKey]) do
                        if node[1] == x and node[2] == y then
                            table.remove(self.nodes[nKey], i)
                        end
                    end
                end
            end
            self.nodes[{x,y}] = nil
        end

        -- Get actual neighbors of given node.
        -- @param x The x value of given node in axial hex coordinates.
        -- @param y The y value of the given node in axial hex coordinates.
        -- @return list of neighbors. Returns as a list of a list of integers.
        function self.getNeighbors(x, y)
            node = getKeyForNode(x, y)
            return self.nodes[node]
        end

        -- Get all nodes in the graph.
        -- @return list of all nodes. Returns as a list of a list of integers.
        function self.getNodes()
            local nodes = {}
            for node,_ in pairs(self.nodes) do
                table.insert(nodes, {tonumber(split(node, ";")[1]), tonumber(split(node, ";")[2])})
            end
            return nodes
        end
        return self
    end,
})

return HexGraph
