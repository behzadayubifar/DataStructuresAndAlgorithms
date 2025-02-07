import 'dart:math';

class AVLTree {
  AVLNode? root;

  void insert(int v) {
    root = _insert(root, v);
  }

  AVLNode _insert(AVLNode? root, int v) {
    if (root == null) return AVLNode(value: v, height: 0);

    if (root.value > v) {
      root.left = _insert(root.left, v);
    } else {
      root.right = _insert(root.right, v);
    }

    _setHeight(root);

    return balance(root);
  }

  AVLNode leftRotate(AVLNode root) {
    final newRoot = root.right;

    if (newRoot?.left != null) {
      newRoot!.left!.value > root.value
          ? root.left = newRoot.left
          : root.right = newRoot.left;
    }

    newRoot?.left = root;

    _setHeight(root);
    _setHeight(newRoot);

    return newRoot!;
  }

  AVLNode rightRoatate(AVLNode root) {
    final newRoot = root.left;
    if (newRoot?.right != null) {
      newRoot!.right!.value > root.value
          ? root.right = newRoot.right!
          : root.left = newRoot.right;
    }
    newRoot?.right = root;

    _setHeight(root);
    _setHeight(newRoot);

    return newRoot!;
  }

  AVLNode balance(AVLNode root) {
    if (isLeftHeavy(root)) {
      print("${root.value} is left heavy");
      if (balanceFactor(root.left) < 0) root.left = leftRotate(root.left!);
      return rightRoatate(root);
    } else if (isRightHeavy(root)) {
      if (balanceFactor(root.right) > 0) root.right = rightRoatate(root.right!);
      return leftRotate(root);
    }

    return root;
  }

  bool isLeftHeavy(AVLNode? n) => balanceFactor(n) > 0 ? true : false;
  bool isRightHeavy(AVLNode? n) => balanceFactor(n) < 0 ? true : false;

  int balanceFactor(AVLNode? n) =>
      n == null ? 0 : _height(n.left) - _height(n.right);

  void _setHeight(AVLNode? n) {
    n?.height = max(_height(n.left), _height(n.left)) + 1;
  }

  int _height(AVLNode? n) => n == null ? -1 : n.height;
}

class AVLNode {
  int value;
  AVLNode? right;
  AVLNode? left;
  int height;

  AVLNode({required this.value, required this.height, this.right, this.left});

  @override
  String toString() => "Value= $value";
}
