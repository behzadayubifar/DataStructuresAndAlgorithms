import 'dart:collection';

class Trie {
  final _root = TrieNode('');

  void insert(String word) {
    var current = _root;

    for (var i = 0; i < word.length; i++) {
      String ch = word[i];
      current.addChild(ch.runes.first);
      current = current.getChild(ch.runes.first)!;
    }
    current.isEndOfWord = true;
  }

  void remove(String word) => _remove(_root, word, 0);

  void _remove(TrieNode node, String word, int index) {
    if (index == word.length) {
      node.isEndOfWord = false;
      return;
    }
    int char = word[index].runes.first;
    var child = node.getChild(char);
    if (child == null) return;

    _remove(child, word, index + 1);

    if (node.isEmpty && !node.isEndOfWord) _root.removeChild(char);
  }

  List<String?> findWords(String prefix) {
    final lastNode = _findLastNode(prefix);
    if (lastNode == null) return [];
    final List<String> output = [];
    _findWords(lastNode, prefix, output);
    return output;
  }

  void _findWords(TrieNode node, String prefix, List<String> output) {
    if (node.isEndOfWord) output.add(prefix);
    for (var n in node.Children) {
      _findWords(n, prefix + n.value, output);
    }
  }

  TrieNode? _findLastNode(String prefix) {
    var current = _root;
    for (int char in prefix.runes) {
      var child = current.getChild(char);
      if (child == null) return null;
      current = child;
    }
    return current;
  }

  bool contains(String word) {
    TrieNode current = _root;
    for (int i = 0; i < word.length; i++) {
      String char = word[i];
      if (!current.hasChild(char.runes.first)) return false;
      current = current.getChild(char.runes.first)!;
    }
    return current.isEndOfWord;
  }

  void traverse() => _traverse(_root);
  void _traverse(TrieNode root) {
    if (root.value != '') print(root.value);
    for (TrieNode n in root.Children) {
      // if (n.)
      _traverse(n);
    }
  }
}

class TrieNode {
  String value;
  HashMap<int, TrieNode> children = HashMap<int, TrieNode>();
  bool isEndOfWord = false;

  TrieNode(this.value);

  @override
  String toString() => "value = $value";

  bool hasChild(int char) => children.containsKey(char);

  void addChild(int char) =>
      children.putIfAbsent(char, () => TrieNode(String.fromCharCode(char)));

  void removeChild(int char) {
    children.remove(char);
  }

  TrieNode? getChild(int char) => children[char];
  List<TrieNode> get Children => children.values.toList();

  bool get isEmpty => children.isEmpty;
}
