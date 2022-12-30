import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'details.dart';

class ListProduct extends StatefulWidget {
  final c_id;
  final c_name;
  const ListProduct({super.key, required this.c_id, required this.c_name});

  @override
  State<ListProduct> createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {
  Future? myFuture;
  var myDataList = [];

  Future _getData() async {
    final c_id1 = {'category_id': widget.c_id};
    var url = Uri.https(
        'akashsir.in', '/myapi/at-quotes/api/api-list-product.php', c_id1);
    var response = await http.get(
      url,
    );
    print(widget.c_id);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var myDataList = json.decode(response.body);

    Map<String, dynamic> mymap = json.decode(response.body);
    myDataList = mymap["product_list"];
    // setState(() {
    //   myDataList;
    // });

    return myDataList;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myFuture = _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.c_name),
        ),
        body: Container(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
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
                  body: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Card(
                          child: ListTile(
                        tileColor:
                            Color.fromARGB(255, 142, 198, 244).withOpacity(0.2),
                        leading: Image.network(
                          snapshot.data[index]['product_image'],
                          width: 80,
                        ),
                        title: Text(snapshot.data[index]['product_title']),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        onTap: () {
                          var c_name = snapshot.data[index]['category_name'];
                          var p_tital = snapshot.data[index]['product_title'];
                          var p_image = snapshot.data[index]['product_image'];
                          var p_id = snapshot.data[index]['product_id'];

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailWidget(
                                  c_name: c_name,
                                  p_tital: p_tital,
                                  p_image: p_image,
                                  p_id: p_id
                                  // cnamea: one,
                                  // p_name: p_name,
                                  // p_image: p_image,
                                  // p_price: p_price,
                                  // p_details: p_details,
                                  // p_id: p_id,
                                  ),
                            ),
                          );
                        },
                      ));
                    },
                  ),
                );
              }),
        ));
  }
}
