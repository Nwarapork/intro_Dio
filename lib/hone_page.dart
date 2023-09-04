import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' show Either, Left;
import 'package:intro_dio/models/user_model.dart';
import 'package:intro_dio/service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Either<List<UserModel>, String> result = const Left([]);
  List<UserModel> posts = [];

  void getPost() async {
    var r = await Service().getPosts();
    setState(() {
      result = r;
    });
  }

  @override
  void initState() {
    super.initState();
    getPost();
  }

  //var result = Service().getPosts();

  @override
  Widget build(BuildContext context) {
    return result.fold<Widget>((l) {
      return Scaffold(
        body: ListView.builder(
          itemCount: l.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text("use Either => ${l[index].title}"),
            );
          },
        ),
      );
    }, (r) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(r),
              ElevatedButton(
                  onPressed: () => getPost(),
                  child: const Text('Press for something'))
            ],
          ),
        ),
      );
    });
  }

  Widget normalBuild(List<UserModel> posts) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text("เนื้อหา = ${posts[index].title}"),
        );
      },
    );
  }

  Widget errorBuild(String errMsg) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(errMsg),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  //result = Service().getPosts();
                });
              },
              child: const Text('Reload 🔄'))
        ],
      ),
    );
  }
}
