

void main() {
  List<String> girls = ['deepa', 'dipsikha', 'sunita', 'pratima'];
  // manipulateList(girls);
  Map<String, String> map = {
    'name': "manish",
    'age': "18",
    'addresses': 'Dharan'
  };
  // manipulateMap(map);
  Map<String, List<String>> mapList = {
    "lunch": ["fries", "dal", "vat"],
    "breakfast": [
      "milk",
      "bread",
    ]
  };
  manipulateMapList(mapList);
}

void manipulateMapList(m) {
  List lunch = m['lunch'];
  for (var element in lunch) {
    print(element);
  }
  print(m['lunch']);
}

manipulateMap(Map<String, String> map) {
  final x = map.map((key, value) {
    print("key is $key and value is $value");
    return MapEntry(key, value);
  });
  print(x);
  map.addAll({'degree': "+2"});
  print(map);
  map.addAll({'g': "3", "d": "4"});
  print(map);
  Map<String, String> newEntries = {'z': "e", "3": "tt"};
  map.addEntries(newEntries.entries);
  print(map);
  map.putIfAbsent('job', () => "broker");
  print(map);
  map.forEach((key, value) {
    print(value);
  });
  map.removeWhere((key, value) => key == 'z');

  print(map);
}

void manipulateList(List<String> girls) {
  girls.add("siwani");
  print("after adding  avliue $girls");
  List<String> newList = ['sila', 'dipsikha', 'mandipa'];
  girls.addAll(newList);
  print("after adding  lists $girls");
  String first = girls.first;
  String last = girls.last;
  print("first: $first, last: $last");

  final x = girls.asMap(); //convert list to key and value pair
  print(x);

  String ele = girls.elementAt(1);
  print(ele);
  final y = girls.getRange(1, 3); //return list item betweenrangee
  final z = girls.reduce((value, ele) => value + ele);
  print(y);
  print(z);
  print(girls.removeLast());
  print(girls.toSet()); //convert list to set and remove duplicate item
  girls.removeWhere((element) => element == "siwani");
  print(girls);
  final a = girls.where(
      (element) => element == "sunita"); //return a   set of  matched element
  final b = girls.sublist(1, 4);
  print("sublist $b"); //return a sublist between given range
  print(a);
  final c = girls.any((element) =>
      element == "deepa"); //return true if the condition is matched
  List<int> d = [1, 8, 9, 10, 11, 12, 13, 14, 15, 188];
  final e = d.every((element) =>
      element < 20); //return true if every element satisfy condition
  print(e);
  print(c);
  final f = d.fold(
      0,
      (previousValue, element) =>
          previousValue +
          element); //Uses [initialValue] as the initial value, then iterates through the elements and updates the value with each element using the [combine] function, as if by:
  print(f);
}
