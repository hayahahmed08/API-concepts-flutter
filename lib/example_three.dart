import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'UserModel.dart'; // Make sure to import the UserModel

class ExampleThree extends StatefulWidget {
  const ExampleThree({super.key});

  @override
  State<ExampleThree> createState() => _ExampleThreeState();
}

class _ExampleThreeState extends State<ExampleThree> {
  List<UserModel> userList = [];

  // Fetching users from the API
  Future<List<UserModel>> getUserApi() async {
    final response =
    await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());

    // Checking if the response is OK
    if (response.statusCode == 200) {
      for (Map i in data) {
        userList.add(UserModel.fromJson(i));  // Parsing and adding user data
      }
      return userList;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Course'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<UserModel>>(
              future: getUserApi(),
              builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                 if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                // Display the list if data is available
                else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var user = snapshot.data![index];
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(user.id.toString()),
                          ),
                          title: Text(user.name ?? 'No Name'),
                          subtitle: Text(user.email ?? 'No Email'),
                          trailing: Text(user.address?.city ?? 'No City'),
                        ),
                      );
                    },
                  );
                }
                else {
                  return const Center(child: Text('No Data Available'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
