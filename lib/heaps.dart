import 'package:stack/illegal_operation_exception.dart';

class Heap {
  final List<int> elements;
  int size;

  Heap(int length)
      : this.elements = List<int>.filled(length, 0, growable: false),
        this.size = 0;

  void insert(int e) {
    if (this.isFull) throw IllegalOperationException("The Heap Is Full");
    elements[size++] = e;

    bubbleUp();
  }

  int remove() {
    if (this.isEmpty) throw IllegalOperationException("The Heap Is Empty");
    int root = elements[0];
    elements[0] = elements[--size];
    bubbleDown();
    return root;
  }

  void bubbleDown() {
    int idx = 0;
    while (idx <= size && !_isValidParent(idx)) {
      if (_largerChildIdx(idx) != null) {
        _swap(idx, _largerChildIdx(idx)!);
        idx = _largerChildIdx(idx)!;
      }
    }
  }

  int? _largerChildIdx(int idx) {
    if (!_hasLeftChild(idx)) return idx;
    if (!_hasRightChild(idx)) return _leftIdx(idx);

    if (_left(idx) != 0 && _right(idx) != 0) {
      return (_left(idx) > _right(idx) ? _leftIdx(idx) : _rightIdx(idx));
    }

    return null;
  }

  bool _isValidParent(int idx) {
    if (!_hasLeftChild(idx)) return true;
    // if (!_hasRightChild(idx) && !_hasLeftChild(idx)) return true;

    if (!_hasRightChild(idx)) return elements[idx] > _left(idx);

    return elements[idx] > _left(idx) && elements[idx] > _right(idx);
  }

  int _leftIdx(int idx) => 2 * idx + 1;
  int _rightIdx(int idx) => 2 * idx + 2;

  bool _hasLeftChild(int idx) => _leftIdx(idx) <= size;
  bool _hasRightChild(int idx) => _rightIdx(idx) <= size;

  int _left(int idx) => elements[_leftIdx(idx)];
  int _right(int idx) => elements[_rightIdx(idx)];

  void bubbleUp() {
    int idx = size - 1;
    while (idx > 0 && elements[idx] > elements[_parentIdx(idx)]) {
      _swap(idx, _parentIdx(idx));

      idx = _parentIdx(idx);
    }
  }

  void _swap(int idx, int parentIdx) {
    final temp = elements[idx];
    elements[idx] = elements[parentIdx];
    elements[parentIdx] = temp;
  }

  int _parentIdx(int idx) => (idx - 1) ~/ 2;
  bool get isFull => size == elements.length;
  bool get isEmpty => size == 0;

  int get max {
    if (isEmpty) throw IllegalOperationException("THE HEAP IS EMPTY");

    return elements[0];
  }
}

// -------------------------------------------------------------------------------

class Heapify<T> {
  static List heapify(List l) {
    final lastParentIdx = l.length ~/ 2;
    for (int idx = lastParentIdx; idx >= 0; idx--) {
      // for (int idx = 0; idx < l.length ~/ 2; idx++) {
      _swapIfRequired(l, idx);
    }
    return l;
  }

  static void _swapIfRequired(List<dynamic> l, int idx) {
    var largerChildIndex = largerChildIdx(idx, l);
    // doesn't have any children or they are less than parent
    if (largerChildIndex == idx || l[idx] >= l[largerChildIndex]) return;

    final tmp = l[idx];
    l[idx] = l[largerChildIndex];
    l[largerChildIndex] = tmp;
  }

  static int leftIdx(int idx) => idx * 2 + 1;
  static int rightIdx(int idx) => idx * 2 + 2;
  static int leftChild(int idx, List l) => l[leftIdx(idx)];
  static int rightChild(int idx, List l) => l[rightIdx(idx)];
  static bool hasLeftChild(int idx, List l) => leftIdx(idx) < l.length;
  static bool hasRightChild(int idx, List l) => rightIdx(idx) < l.length;
  static int largerChildIdx(int idx, List l) {
    // no child
    if (!hasLeftChild(idx, l)) return idx;
    // Just left child
    if (!hasRightChild(idx, l)) return leftIdx(idx);
    // has both children
    return leftChild(idx, l) > rightChild(idx, l)
        ? leftIdx(idx)
        : rightIdx(idx);
  }

  static int kthLargest(List l, int k) {
    if (k < 1 || k > l.length)
      throw IllegalOperationException(
          "K must be between 1 & length of the array");
    final h = Heap(l.length);
    l.forEach((e) => h.insert(e));

    for (k; k > 1; k--) {
      h.remove();
    }

    return h.max;
  }
}
