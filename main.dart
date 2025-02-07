import 'package:ds_algo/AVLTree.dart';
import 'package:ds_algo/Trie.dart';
import 'package:ds_algo/heaps.dart';
import 'package:ds_algo/tree2.dart';

// import 'lib/linkedlist.dart';

void main(List<String> args) {
  // --- Tries
  final t = Trie();
  t.insert("can");
  t.insert("cat");
  t.insert("catty");
  t.insert("canada");
  t.insert("canadian");
  t.insert("behzad");
  print(t.findWords("can"));
  // t.remove("");
  // print(t.contains("cat"));
  // t.traverse();

  //  --- Heap
  /* List l = [5, 3, 8, 4, 1, 2];
  final kth = Heapify.kthLargest(l, 4);
  print(kth); */
  // l = Heapify.heapify(l);
  // print(l);

  // List l = [8, 3, 5, 4, 1, 2];
  // List l = [8, 4, 5, 3, 1, 2];
  // double measureThePerformanceOf(Function f, input) {
  //   final stopWatch = Stopwatch()..start();
  //   for (int i = 0; i < 10000; i++) {
  //     f(input);
  //   }
  //   stopWatch..stop();
  //   return stopWatch.elapsedMicroseconds / 10000;
  // }
  // print(measureThePerformanceOf(Heapify.heapify, l));

  /* final h1 = Heap(7);
  h1.insert(10);
  h1.insert(5);
  h1.insert(17);
  h1.insert(4);
  h1.insert(22);
  print(h1.remove()); */
  /* // --- AVL Tree
  final avlTree = AVLTree();
  avlTree.insert(10);
  avlTree.insert(2);
  avlTree.insert(8);
  avlTree.insert(5); */

  /* // --- Tree 2
  final tree2 = Tree2(7);
  tree2.insert(4);
  tree2.insert(9);
  tree2.insert(1);
  tree2.insert(6);
  tree2.insert(8);
  tree2.insert(10);
  // tree2.getNodesAt(2).forEach(
  //       (element) => print(element),
  //     );
  tree2.traverseLevelOrder();
  // print(tree2.isBinarySearchTree);
  // tree2.swapRoot();
  // print(tree2.isBinarySearchTree);
  final tree3 = Tree2(7);
  tree3.insert(7);
  tree3.insert(4);
  tree3.insert(9);
  tree3.insert(2);
  tree3.insert(5);
  tree3.insert(6);
  tree3.insert(10); */
  // tree3.getNodesAt(2).forEach(
  //       (element) => print(element),
  //     );
  // print(tree3.isBinarySearchTree);
  // print(tree2.isEqual(tree3));
  // print("done");
  // --- Tree
  /* final Tree tree = Tree(Node(21));
  tree.insert(22);
  tree.insert(20);
  tree.insert(16);
  final Tree tree2 = Tree(Node(21));
  tree2.insert(22);
  tree2.insert(20);
  tree2.insert(16);
  print(tree.isEqualTo(tree2)); */
  // print(tree.min);
  // print(tree.height);
  // print(tree.find(16));
  // tree.traversePreOrder();
  // tree.traverseInOrder();
  /*  // --- Hash Table
  final bht1 = BeziHash(5);
  print(bht1);
  bht1.put(1, "A");
  print(bht1);
  bht1.put(2, "B");
  print(bht1);
  bht1.put(2, "c");
  print(bht1);
  print(bht1.get(1)); */

  /* final str = "A Green Apple";
  final foo = str.firstNonRepeatedChar();
  print(foo);
  print(str.firstRepeatedChar()); */

  // --- Queue

/*   final bpq1 = BeziPriorityQueue(5, 0);
  print(bpq1);
  bpq1.enqueue(2);
  print(bpq1);
  bpq1.enqueue(3);
  print(bpq1);
  bpq1.enqueue(6);
  print(bpq1);
  bpq1.dequeue();
  print(bpq1);
 */
  /*  final bsq1 = BeziStackQueue<int>();
  bsq1.enqueue(1);
  bsq1.Bprint();
  bsq1.enqueue(2);
  bsq1.Bprint();
  bsq1.enqueue(3);
  bsq1.Bprint();
  bsq1.dequeue();
  bsq1.Bprint();
  bsq1.dequeue();
  bsq1.Bprint();
  bsq1.enqueue(4);
  bsq1.Bprint();
  bsq1.enqueue(5);
  bsq1.Bprint();
  bsq1.dequeue();
  bsq1.Bprint();
 */
  /* final baq1 = BeziArrayQueue(5, 0);
  baq1.enqueue(1);
  print(baq1);
  baq1.enqueue(2);
  print(baq1);
  baq1.enqueue(3);
  print(baq1);
  baq1.enqueue(4);
  print(baq1);
  baq1.dequeue();
  print(baq1);
  baq1.dequeue();
  print(baq1);
  baq1.enqueue(5);
  print(baq1);
  baq1.enqueue(6);
  print(baq1);
  baq1.enqueue(7);
  print(baq1);
  baq1.dequeue();
  print(baq1);
  baq1.dequeue();
  print(baq1);
  baq1.dequeue();
  print(baq1);
  baq1.dequeue();
  print(baq1);
  baq1.dequeue();
  print(baq1);
  baq1.dequeue();
  print(baq1);
   */

  // final q1 = Queue();
  // q1.addAll([1, 2, 3, 5]);
  // print(q1);
  // q1.reverse();
  // print(q1);

  // --- Stack

  // final str1 = "Behzad";
  // final reversedStr1 = str1.reverse();
  // print(reversedStr1);

  // final str2 = "{}}BEHZ}";
  // print("str2 is balanced? ==> ${str2.isBalanced()}");

  // final str3 = "{<(BEHZ+)>}";
  // print("str3 is balanced? ==> ${str3.isBalanced()}");
  // --- LinkedList
  /* final l1 = Linkedlist<int>();
  // l1.addLast(2);
  // l1.addLast(3);
  // l1.addLast(4);
  l1.addFirst(2);
  print("Index of 2 is ${l1.indexOf(2)}");
  l1.addFirst(3);
  l1.addFirst(4);
  print("Index of 2 is ${l1.indexOf(2)}");
  print("Index of 1 is ${l1.indexOf(1)}");
  print("1 is in the list --> ${l1.contains(1)}");
  print("Index of 3 is ${l1.indexOf(3)}");
  print("Index of 3 is ${l1.indexOf(3)}");
  print("4 is in the list --> ${l1.contains(4)}");
  // l1.removeFirst();
  // print("4 is in the list --> ${l1.contains(4)}");
  print(l1.getKthFromTheEnd(2));
  l1.reverse();
  // l1.removeLast();
  // print("2 is in the list --> ${l1.contains(2)}"); */
}
