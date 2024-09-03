import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'PostModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

//Create a List to Store the Data:
List<PostModel> postlist = [];

//Create an Asynchronous Function to Fetch Data:
Future<List<PostModel>> getPostApi() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
  var data = jsonDecode(response.body.toString());

  if (response.statusCode == 200) {
    for (Map i in data) {
      postlist.add(PostModel.fromJson(i));
    }
    return postlist;
  } else {
    return postlist;
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getPostApi(); // Fetch data when the screen is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API'),
      ),
      body: FutureBuilder(
        future: getPostApi(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: postlist.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(postlist[index].title),
                  subtitle: Text(postlist[index].body),
                );
              },
            );
          }
        },
      ),
    );
  }
}
