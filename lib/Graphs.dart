import 'dart:collection';
import 'dart:mirrors';

import 'package:stack/illegal_operation_exception.dart';
import 'package:stack/stack.dart';

class Graph {
  final nodes = HashMap<String, Node>();
  final adjacencyList = HashMap<Node, List<Node>>();

  void addNode(String label) {
    final node = Node(label);
    nodes.putIfAbsent(label, () => node);
    adjacencyList.putIfAbsent(
      node,
      () => List.empty(growable: true),
    );
  }

  void addEdge(String from, String to) {
    if (!nodes.containsKey(from) || !nodes.containsKey(to))
      throw IllegalOperationException;

    final fromNode = nodes[from];
    final toNode = nodes[to];

    adjacencyList[fromNode]?.add(toNode!);
  }

  void removeNode(String label) {
    final node = nodes[label];
    if (node != null)
      for (var n in adjacencyList.keys) adjacencyList[n]?.remove(node);

    adjacencyList.remove(node);
    nodes.remove(label);
  }

  void removeEdge(String from, String to) {
    if (!nodes.containsKey(from) || !nodes.containsKey(to)) return;

    adjacencyList[nodes[from]]?.remove(nodes[to]);
  }

  void printGraph() {
    for (Node source in adjacencyList.keys) {
      var targets = adjacencyList[source];
      if (targets!.isNotEmpty) print("$source is connencted to $targets");
    }
  }

  Set<Node>? traverseDepthFirst(String label) {
    final root = nodes[label];
    if (root == null) return Set();
    final visitedNodes = HashSet<Node>();
    // _traverseDepthFirstRecursively(root, visitedNodes);
    _traverseDepthFirstIteratively(root, visitedNodes);
    return visitedNodes;
  }

  void _traverseDepthFirstRecursively(Node root, Set<Node> visitedNodes) {
    visitedNodes.add(root);
    for (Node n in adjacencyList[root]!) {
      if (!visitedNodes.contains(n))
        _traverseDepthFirstRecursively(n, visitedNodes);
    }
  }

  void _traverseDepthFirstIteratively(Node root, Set<Node> visitedNodes) {
    final stack = Stack<Node>();
    stack.push(root);
    Node current = root;
    while (stack.isNotEmpty) {
      current = stack.pop();
      if (visitedNodes.contains(current)) continue;
      visitedNodes.add(current);
      adjacencyList[current]?.forEach((neighbour) {
        if (!visitedNodes.contains(neighbour)) stack.push(neighbour);
      });
    }
  }

  void traverseBreadthFirst(Node root) {
    final visited = HashSet<Node>();
    final queue = Queue<Node>();
    queue.add(root);
    while (queue.isNotEmpty) {
      Node current = queue.removeFirst();
      if (visited.contains(current)) continue;
      visited.add(current);
      adjacencyList[current]?.forEach((neighbour) {
        if (!visited.contains(neighbour)) queue.add(neighbour);
      });
    }
  }

  List<String> topologicalSort() {
    final visited = HashSet<Node>();
    final stack = Stack<Node>();
    for (var node in nodes.values) _topologicalSort(node, visited, stack);

    final sortedList = <String>[];
    while (stack.isNotEmpty) sortedList.add(stack.pop().label);

    return sortedList;
  }

  void _topologicalSort(Node root, HashSet<Node> visited, Stack<Node> stack) {
    if (visited.contains(root)) return;
    visited.add(root);

    adjacencyList[root]
        ?.forEach((node) => _topologicalSort(root, visited, stack));

    stack.push(root);
  }

  bool hasCycle() {
    final all = HashSet<Node>();
    all.addAll(nodes.values);
    final visiting = HashSet<Node>();
    final visited = HashSet<Node>();

    while (all.isNotEmpty) {
      final current = all.first;
      if (_hasCycle(current, all, visiting, visited /* , track */)) return true;
    }
    return false;
    // final track = HashMap<Node, Node>(); // node -> parent
  }

  _hasCycle(
    Node root,
    HashSet<Node> all,
    HashSet<Node> visiting,
    HashSet<Node> visited,
    // HashMap<Node, Node> track,
  ) {
    all.remove(root);
    visiting.add(root);

    for (final neighbour in adjacencyList[root]!) {
      if (visited.contains(neighbour)) continue;
      if (visiting.contains(neighbour)) {
        // String biblography = neighbour.label;
        // Node? n = track[neighbour];
        // while (n != null) {
        //   biblography += " -> " + n.label;
        // }
        // print(biblography);
        return true;
      }
      if (_hasCycle(neighbour, all, visiting, visited /* , track */))
        return true;

      visiting.remove(neighbour);
      visited.add(neighbour);
      return false;
    }
/* 
    for (final node in nodes.values) {
      track.putIfAbsent(node, () => root);
    } */
  }
}

class Node {
  String label;
  Node(this.label);

  @override
  String toString() => label;
}
