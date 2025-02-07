class Array<T> {
  Array(final int length) {
    cap = length;
  }

  List<T> items = [];
  int length = 0;
  int? cap;

  int insert(T item) {
    items = [...items, item];
    length++;
    return length - 1;
  }

// [2, 3]
  int remove(T item) {
    late final int removedItemIndex;
    for (int i = 0; i <= length; i++) {
      if (items[i] == item) {
        removedItemIndex = i; // 1
        while (i >= removedItemIndex && i < length - 1) {
          items[i] = items[i + 1];
          i++;
        }
        length--;
        items = items.sublist(0, length - 1);
        return length;
      }
    }
    return -1;
  }

  void removeAt(int index) {
    for (int i = 0; i < length; i++) {
      if (i == index) {
        while (i < length - 1) {
          items[i] = items[i + 1];
          i++;
        }
        items = items.sublist(0, length - 1);
        length--;
      }
    }
  }

  int indexOf(T n) {
    for (int i = 0; i < length; i++) {
      if (items[i] == n) {
        return i;
      }
    }
    return -1;
  }

//
}

void main(List<String> args) {
  final a1 = Array<int>(2);
  a1.insert(2);
  a1.insert(24);
  a1.insert(3);
  print(a1.indexOf(24));
  a1.remove(2);
  print(a1.indexOf(24));
  a1.removeAt(1);
  print(a1.indexOf(3));
}
