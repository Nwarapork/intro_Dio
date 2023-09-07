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
  Either<UserModel, String> result_1 =
      Left(UserModel(id: 0, userId: 0, body: "No data", title: "no title"));
  Either<UserModel, String> result_post =
      Left(UserModel(id: 0, userId: 0, body: "No data", title: "no title"));
  Either<UserModel, String> result_put =
      Left(UserModel(id: 0, userId: 0, body: "No data", title: "no title"));
  List<UserModel> posts = [];

  void getPost() async {
    var r = await Service().getPosts();
    var r_1 = await Service().getPost(1);
    var r_post = await Service()
        .createPost(1, 'test title by Dio ❤️', 'test body from Dio 📖');
    var r_put = await Service()
        .updatePost(1, 123, "just update data", "พึ่ง update นะงับ");
    await Service().deletePost(1);
    setState(() {
      result = r;
      result_1 = r_1;
      result_post = r_post;
      result_put = r_put;
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
    return Scaffold(
      body: SafeArea(
        // child: result.fold(
        //   (l) {
        //     return ListView.builder(
        //       itemCount: l.length,
        //       itemBuilder: (context, index) {
        //         return Card(
        //           elevation: 2, // เพิ่มเงาบางน้อย
        //           margin: const EdgeInsets.symmetric(
        //               vertical: 8, horizontal: 16), // กำหนดขอบระหว่างรายการ
        //           child: ListTile(
        //             title: Text(
        //               "Title: ${l[index].title}",
        //               style: const TextStyle(
        //                   fontSize: 18, fontWeight: FontWeight.bold),
        //             ),
        //             subtitle: Text("ID: ${l[index].id}"), // เพิ่มข้อมูลย่อย
        //           ),
        //         );
        //       },
        //     );
        //   },
        //   (r) {
        //     return Center(
        //       child: Column(
        //         children: [
        //           Text(r),
        //           ElevatedButton(
        //               onPressed: () => getPost(),
        //               child: const Text('Press for something'))
        //         ],
        //       ),
        //     );
        //   },
        // ),
        child: result_put.fold(
          (l) {
            return Card(
              elevation: 2, // เพิ่มเงาบางน้อย
              margin: const EdgeInsets.symmetric(
                  vertical: 8, horizontal: 16), // กำหนดขอบระหว่างรายการ
              child: ListTile(
                title: Text(
                  "Title: ${l.title}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text("ID: ${l.body}"), // เพิ่มข้อมูลย่อย
              ),
            );
          },
          (r) {
            return Center(
              child: Column(
                children: [
                  Text(r),
                  ElevatedButton(
                      onPressed: () => getPost(),
                      child: const Text('Press for something'))
                ],
              ),
            );
          },
        ),
      ),
    );
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
