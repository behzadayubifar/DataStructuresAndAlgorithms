import 'dart:collection';
import 'dart:developer';

import 'package:stack/illegal_operation_exception.dart';
import 'package:stack/stack.dart';

extension Queuer on Queue {
  void reverse() {
    final stack = Stack();
    while (this.isNotEmpty) {
      stack.push(this.removeFirst());
    }
    while (stack.isNotEmpty) {
      this.add(stack.pop());
    }
  }
}

class BeziArrayQueue<T> {
  BeziArrayQueue(
    int length,
    T? fill,
  )   : _fill = fill,
        _length = length,
        _arrayList = List.filled(length, fill);

  int _count = 0;
  int _rear = 0;
  int _front = 0;
  T? _fill;
  int _length;

  final List<T?> _arrayList;

  void enqueue(T element) {
    if (_count == _arrayList.length) throw IllegalOperationException;
    _arrayList[_rear] = element;
    _rear = (_rear + 1) % _length;
    _count++;
  }

  T? dequeue() {
    if (_count == 0) throw IllegalOperationException;
    final front = _arrayList[_front];
    _arrayList[_front] = _fill;
    _front = (_front + 1) % _length;
    _count--;
    return front;
  }

  //
  @override
  toString() {
    return "$_arrayList";
  }
}

class BeziStackQueue<T> {
  final s1 = Stack();
  final s2 = Stack();
  // if false the s1 is used otherwise s2 is.
  bool _actor = false;
  // if false the action was dequeue
  bool _lastAction = true;

  int _count = 0;

  void enqueue(T element) {
    if (_lastAction) // it was Enqueue too!
    {
      (_actor ? s2 : s1).push(element);
    } else {
      // it was Dequeue.
      while ((_actor ? s2 : s1).isNotEmpty) {
        (!_actor ? s2 : s1).push((_actor ? s2 : s1).pop());
      }
      (!_actor ? s2 : s1).push(element);
      _actor = !_actor;
    }
    _lastAction = true;
    _count++;
  }

  T dequeue() {
    if (_count == 0) throw IllegalOperationException;
    final T out;
    if (!_lastAction) // it was Dequeue too!
    {
      out = (_actor ? s2 : s1).pop();
    } else {
      // it was Enqueue.
      while ((_actor ? s2 : s1).isNotEmpty) {
        (!_actor ? s2 : s1).push((_actor ? s2 : s1).pop());
      }
      _actor = !_actor;
      out = (_actor ? s2 : s1).pop();
    }
    _lastAction = false;
    _count--;
    return out;
  }

  Bprint() {
    (_actor ? s2 : s1).print();
    print("-----------------------------");
  }
}

class BeziPriorityQueue<T extends num> {
  BeziPriorityQueue(
    final int length,
    final T fill,
  )   : _lenght = length,
        _fill = fill,
        _queue = List<T>.filled(
          length,
          fill,
        );

  final List<T> _queue;
  final int _lenght;
  final T _fill;
  int _count = 0;

  void enqueue(T element) {
    if (_count == _lenght) throw IllegalOperationException;
    if (_count == 0) _queue[0] = element;
    // [0, 1, 4, 5, 6]
    //  0  1  2  3  4  enqueue(3)
    for (var i = _count - 1; i >= 0; i--) {
      if (_queue[i] > element) {
        _queue[i + 1] = _queue[i];
      } else {
        _queue[i + 1] = element;
        break;
      }
    }
    _count++;
  }

  T dequeue() {
    if (_count == 0) throw IllegalOperationException;
    for (var i = _count - 1; i >= 0; i--) {
      if (_queue[i] != _fill) {
        return _queue[i] = _fill;
      }
    }
    _count--;
    return _fill;

    // for (var i = 0; i < _count; i++) {
    //   if (_queue[i] != _fill) {
    //     _queue[i] = _fill;
    //     return _queue[i];
    //   }
    // }
    // _count--;
    // return _fill;
  }

  @override
  String toString() => "$_queue";
}
