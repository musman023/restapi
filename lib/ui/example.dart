import 'dart:convert';

import 'package:api/Models/posts_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleOne extends StatefulWidget {
  const ExampleOne({super.key});

  @override
  State<ExampleOne> createState() => _ExampleOneState();
}

List<PostsModel> postList = [];

Future<List<PostsModel>> getPostApi() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
  var data = jsonDecode(response.body) as List<dynamic>;
  if (response.statusCode == 200) {
    for (Map<String, dynamic> i in data) {
      postList.add(PostsModel.fromJson(i));
    }
    return postList;
  } else {
    return postList;
  }
}

class _ExampleOneState extends State<ExampleOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Api Integration"),
      ),
      body: Expanded(
        child: FutureBuilder(
            future: getPostApi(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                    itemCount: postList.length,
                    itemBuilder: (context, index) {
                      return Card(
                          child: ListTile(
                        leading: Text(
                          postList[index].id.toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                        title: Text(postList[index].title.toString()),
                      ));
                    });
              }
            }),
      ),
    );
  }
}
