import 'dart:collection';
import 'dart:convert';

import 'package:stack/illegal_operation_exception.dart';

class WeightedGraph {
  final nodes = HashMap<String, Node>();
  final adjacencyList = HashMap<Node, List<Edge>>();

  void addNode(String v) {
    if (nodes[v] == null) throw IllegalOperationException;
    final node = Node(v);
    nodes.putIfAbsent(v, () => node);
    adjacencyList.putIfAbsent(node, () => List<Edge>.empty(growable: true));
  }

  void addEdge(String from, String to, int weight) {
    if (!nodes.containsKey(from) || !nodes.containsKey(to))
      throw IllegalOperationException;

    final fromNode = nodes[from];
    final toNode = nodes[to];

    adjacencyList[fromNode]?.add(
      Edge(from: fromNode!, to: toNode!, weight: weight),
    );
    adjacencyList[toNode]?.add(
      Edge(from: toNode!, to: fromNode!, weight: weight),
    );
  }
}

class Node {
  final String label;

  Node(this.label);

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
