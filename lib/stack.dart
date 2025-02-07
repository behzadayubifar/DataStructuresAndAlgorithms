import 'package:stack/illegal_operation_exception.dart';
import 'package:stack/stack.dart';

extension Stringer on String {
  String reverse() {
    var stack = Stack<String>();
    for (int i = 0; i < this.length; i++) {
      stack.push(this[i]);
    }
    var reversed = "";
    while (stack.isNotEmpty) {
      reversed = reversed + stack.pop();
    }
    return reversed;
  }

  bool isBalanced() {
    // int count = 0;
    // for (String char in this.split('')) {
    //   if (char == "/" || char == "{" || char == "}") count++;
    // }
    // if (count % 2 != 0) return false;
    // return true;

    final stack = Stack<String>();
    for (final ch in this.split("")) {
      if (ch == "{" || ch == "[" || ch == "(" || ch == "<") {
        stack.push(ch);
      } else {
        if (ch == "}" || ch == "]" || ch == ")" || ch == ">") {
          if (stack.isNotEmpty) {
            var top = stack.pop();
            if (ch == "}") {
              if (top != "{") return false;
            }
            if (ch == ")") {
              if (top != "(") return false;
            }
            if (ch == "]") {
              if (top != "[") return false;
            }
            if (ch == ">") {
              if (top != "<") return false;
            }
          } else {
            return false;
          }
        }
      }
    }
    return true;
  }
}

class BeziStack<T> {
  List<T?> _items;
  BeziStack(int length) : _items = List.filled(length, null);

  int _count = 0;

  push(T item) {
    // if (_count == _items.length) {
    //   final items = List.filled(_count + _count ~/ 2, null);
    //   items.addAll(items);
    //   _items = items;
    // }
    if (_count == _items.length) throw StackOverflowError;
    _items[_count++] = item;
    // _items.add(item);
    // _count++;
  }

  T? pop() {
    if (_count == 0) throw IllegalOperationException;
    return _items[--_count];
  }

  T? top() {
    if (_count == 0) throw IllegalOperationException;
    return _items[_count];
  }

  @override
  String toString() {
    final items = _items.getRange(0, --_count);
    return "$items";
  }
}
