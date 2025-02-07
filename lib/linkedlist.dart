class Node<T> {
  T value;
  Node? next;

  Node(
    this.value, [
    next,
  ]);

  @override
  String toString() => "Node(value: $value &\n next ix $next)";
}

class Linkedlist<T> {
  Node<T>? first, last;

  Linkedlist([
    this.first,
    this.last,
  ]);

  addFirst(T value) {
    final node = Node(value);
    // list is empty
    if (_isEmpty) {
      first = last = node;
    } else {
      // list has at least one member
      node.next = first;
      first = node;
    }
  }

  addLast(T value) {
    final node = Node(value);
    // list is empty
    if (_isEmpty) {
      first = last = node;
      print("object");
    } else {
      // list has at least one member
      last!.next = node;
      last = node;
    }
  }

  int indexOf(T value) {
    if (first?.value == value) {
      return 0;
    } else {
      int i = 1;
      Node? next = first?.next;
      while (next != null) {
        if (next.value == value) {
          return i;
        } else {
          next = next.next;
          i++;
        }
      }
      return -1;
    }
  }

  bool contains(T value) {
    Node? current = first;
    while (current != null) {
      if (current.value == value) return true;
      current = current.next;
    }
    return false;
  }

  removeFirst() {
    if (_isEmpty) throw RangeError("The List Is Empty");
    if (first == last) {
      first = last = null;
      return;
    }

    var second = first?.next;
    first?.next = null;
    first = second as Node<T>?;
  }

  removeLast() {
    if (_isEmpty) throw RangeError("The List Is Empty");
    if (first == last) {
      first = last = null;
      return;
    }
    var current = first;
    while (current?.next != last) {
      current = current?.next as Node<T>?;
    }
    last = current;
    current!.next = null;
  }

  reverse() {
    if (_isEmpty) return;
    // if (first == last) return;

    var previous = first;
    var current = first!.next;

    while (current != null) {
      var next = current.next;
      current.next = previous;
      previous = current as Node<T>;
      current = next;
    }
    // previous == last
    last = first;
    last!.next = null;
    first = previous as Node<T>;
  }

  Node? getKthFromTheEnd2(int k) {
    reverse();
    var current = first;
    int i = 0;
    while (i != k) {
      if (current == null) return null;
      current = current.next as Node<T>?;
      i++;
    }
    return current;
  }

  T getKthFromTheEnd(int k) {
    var a = first;
    var b = first;

    for (int i = 0; i < k - 1; i++) {
      b = b!.next as Node<T>?;
      if (b == null) throw RangeError("K is more than the cap of the list");
    } // a & b diff is k
    while (b != last) {
      a = a!.next as Node<T>?;
      b = b!.next as Node<T>?;
    }
    // b is last
    return a!.value;
  }

  bool get _isEmpty => first == null;
}
