import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;

import 'list_product.dart';

class CategoeryPage extends StatefulWidget {
  const CategoeryPage({super.key});

  @override
  State<CategoeryPage> createState() => _CategoeryPageState();
}

class _CategoeryPageState extends State<CategoeryPage> {
  Future? myFuture;
  var myDataList = [];
  Future<List> fetchData() async {
    try {
      var url =
          Uri.https('akashsir.in', 'myapi/at-quotes/api/api-list-category.php');
      var response = await https.get(url);

      print('Response status: ${response.statusCode}');
      print(
          'Response body: ${response.body}'); //myDataList = json.decode(response.body);
      Map<String, dynamic> mymap = json.decode(response.body);
      myDataList = mymap["category_list"];
      return myDataList;
    } catch (error) {
      throw error;
    }
  }

  @override
  void initState() {
    myFuture = fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<dynamic>(
          future: myFuture,
          builder: (context, snapshot) {
            ///Condition
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong :('));
            }
            //ListView
            return Scaffold(
              appBar: AppBar(
                title: Text('Category Page'),
              ),
              body: Container(
                child: GridView.builder(
                  itemCount: snapshot.data.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                  ),
                  itemBuilder: (context, index) {
                    return Card(
                        child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              snapshot.data[index]['category_image']),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          var c_id = myDataList[index]['category_id'];
                          var c_name = myDataList[index]['category_name'];
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => ListProduct(
                                        c_id: c_id,
                                        c_name: c_name,
                                      ))));
                        },
                      ),
                      //() {
                      //   var s_id = (index + 1).toString();
                      //   Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: ((context) => SubCategoeryPage(
                      //                 s_id: s_id,
                      //               ))));
                      // },
                      //title: image
                      // Image.network(
                      //   snapshot.data[index]['category_image'],
                      //   height: 160,
                      //   width: 160,
                      // ),
                      // title:
                      //     Text(snapshot.data[index]['category_image'].toString()),
                      //title: Text(snapshot.data[index]['category_name'].toString()),),
                    ));
                  },
                ),
              ),
              // ListView.builder(
              //   itemCount: snapshot.data.length,
              //   itemBuilder: (context, index) {
              //     return Card(
              //         child: ListTile(
              //       onTap: () {
              //         var s_id = (index + 1).toString();
              //         Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //                 builder: ((context) => SubCategoeryPage(
              //                       s_id: s_id,
              //                     ))));
              //       },
              //       leading: Image.network(
              //         snapshot.data[index]['category_image'],
              //         height: 60,
              //         width: 60,
              //       ),
              //       title:
              //           Text(snapshot.data[index]['category_name'].toString()),
              //       //title: Text(snapshot.data[index]['category_name'].toString()),),
              //     ));
              //   },
              // ),
            );
          }),
    );
  }
}
