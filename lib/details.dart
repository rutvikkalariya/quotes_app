import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailWidget extends StatefulWidget {
  final c_name;
  final p_tital;
  final p_image;
  final p_id;
  const DetailWidget({
    super.key,
    required this.c_name,
    required this.p_tital,
    required this.p_image,
    required this.p_id,
  });

  @override
  State<DetailWidget> createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        title: Text(
          widget.c_name,
          style: TextStyle(color: Color(0xFF545D68), fontSize: 24),
        ),
        centerTitle: true,
        // actions: <Widget>[
        //   IconButton(
        //     onPressed: () {},
        //     icon: Icon(
        //       Icons.notifications_none,
        //       color: Color(0xFF545D68),
        //     ),
        //   )
        // ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: 650,
                width: double.infinity,
                decoration: BoxDecoration(
                  //color: Color.fromARGB(255, 244, 219, 219),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0)),
                ),
                child: Image.network(
                  widget.p_image,
                )),
          ],
        ),
      )),
    );
  }
}
