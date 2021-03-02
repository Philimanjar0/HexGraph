# HexGraph
Lua class representation of a bi-graph with hexagonal neighbors. Created to be primarily used to represent the tiles of a board game.

# Usage
cd into your project
`git clone https://github.com/pbabell/HexGraph.git`
at the top of the file where you would like to use a HexGraph
`local Graph = require('HexGraph.HexGraph')`

# Features
This graph class maintains a few core features: adding nodes, removing nodes, getting neighbors.

When a node is added with
```graph.addNode(x, y)``` 
its neighbors are automatically added if they are adjacent. It is also added to each of its neighbors as a neighbor to create bi directionality. The same is true for
```graph.removeNode(x, y)```
neighbors are automatically updated.

To get a list of neighbors of a given node, use:
```graph.getNeighbors(x, y)```
