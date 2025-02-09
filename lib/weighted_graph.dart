import 'dart:collection';
import 'package:collection/collection.dart';

import 'package:stack/illegal_operation_exception.dart';
import 'package:stack/stack.dart';

class WeightedGraph {
  final nodes = HashMap<String, Node>();

  void addNode(String label) {
    if (nodes[label] == null) throw IllegalOperationException;
    nodes.putIfAbsent(label, () => Node(label));
  }

  void addEdge(String from, String to, int weight) {
    if (!nodes.containsKey(from) || !nodes.containsKey(to))
      throw IllegalOperationException;

    final fromNode = nodes[from];
    final toNode = nodes[to];

    fromNode?.addEdge(toNode!, weight);
    toNode?.addEdge(fromNode!, weight);
  }

  void printGraph() {
    for (var node in nodes.values) {
      if (node.edges.isNotEmpty)
        print(
          "$node is connected to ${node.edges}",
        );
    }
  }

  Path getShortestPath(String from, String to) {
    if (!nodes.containsKey(from) || !nodes.containsKey(to))
      throw IllegalOperationException;

    final fromNode = nodes[from];
    final toNode = nodes[to];

    final previousNodes = HashMap<Node, Node>();
    final distances = HashMap<Node, int>();
    for (var node in nodes.values)
      distances.putIfAbsent(
        node,
        () => double.maxFinite.toInt(),
      );
    distances[fromNode!] = 0;

    final visited = HashSet<Node>();

    final queue = PriorityQueue<NodeEntry>(
      (a, b) => a._priority.compareTo(b._priority),
    );

    queue.add(NodeEntry(node: fromNode, priority: 0));

    while (queue.isNotEmpty) {
      final current = queue.removeFirst();
      visited.add(current._node);
      for (var edge in current._node.edges) {
        if (visited.contains(edge.to)) continue;
        final newDistance = distances[current]! + edge.weight;
        if (newDistance < distances[edge.to]!) {
          distances.update(edge.to, (_) => newDistance);
          previousNodes.putIfAbsent(edge.to, () => current._node);
          queue.add(NodeEntry(node: edge.to, priority: newDistance));
        }
      }
    }
    return Path().buildPath(toNode, previousNodes);
  }

  bool hasCycle() {
    final visited = HashSet<Node>();
    for (var node in nodes.values) {
      if (!visited.contains(node) && _hasCycle(node, null, visited))
        return true;
    }
    return false;
  }

  bool _hasCycle(
    Node node,
    Node? parent,
    Set<Node> visited,
  ) {
    visited.add(node);
    for (final edge in node.edges) {
      if (edge.to == node) continue;
      if (visited.contains(edge.to) || _hasCycle(edge.to, node, visited)) ;
    }
    return false;
  }

  WeightedGraph getMinimumSpanningTree() {
    final tree = WeightedGraph();
    if (nodes.isEmpty) return tree;

    final edges = PriorityQueue<Edge>(
      (e1, e2) => e1.weight.compareTo(e2.weight),
    );

    final startedNode = nodes.values.first;
    edges.addAll(startedNode.edges);
    tree.addNode(startedNode.label);

    if (edges.isEmpty) return tree;

    while (tree.nodes.length < nodes.length) {
      final nearest = edges.removeFirst();
      var nextNode = nearest.to;
      if (tree.containsNode(nextNode.label)) continue;
      tree.addNode(nextNode.label);
      tree.addEdge(nearest.from.label, nextNode.label, nearest.weight);
      edges.clear();
      if (nextNode.edges.isNotEmpty && !tree.containsNode(nextNode.label))
        edges.addAll(nearest.from.edges);
    }

    return tree;
  }

  containsNode(String label) => nodes.containsKey(label);
}

class Node {
  final String label;
  final List<Edge> _edges = List.empty(growable: true);

  Node(this.label);

  void addEdge(Node to, int weight) {
    _edges.add(Edge(from: this, to: to, weight: weight));
  }

  List<Edge> get edges => _edges;

  @override
  String toString() => "$label";
}

class Edge {
  final Node from;
  final Node to;
  final int weight;

  Edge({required this.from, required this.to, required this.weight});

  @override
  String toString() => "$from -> $to";
}

class NodeEntry {
  final Node _node;
  final int _priority;

  NodeEntry({required Node node, required int priority})
      : _node = node,
        _priority = priority;
}

class Path {
  final _nodes = <String>[];

  void add(String node) => _nodes.add(node);

  @override
  String toString() => _nodes.toString();

  Path buildPath(Node? toNode, HashMap<Node, Node> previousNodes) {
    final stack = Stack<Node>();
    stack.push(toNode!);
    Node? previous = previousNodes[toNode];
    while (previous != null) {
      stack.push(previous);
      previous = previousNodes[previous];
    }

    final path = Path();
    while (stack.isNotEmpty) path.add(stack.pop().label);
    return path;
  }
}
