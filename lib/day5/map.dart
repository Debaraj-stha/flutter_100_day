void main() {
  Map<String, dynamic> users = {"name": "hari ", "address": "Dharan"};
  Map<String, dynamic> newMap = {"phone": "93883838"};
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
  // showData(users);
  // print("adding fields...");
  // addField(newMap, users);
  // showData(users);
  // print("deleting field");
  // deleteField(users);
  // showData(users);
  // print("updating field");
  // updateValue(users);
  // showData(users);
  // getAllKeys(users);
  // getAllValues(users);
  // print("adding entries");
  // addEntries(users);
  // showData(users);
  // updateAll(newMap);
  // showData(newMap);
  // mapData(users);
  // contains(users);
}

void addField(Map<String, dynamic> newMap, Map<String, dynamic> mainMap) {
  mainMap.addAll(newMap);
  
}

void deleteField(Map<String, dynamic> mainMap) {
  mainMap.remove('name');
}

void updateValue(Map<String, dynamic> data) {
  data['name'] = "updatedname";
  data.update("address", (value) => "biratnagar");
}

void showData(Map<String, dynamic> users) {
  print(users);
}

void getAllKeys(Map<String, dynamic> users) {
  print("all keys");
  final keys = users.keys;
  print(keys);
}

void getAllValues(Map<String, dynamic> users) {
  print("all values");
  final values = users.values;
  print(values);
}

void addEntries(Map<String, dynamic> users) {
  Map<String, dynamic> newEntries = {"age": 30, "email": "hari@example.com"};
  users.addEntries(newEntries.entries);

  print(users);
  print("users");
}

void updateAll(Map<String, dynamic> users) {
  users.updateAll((key, value) {
    return users[key] = "$value updatesd";
  });
}

void mapData(Map<String, dynamic> users) {
  users.forEach((key, value) {
    print("$key=> ${users[key]}");
  });
}

void contains(Map<String, dynamic> users) {
  bool x = users.containsKey('name');
  print(x);
}
