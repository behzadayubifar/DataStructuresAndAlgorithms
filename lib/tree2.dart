import 'dart:io';
import 'dart:math';

class Node {
  final int value;
  Node? left, right;

  Node({required this.value, this.left, this.right});

  @override
  String toString() => "Node -> value: $value with L: $left & R: $right";
}

class Tree2 {
  late Node? root;
  Tree2(int v) {
    root = Node(value: v);
  }

  insert(int v) {
    final node = Node(value: v);
    Node? current = root;
    while (true) {
      if (v > current!.value) {
        if (current.right == null) {
          current.right = node;
          break;
        }
        current = current.right;
      } else {
        if (current.left == null) {
          current.left = node;
          break;
        }
        current = current.left;
      }
    }
  }

  bool find(int v) {
    if (root == null) return false;
    if (root?.value == v) return true;
    Node? current = root;
    while (true) {
      if (current == null) return false;
      if (v > current.value) {
        current = current.right;
      } else if (v < current.value) {
        current = current.left;
      } else {
        return true;
      }
    }
  }

  traversePreOrder(Node? root) {
    if (root == null) return;
    print(root);
    traversePreOrder(root.left);
    traversePreOrder(root.right);
  }

  traverseInOrder(Node? root) {
    if (root == null) return;
    traverseInOrder(root.left);
    print(root);
    traverseInOrder(root.right);
  }

  traversePostOrder(Node? root) {
    if (root == null) return;
    traversePostOrder(root.left);
    traversePostOrder(root.right);
    print(root);
  }

  int get height => _height(root);

  int _height(Node? node) {
    if (node == null) return -1;
    if (_isLeaf(node)) return 0;
    return 1 + max(_height(node.left!), _height(node.right!));
  }

  int minimum(Node? node) {
    if (node == null) return -1;
    if (_isLeaf(node)) return 0;
    return min(min(minimum(node.left), minimum(node.right)), node.value);
  }

  bool isEqual(Tree2 t) {
    return _isEqual(root, t.root);
  }

  bool get isBinarySearchTree => _isBinarySearchTree(root);

  bool _isBinarySearchTree(Node? root, [int? min, int? max]) {
    if (root == null) return true;

    if (max != null && root.value > max) return false;
    if (min != null && root.value < min) return false;

    return _isBinarySearchTree(root.right, root.value, () {
          if (max != null) return max + 1;
        }()) &&
        _isBinarySearchTree(root.left, () {
          if (min != null) return min - 1;
        }(), root.value);
  }

  swapRoot() {
    final temp = root?.right;
    root?.left = root?.right;
    root?.right = temp;
  }

  Iterable<Node?> getNodesAt(int distance) {
    return _getNodesAt(distance, root);
  }

  Iterable<Node?> _getNodesAt(int distance, Node? root) {
    if (root == null) return [];
    if (distance == 0) return [root];
    final l = <Node?>[];
    if (root.left != null) l.addAll(_getNodesAt(distance - 1, root.left!));
    if (root.right != null) l.addAll(_getNodesAt(distance - 1, root.right!));
    return l;
  }

  void traverseLevelOrder() {
    for (int i = 0; i <= this.height; i++) {
      print(getNodesAt(i).map((node) => node?.value));
    }
  }

  bool _isEqual(Node? n, Node? other) {
    if (n == null && other == null) return true;
    if (n != null && other != null)
      return n.value == other.value &&
          _isEqual(n.left, other.left) &&
          _isEqual(n.right, other.right);

    return false;
  }

  bool _isLeaf(Node n) => (n.left == null && n.right == null);
}

int factorial(int i) {
  int f = 1;
  for (int n = i; n > 1; n--) {
    f *= n;
  }
  return f;
}

int recFact(int n) {
  int f = 1;
  if (n != 1) {
    f = n * recFact(n - 1);
  }
  return f;
}
