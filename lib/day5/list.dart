void main() {
  List<List> list = [
    [
      "a",
      "b",
    ],
    ["1", '2', '7', '9']
  ];
  display(list);
  sortList(list);
  display(list);
  addList(list);
  display(list);
  deleteElement(list);
  display(list);
  getElement(list);
}

void getElement(List<List> list) {
  final d = list.getRange(0, 2); //return element between given range
  print("get element");
  print(d);
  List newList = [1, 2, 3, 4, 4, 5, 2];
  final x = newList
      .firstWhere((element) => element == 2); //return first occurencro element
  print(x);
  final index = newList.indexOf(4); //return index of given element
  print("index $index");
  final indexwhere = newList.indexWhere((element) =>
      element == 5); //return index of element  which is equal to given element
  print(indexwhere);
  final j = newList.map((e) {
    return e;
  });
  print(j);
  final listToSet =
      newList.toSet(); //convert list to set by removing duplicates elements
  print("set");
  print(listToSet);
  final any = newList.any((element) =>
      element >
      100); //return true if all elements  of list satisfy given condition
  print(any);
  for (var element in newList) {
    print(element);
  }
  final sublist = newList.sublist(2, 6); //return sublist between given range
  print(sublist);
  final skip = newList.skip(2); //skip the first two elements of list
  print(skip);
  final skipWhile = newList
      .where((value) => value != 5)
      .toList(); //return a list of element which is not equal to 5
  print(skipWhile);

}

void deleteElement(List<List> list) {
  for (var x in list) {
    x.removeWhere((element) => element == "siwani");
  }
  list.removeAt(1);

  for (var x in list) {
    if ((x.contains("a"))) {
      final index = list.indexOf(x);
      list.remove(x);
      // print(index);
      // list.removeAt(index); //you can delete element by sing id also
      if (index != null || index != false) {
        break;
      }
      // list.removeAt(index);
    }
  }
  List j = [
    "a",
    "b",
    "c",
    "d",
    "e",
  ];
  j.removeRange(0, 2); //remove list element between 0 and 2
  print(j);
  list.removeLast();
  List<int> x = [1, 2, 3, 4, 5, 6, 7];
  int sum = x.reduce((value, element) => value + element);
  print("sum$sum");
}

void addList(List<List> list) {
  list.add(["c", 'c++', 'javascript', 'java']);
  Iterable<List> newList = {
    ['deepa', 'mnisha'],
    ['siwani', 'sweata']
  };
  list.addAll(newList);
  List dem = [1, 2, 3, 4, 4, 5, 2];

  dem.addAll([10, 292]); //add multiple element to list
  dem.add(100); //add single element to list

  print(dem);
}

void sortList(List<List> list) {
  for (var x in list) {
    x.sort((a, b) => b.compareTo(a));
  }
}

void display(List<List> list) {
  for (var x in list) {
    for (var y in x) {
      print(y);
    }
  }
}
