import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:http/http.dart' as http;

class PullRefresshing extends StatefulWidget {
  const PullRefresshing({super.key});

  @override
  State<PullRefresshing> createState() => _PullRefresshingState();
}

class _PullRefresshingState extends State<PullRefresshing> {
  int limit = 3;
  bool isInitialLOading = true;
  int pageNumber = 1;
  final RefreshController _controller = RefreshController(
    initialRefresh: false,
  );
  List<dynamic> items = [];

  Future<void> _initialLoad(
      int limit, bool isInitialLOading, int pageNumber) async {
    print("limit $limit");

    int itemsPerPage = 10;

    int skip = (pageNumber - 1) * itemsPerPage;
    http.Response res = await http.get(
        Uri.parse("https://fakestoreapi.com/products?limit=$limit&skip=$skip"));
    if (!isInitialLOading) {
      items.addAll(jsonDecode(res.body));
    } else {
      items.add(jsonDecode(res.body));
    }
    setState(() {});
    print(items.toString());
    print(items.length);
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));

    limit = limit + 3;
    isInitialLOading = false;
    pageNumber++;
    _initialLoad(limit, isInitialLOading, pageNumber);
    setState(() {});
    _controller.loadComplete();
    print("loading completed");
  }

  void _onRefresh() async {
    _controller.refreshCompleted();
    print("refresh completed");
  }

  @override
  void initState() {
    // TODO: implement initState
    WidgetsFlutterBinding.ensureInitialized();
    _initialLoad(limit, isInitialLOading, pageNumber);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SmartRefresher(
        controller: _controller,
        enablePullUp: true,
        enablePullDown: true,
        onLoading: _onLoading,
        onRefresh: _onRefresh,
        child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(items[index]['title']),
              );
            }),
      )),
    );
  }
}
