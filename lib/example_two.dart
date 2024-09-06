import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleTwo extends StatefulWidget {
  const ExampleTwo({super.key});

  @override
  State<ExampleTwo> createState() => _ExampleTwoState();
}

class _ExampleTwoState extends State<ExampleTwo> {
  List<Photos> photoslist = []; //list is provided photos constructor
  Future<List<Photos>> getPhotos() async {
    //till the time we havent returned list in our if else statements getPhotos()func was showing error bec it was expecting a list to be returned
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        Photos photos = Photos(
            title: i['title'],
            id: i['id'],
            url: i[
                'url']); //photos is the name of the object you're creating. Photos(title: i['title'], url: i['url']) is the constructor of the Photos class that is being called with two arguments: title and url.
        photoslist.add(photos);
      }
      return photoslist;
      //200 means request is valid
    } else {
      return photoslist;
    }
  } //creating future function tht waits for future value and return type is list with its model

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Api Course'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Photos>>(
                future: getPhotos(),
                builder: (context, AsyncSnapshot<List<Photos>> snapshot) {
                  return ListView.builder(
                      itemCount: photoslist.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                snapshot.data![index].url.toString()),
                          ),
                          title: Text(snapshot.data![index].title.toString()),
                          subtitle: Text("Notes id: " +
                              snapshot.data![index].id.toString()),
                        );
                      });
                }),
          )
        ],
      ),
    );
  }
}

class Photos {
  String title, url;
  int id;
  Photos({required this.title, required this.url, required this.id});
}
