import 'package:flutter/material.dart';
import 'package:intro_dio/models/user_model.dart';
import 'package:intro_dio/service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<UserModel> posts = [];

  @override
  void initState() {
    super.initState();
    getPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("เนื้อหา = ${posts[index].title}"),
          );
        },
      ),
    );
  }

  void getPost() async {
    var p = await Service().getPosts();
    setState(() {
      posts = p;
    });
  }
}
