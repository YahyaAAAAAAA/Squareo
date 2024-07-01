import 'dart:collection';

class BreadthFirstSearch {
  // Convert index to (row, column) coordinates
  List<int> indexToCoordinates(int index, int columns) {
    int row = index ~/ columns;
    int col = index % columns;
    return [row, col];
  }

  // Convert (row, column) coordinates to index
  int coordinatesToIndex(int row, int col, int columns) {
    return row * columns + col;
  }

  // Get valid neighbors for a given (row, column) position
  List<List<int>> getNeighbors(int row, int col, int rows, int columns) {
    List<List<int>> neighbors = [];
    if (col < columns - 1) neighbors.add([row, col + 1]); // right
    if (col > 0) neighbors.add([row, col - 1]); // left
    if (row < rows - 1) neighbors.add([row + 1, col]); // down
    if (row > 0) neighbors.add([row - 1, col]); // up
    return neighbors;
  }

  // BFS to find the shortest path
  List<dynamic> bfs(int startIdx, int targetIdx, int rows, int columns) {
    List<int> start = indexToCoordinates(startIdx, columns);
    List<int> target = indexToCoordinates(targetIdx, columns);

    Queue<List<dynamic>> queue = Queue();
    queue.add([start, []]);
    Set<List<int>> visited = {};
    visited.add(start);

    while (queue.isNotEmpty) {
      List<dynamic> current = queue.removeFirst();
      List<int> position = current[0];
      var path = current[1];

      if (position[0] == target[0] && position[1] == target[1]) {
        return path
            .map((p) => coordinatesToIndex(p[0], p[1], columns))
            .toList();
      }

      for (List<int> neighbor
          in getNeighbors(position[0], position[1], rows, columns)) {
        if (!visited.any((v) => v[0] == neighbor[0] && v[1] == neighbor[1])) {
          visited.add(neighbor);
          List<List<int>> newPath = List.from(path)..add(neighbor);
          queue.add([neighbor, newPath]);
        }
      }
    }

    return [];
  }
}
