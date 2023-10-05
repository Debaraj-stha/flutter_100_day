void main() {
  Map<String, List<Map<String, dynamic>>> product = {
    "tea": [
      {"name": "milk tea", "price": 40},
      {"name": "black tea", "price": 25},
      {"name": "lemon tea", "price": 40},
      {"name": "green tea", "price": 50}
    ],
    "coffiee": [
      {"name": "Americano", "price": 200},
      {"name": "Mocha", "price": 150},
      {"name": "Latte", "price": 120},
      {"name": "Cappuccino", "price": 100}
    ],
    "momo": [
      {"name": "veg", "price": 120},
      {"name": "chicken", "price": 140},
      {"name": "buff", "price": 110},
      {"name": "pork", "price": 140}
    ]
  };
  // display(product);
  // add(product);
  // display(product);
  update(product);
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
    final x = tea!.indexWhere((element) => element['name'] == "green tea");
    tea.elementAt(3).update("name", (v) => "updated");
    bool y = tea.every((element) => element['price'] < 100);
    final i = tea.firstWhere((element) => element['price'] == 50);
    int z = tea.indexOf(i);
    
    print(z);
    print(x);
    print("$keyToCheck is present in the map.");
    print(tea);
  } else {
    print("$keyToCheck is not present in the map.");
  }
}
