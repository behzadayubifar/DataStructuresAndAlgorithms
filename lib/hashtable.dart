import 'dart:collection';

import 'package:stack/illegal_operation_exception.dart';

extension HashString on String {
  String? firstNonRepeatedChar() {
    final str = this;
    final Map<String, int> charTable = {};
    for (var char in str.split("")) {
      if (charTable.containsKey(char)) {
        charTable[char] = charTable[char]! + 1;
      } else {
        charTable[char] = 1;
      }
    }
    for (var char in str.split("")) {
      if (charTable[char]! == 1) return char;
    }
    return null;
  }

  // No matter how many times it is repeated so
  // we don't have to stroe the number of repetiotion
  // String? firstRepeatedChar() {
  //   final str = this;
  //   final Map<String, int> charTable = {};
  //   for (var char in str.split("")) {
  //     if (charTable.containsKey(char)) {
  //       charTable[char] = charTable[char]! + 1;
  //     } else {
  //       charTable[char] = 1;
  //     }
  //   }
  //   for (var char in str.split("")) {
  //     if (charTable[char]! > 1) return char;
  //   }
  //   return null;
  // }

  String? firstRepeatedChar() {
    final str = this;
    final set = Set<String>();

    for (var char in str.split("")) {
      if (set.contains(char)) return char;
      set.add(char);
    }
    return null;
  }
}

base class Entry extends LinkedListEntry<Entry> {
  Entry(
    this.key,
    this.value,
  );
  final int key;
  String value;

  @override
  String toString() => "$key, $value";
}

class BeziHash {
  BeziHash(
    this._length,
  ) : _table = List.generate(_length, (_) => null);

  final int _length;
  final List<LinkedList<Entry>?> _table;

  void put(int key, String value) {
    final slotIdx = _hash(key);
    final newEntry = Entry(key, value);
    var bucket = _table.elementAt(slotIdx);
    if (bucket == null) {
      bucket = LinkedList();
      _table[slotIdx] = bucket;
    } else {
      for (var entry in bucket) {
        if (entry.key == key) {
          entry.value = value;
          return;
        }
      }
    }
    bucket.add(newEntry);
  }

  String? get(int key) {
    final index = _hash(key);
    var bucket = _table.elementAt(index);
    if (bucket != null) {
      for (var entry in bucket) {
        if (entry.key == key) return entry.value;
      }
    }
    return null;
  }

  void remove(int key) {
    final index = _hash(key);
    final bucket = _table.elementAt(index);
    if (bucket != null) {
      for (var entry in bucket) {
        if (entry.key == key) {
          bucket.remove(entry);
          return;
        }
      }
    } else {
      throw IllegalOperationException;
    }
    throw IllegalOperationException;
  }

  int _hash(int key) => key % _length;

  @override
  String toString() => _table.toString();
}
