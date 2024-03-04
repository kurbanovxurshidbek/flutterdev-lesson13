import 'package:flutter/material.dart';
import 'package:ngdemo12/service/sql_service.dart';

import '../model/post_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String name = "no data";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var post = Post(title: "NextGen", body: "Academy");
    //SqlService.createPost(post);

    loadPosts();
  }

  loadPosts() async {
    var posts = await SqlService.fetchPosts();
    setState(() {
      name = posts.first.toMap().toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("SQLite"),
      ),
      body: Center(
        child: Text(name),
      ),
    );
  }
}
