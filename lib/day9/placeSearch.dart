import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class SearchPlace extends StatefulWidget {
  const SearchPlace({super.key});

  @override
  State<SearchPlace> createState() => _SearchPlaceState();
}

class _SearchPlaceState extends State<SearchPlace> {
  final TextEditingController _controller = TextEditingController();
  var uuid = const Uuid();
  String token = "1234";
  List<dynamic> places = [];

  @override
  void initState() {
    // TODO: implement initState
    _controller.addListener(() {
      onchange();
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();

    super.dispose();
  }

  void onchange() {
    if (token == null) {
      setState(() {
        token = uuid.v4();
      });
    }
    getSuggestiuon(_controller.text);
  }

  void getSuggestiuon(String text) async {
    print("text $text");
    String key = "AIzaSyDQ2c_pOSOFYSjxGMwkFvCVWKjYOM9siow";
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request = '$baseURL?input=$text&key=$key&sessiontoken=$token';
    final response = await http.get(Uri.parse(request));
    if (response.statusCode != 200) {
      print("response is not come from server");
      return;
    }
    var place = jsonDecode(response.body.toString())['predictions'];
    if (text != " " || text.isNotEmpty) {
      setState(() {
        places = place;
      });
    }
    print(places);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search place"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(
                controller: _controller,
                decoration: const InputDecoration(hintText: "Search place..."),
              ),
              places.isNotEmpty
                  ? ListView.builder(
                      itemCount: places.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(places[index]['description']),
                        );
                      })
                  : Container(
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        "Search places appear here",
                        style: TextStyle(fontSize: 20),
                      ))
            ],
          ),
        ),
      ),
    );
  }
}
