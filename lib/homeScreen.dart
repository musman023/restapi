// ignore_for_file: prefer_const_constructors

import 'dart:convert';

// import 'package:api/Models/posts_model.dart';
import 'package:api/Models/products_model.dart';
// import 'package:api/Models/user_model.dart';
// import 'package:api/Widgets/row.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

Future<ProductsModel> getProductsApi() async {
  final response = await http.get(
      Uri.parse('https://webhook.site/8df1e1b3-4aff-4df0-8739-d22657028c73'));
  var data = jsonDecode(response.body.toString());
  if (response.statusCode == 200) {
    return ProductsModel.fromJson(data);
  } else {
    return ProductsModel.fromJson(data);
  }
}

// List<UserModel> userList = [];
// Future<List<UserModel>> getUserApi() async {
//   final response =
//       await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
//   var data = jsonDecode(response.body) as List<dynamic>;
//   if (response.statusCode == 200) {
//     for (Map<String, dynamic> i in data) {
//       userList.add(UserModel.fromJson(i));
//     }
//     return userList;
//   } else {
//     return userList;
//   }
// }

// List<PostsModel> postList = [];

// Future<List<PostsModel>> getPostApi() async {
//   final response =
//       await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
//   var data = jsonDecode(response.body) as List<dynamic>;
//   if (response.statusCode == 200) {
//     for (Map<String, dynamic> i in data) {
//       postList.add(PostsModel.fromJson(i));
//     }
//     return postList;
//   } else {
//     return postList;
//   }
// }

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Api Integration"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Expanded(
                child: FutureBuilder<ProductsModel>(
                    future: getProductsApi(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data!.data!.length,
                            itemBuilder: (context, index) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    title: Text(snapshot
                                        .data!.data![index].shop!.name
                                        .toString()),
                                    subtitle: Text(snapshot
                                        .data!.data![index].shop!.shopemail
                                        .toString()),
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(snapshot
                                          .data!.data![index].shop!.image
                                          .toString()),
                                    ),
                                  ),
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height * .3,
                                    width:
                                        MediaQuery.of(context).size.width * 1,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: snapshot
                                            .data!.data![index].images!.length,
                                        itemBuilder: (context, position) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0, bottom: 10),
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .25,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .5,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          snapshot
                                                              .data!
                                                              .data![index]
                                                              .images![position]
                                                              .url
                                                              .toString()))),
                                            ),
                                          );
                                        }),
                                  ),
                                  Icon(snapshot.data!.data![index].inWishlist ==
                                          true
                                      ? Icons.favorite
                                      : Icons.favorite_outline)
                                ],
                              );
                            });
                      }
                    })

                //  FutureBuilder(
                //     future: getUserApi(),
                //     builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                //       if (!snapshot.hasData) {
                //         return Center(
                //           child: CircularProgressIndicator(),
                //         );
                //       } else {
                //         return ListView.builder(
                //           itemCount: userList.length,
                //           itemBuilder: (BuildContext context, int index) {
                //             return Card(
                //               child: Padding(
                //                 padding: const EdgeInsets.all(8.0),
                //                 child: Column(
                //                   children: [
                //                     RowWidget(
                //                         title: 'Name',
                //                         value: snapshot.data![index].name
                //                             .toString()),
                //                     RowWidget(
                //                         title: 'Username',
                //                         value: snapshot.data![index].username
                //                             .toString()),
                //                     RowWidget(
                //                         title: 'Email',
                //                         value: snapshot.data![index].email
                //                             .toString()),
                //                     RowWidget(
                //                         title: 'Phone',
                //                         value: snapshot.data![index].phone
                //                             .toString()),
                //                     RowWidget(
                //                         title: 'Company Name',
                //                         value: snapshot.data![index].company!.name
                //                             .toString()),
                //                     RowWidget(
                //                         title: 'Address',
                //                         value:
                //                             '${snapshot.data![index].address!.street}, ${snapshot.data![index].address!.city}'),
                //                   ],
                //                 ),
                //               ),
                //             );
                //           },
                //         );
                //       }
                //     })

                //  FutureBuilder(
                //     future: getPostApi(),
                //     builder: (context, snapshot) {
                //       if (!snapshot.hasData) {
                //         return Center(child: CircularProgressIndicator());
                //       } else {
                //         return ListView.builder(
                //             itemCount: postList.length,
                //             itemBuilder: (context, index) {
                //               return Card(
                //                   child: ListTile(
                //                 leading: Text(
                //                   postList[index].id.toString(),
                //                   style: TextStyle(fontSize: 20),
                //                 ),
                //                 title: Text(postList[index].title.toString()),
                //               ));
                //             });
                //       }
                //     }),
                )
          ],
        ),
      ),
    );
  }
}
