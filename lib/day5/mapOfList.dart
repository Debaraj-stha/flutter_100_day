import 'dart:math';

void main() {
  Map<String, List<Map<String, dynamic>>> product = {
    "tea": [
      {"name": "milk tea", "price": 40, "cat": "tea"},
      {"name": "black tea", "price": 25, "cat": "tea"},
      {"name": "lemon tea", "price": 40, "cat": "tea"},
      {"name": "green tea", "price": 50, "cat": "tea"}
    ],
    "coffiee": [
      {"name": "Americano", "price": 200, "cat": "coffiee"},
      {"name": "Mocha", "price": 150, "cat": "coffiee"},
      {"name": "Latte", "price": 120, "cat": "coffiee"},
      {"name": "Cappuccino", "price": 100, "cat": "coffiee"}
    ],
    "momo": [
      {"name": "veg", "price": 120, "cat": "momo"},
      {"name": "chicken", "price": 140, "cat": "momo"},
      {"name": "buff", "price": 110, "cat": "momo"},
      {"name": "pork", "price": 140, "cat": "momo"}
    ]
  };
  List<Map<String, dynamic>> list = [
    {"name": "milk tea", "price": 40, "cat": "tea"},
    {"name": "black tea", "price": 25, "cat": "tea"},
    {"name": "lemon tea", "price": 40, "cat": "tea"},
    {"name": "green tea", "price": 50, "cat": "tea"},
    {"name": "veg", "price": 120, "cat": "momo"},
    {"name": "chicken", "price": 140, "cat": "momo"},
    {"name": "buff", "price": 110, "cat": "momo"},
    {"name": "pork", "price": 140, "cat": "momo"},
    {"name": "Americano", "price": 200, "cat": "coffiee"},
    {"name": "Mocha", "price": 150, "cat": "coffiee"},
    {"name": "Latte", "price": 120, "cat": "coffiee"},
    {"name": "Cappuccino", "price": 100, "cat": "coffiee"}
  ];
  groupedItemBaseOnCat(list);
  // generateRandomPassword();
  // display(product);
  // add(product);
  // display(product);
  // update(product);
}

void groupedItemBaseOnCat(List<Map<String, dynamic>> list) {
  Map<String, List<Map<String, dynamic>>> groupedItems = {};
  for (var item in list) {
    final cat = item['cat'];
    if (groupedItems.containsKey(cat)) {
      groupedItems[cat]!.add(item);
    } else {
      groupedItems[cat] = [item];
    }
  }

  print(groupedItems);
}

void add(Map<String, List<Map<String, dynamic>>> data) {
  final entries = data.entries;
  final momo = entries.elementAt(2);
  momo.value.add({"name": "roasted", "price": 200});
  Map<String, dynamic> newMap = {"name": "fried", "price": 170};
  momo.value.addAll({newMap});
  Map<String, List<Map<String, dynamic>>> listOfMap = {
    "choumin": [
      {"name": "veg"},
      {"name": "chicken"}
    ]
  };
  data.addEntries(listOfMap.entries);

  // data.addAll(listOfMap);
}

void display(Map<String, List<Map<String, dynamic>>> product) {
  print(product.entries);
}

void update(Map<String, List<Map<String, dynamic>>> product) {
  const keyToCheck = "tea"; // Replace with the key you want to check

  if (product.containsKey(keyToCheck)) {
    final tea = product[keyToCheck];
    final x = tea!.indexWhere((element) =>
        element['name'] ==
        "green tea"); //return index of element of tea whone name is green tea
    tea.elementAt(3).update("name",
        (v) => "updated"); //update name of teal element whose index is 3
    bool y = tea.every((element) =>
        element['price'] <
        100); //return true if every  element of tea price is less than 100
    final i = tea.firstWhere((element) =>
        element['price'] ==
        50); ////return first element of tea whose price is 50
    int z = tea.indexOf(i); //find index of fiven element
    final data = tea.any((element) {
      return element['price'] == 100; //return  true if given condition is match
    });
    final contains = tea.contains({
      {
        "name": "Americano",
        "price": 200
      }, //return true ifgiven element is present
    });
    final length = tea.length;
    final a = tea.where((element) =>
        element['price'] ==
        40); //return element which match the given condition
    tea.insert(length,
        {"name": "added", "price": 300}); //add the given eleemnt to given index
    tea.sort(
      (a, b) {
        return a['price'] -
            b['price']; //sort the  element on the basis of price in ascending order
      },
    );
    tea.add({"name": "add", "price": 20}); //add given element
    tea.sort((a, b) {
      return a['price'].compareTo(
          b['price']); //sort the list based on price in ascending order
    });
    final join = tea.join(","); //join the list elemnet with comma separated

    print("join");
    print(join);
    final sumof = tea
        .map((ele) => ele['price'])
        .reduce((sum, price) => sum + price); //return sum of price of tea
    final c = tea.sublist(2, 4); //return list of element between index 2 and 4
    print(c);
    print(sumof);
    print(a);
    print(contains);
    print(data);

    print("$keyToCheck is present in the map.");
    print(tea);
  } else {
    print("$keyToCheck is not present in the map.");
  }
}

void generateRandomPassword() {
  String alpha =
      "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNPOQRSTUVWXYZ0123456789@#?";
  String password = "";
  int length = 8;
  for (var i = 0; i < length; i++) {
    int randIndex = Random().nextInt(alpha.length);
    password += alpha[randIndex];
  }
  print("random password");
  print(password);
  checkAllCharacter(password);
}

void checkAllCharacter(String text) {
  const lowercaseChars = 'abcdefghijklmnopqrstuvwxyz';
  const uppercaseChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  const digitChars = '0123456789';
  const specialChars = '!@#\$%^&*()_-+=<>?/[]{}|';

  bool lowercaseDetected = false;
  bool uppercaseDetected = false;
  bool digitsDetected = false;
  bool specialCharsDetected = false;

  for (var char in text.runes) {
    final charString = String.fromCharCode(char);

    if (lowercaseChars.contains(charString)) {
      lowercaseDetected = true;
    } else if (uppercaseChars.contains(charString)) {
      uppercaseDetected = true;
    } else if (digitChars.contains(charString)) {
      digitsDetected = true;
    } else if (specialChars.contains(charString)) {
      specialCharsDetected = true;
    }
  }

  if (lowercaseDetected) {
    print("Lowercase detected");
  }
  if (uppercaseDetected) {
    print("Uppercase detected");
  }
  if (digitsDetected) {
    print("Digits detected");
  }
  if (specialCharsDetected) {
    print("Special characters detected");
  }
}
