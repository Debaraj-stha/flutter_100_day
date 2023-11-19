import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart' as shared;

class SharedPreferences extends StatefulWidget {
  const SharedPreferences({super.key});

  @override
  State<SharedPreferences> createState() => _SharedPreferencesState();
}

class _SharedPreferencesState extends State<SharedPreferences> {
  static String stringKey = "string";
  static String boolKey = "bool";
  static String listKey = "list";
  void storeStringValue() async {
    final sp = await shared.SharedPreferences.getInstance();
    sp.setString(stringKey, "Jeevan Shrestha");
  }

  void storeBooleanValue() async {
    final sp = await shared.SharedPreferences.getInstance();
    sp.setBool(boolKey, true);
  }

  void storeStringListValue() async {
    final sp = await shared.SharedPreferences.getInstance();
    List<String> list = ['a', 'b', 'c', 'd', 'e', 'f'];
    sp.setStringList(listKey, list);
  }

  void getStoreValues() async {
    final sp = await shared.SharedPreferences.getInstance();
    bool? boolValue = sp.getBool(boolKey);

    String? stringValue = sp.getString(stringKey);
    List<String>? listValue = sp.getStringList(listKey);
    print(listValue);
    print(stringValue);
    print(boolValue);
  }

  void removeStringList() async {
    final sp = await shared.SharedPreferences.getInstance();

    bool containsKey = sp.containsKey(listKey);
    if (containsKey) {
      sp.remove(listKey);
    } else {
      print("key not found");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shared preference"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              TextButton(
                  onPressed: () {
                    storeStringValue();
                  },
                  child: const Text("Store String")),
              TextButton(
                  onPressed: () {
                    storeBooleanValue();
                  },
                  child: const Text("Store boolean")),
              TextButton(
                  onPressed: () {
                    storeStringListValue();
                  },
                  child: const Text("Store List")),
              TextButton(
                  onPressed: () {
                    getStoreValues();
                  },
                  child: const Text("get stored value")),
              TextButton(
                  onPressed: () {
                    removeStringList();
                  },
                  child: const Text("remove string list")),
              TextButton(
                  onPressed: () async {
                    final sp = await shared.SharedPreferences.getInstance();
                    sp.clear();
                    print("shared preferences is cleared");
                  },
                  child: const Text("clear shared preferences")),
            ],
          ),
        ),
      ),
    );
  }
}
