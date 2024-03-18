import 'dart:convert';

import 'package:api/Models/user_model.dart';
import 'package:api/Widgets/row.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleTwo extends StatefulWidget {
  const ExampleTwo({super.key});

  @override
  State<ExampleTwo> createState() => _ExampleTwoState();
}

List<UserModel> userList = [];
Future<List<UserModel>> getUserApi() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
  var data = jsonDecode(response.body) as List<dynamic>;
  if (response.statusCode == 200) {
    for (Map<String, dynamic> i in data) {
      userList.add(UserModel.fromJson(i));
    }
    return userList;
  } else {
    return userList;
  }
}

class _ExampleTwoState extends State<ExampleTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Api Integration"),
      ),
      body: Expanded(
          child: FutureBuilder(
              future: getUserApi(),
              builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              RowWidget(
                                  title: 'Name',
                                  value: snapshot.data![index].name.toString()),
                              RowWidget(
                                  title: 'Username',
                                  value: snapshot.data![index].username
                                      .toString()),
                              RowWidget(
                                  title: 'Email',
                                  value:
                                      snapshot.data![index].email.toString()),
                              RowWidget(
                                  title: 'Phone',
                                  value:
                                      snapshot.data![index].phone.toString()),
                              RowWidget(
                                  title: 'Company Name',
                                  value: snapshot.data![index].company!.name
                                      .toString()),
                              RowWidget(
                                  title: 'Address',
                                  value:
                                      '${snapshot.data![index].address!.street}, ${snapshot.data![index].address!.city}'),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              })),
    );
  }
}
