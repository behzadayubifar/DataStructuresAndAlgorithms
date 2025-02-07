import 'dart:math' as math;

class Node {
  Node(
    this.value, [
    this.left,
    this.right,
  ]);

  int value;
  Node? left;
  Node? right;

  @override
  String toString() => '''Value = $value,
Left = $left,
Right = $right''';
}

class Tree {
  Tree(this._root);

  Node? _root;

  Node? get root => _root;

  void insert(int value) {
    final node = Node(value);
    if (_root == null) {
      _root = node;
      return;
    }
    Node? current = _root;
    while (true) {
      if (value < current!.value) {
        if (current.left == null) {
          current.left = node;
          break;
        }
        current = current.left;
      } else {
        if (current.right == null) {
          current.right = node;
          break;
        }
        current = current.right;
      }
    }
  }

  bool find(int value) {
    Node? current = _root;
    while (current?.value != value) {
      if (current == null) return false;
      if (value < current.value) {
        current = current.left;
      } else {
        current = current.right;
      }
    }
    if (current?.value == value) return true;
    return false;
  }

  void traversePreOrder() {
    _traversePreOrder(root);
  }

  void _traversePreOrder(Node? root) {
    if (root == null) return;
    // root
    print(root.value);
    // left
    _traversePreOrder(root.left);
    // right
    _traversePreOrder(root.right);
  }

  void traversePostOrder() {
    _traversePostOrder(root);
  }

  void _traversePostOrder(Node? root) {
    if (root == null) return;
    // left
    _traversePostOrder(root.left);
    // right
    _traversePostOrder(root.right);
    // root
    print(root.value);
  }

  void traverseInOrder() {
    _traverseInOrder(root);
  }

  void _traverseInOrder(Node? root) {
    if (root == null) return;

    // left
    _traverseInOrder(root.left);
    // root
    print(root.value);
    // right
    _traverseInOrder(root.right);
  }

  int get height => _height(root);

  int _height(Node? root) {
    if (root == null) return -1;
    if (root.left == null && root.right == null) return 0;

    return math.max(_height(root.left), _height(root.right)) + 1;
  }

  int? get min => _min(root);

  int? _min(Node? root) {
    if (root == null) return null;
    if (root.left == null && root.right == null) return root.value;
    final minLeft = _min(root.left);
    final minRight = _min(root.right);
    return math.min(
      math.min(minRight ?? root.value, minLeft ?? root.value),
      root.value,
    );
  }

  bool isEqualTo(Tree other) => equals(root, other.root);
  bool equals(Node? first, Node? second) {
    if (first == null && second == null) return true;
    if (first != null && second != null) {
      return first.value == second.value &&
          equals(first.left, second.left) &&
          equals(first.right, second.right);
    }
    // just one of them is null
    return false;
  }

  bool get isBinary => _isBinary(root);

  bool _isBinary(Node? root) {
    if (root == null) return false;
    return _isBinary(root.left) && _isBinary(root.right);
  }
}
