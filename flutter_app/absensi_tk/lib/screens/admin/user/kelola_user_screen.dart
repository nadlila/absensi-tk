import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class KelolaUserScreen extends StatefulWidget {
const KelolaUserScreen({super.key});

@override
State<KelolaUserScreen> createState() => _KelolaUserScreenState();
}

class _KelolaUserScreenState extends State<KelolaUserScreen> {

List users = [];

final String baseUrl = "http://10.0.2.2:8080/api/users";

@override
void initState() {
super.initState();
fetchUsers();
}

Future<void> fetchUsers() async {


final response = await http.get(Uri.parse(baseUrl));

if(response.statusCode == 200){
  setState(() {
    users = jsonDecode(response.body);
  });
}


}

Future<void> deleteUser(int id) async {


await http.delete(Uri.parse("$baseUrl/$id"));

fetchUsers();


}

void showUserDialog({Map? user}) {


final usernameController = TextEditingController(
  text: user?["username"] ?? ""
);

final passwordController = TextEditingController(
  text: user?["password"] ?? ""
);

final emailController = TextEditingController(
  text: user?["email"] ?? ""
);

final roleController = TextEditingController(
  text: user?["role"] ?? ""
);

showDialog(
  context: context,
  builder: (context){

    return AlertDialog(

      title: Text(user == null ? "Tambah User" : "Edit User"),

      content: SingleChildScrollView(
        child: Column(
          children: [

            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: "Username"),
            ),

            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: "Password"),
            ),

            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),

            TextField(
              controller: roleController,
              decoration: const InputDecoration(labelText: "Role"),
            ),

          ],
        ),
      ),

      actions: [

        TextButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: const Text("Batal"),
        ),

        ElevatedButton(
          onPressed: () async {

            Map data = {
              "username": usernameController.text,
              "password": passwordController.text,
              "email": emailController.text,
              "role": roleController.text
            };

            if(user == null){

              await http.post(
                Uri.parse(baseUrl),
                headers: {"Content-Type":"application/json"},
                body: jsonEncode(data),
              );

            }else{

              await http.put(
                Uri.parse("$baseUrl/${user["idUser"]}"),
                headers: {"Content-Type":"application/json"},
                body: jsonEncode(data),
              );

            }

            Navigator.pop(context);

            fetchUsers();

          },
          child: const Text("Simpan"),
        )

      ],

    );

  },
);


}

@override
Widget build(BuildContext context) {


return Scaffold(

  appBar: AppBar(
    title: const Text("Kelola User"),
  ),

  floatingActionButton: FloatingActionButton(
    onPressed: (){
      showUserDialog();
    },
    child: const Icon(Icons.add),
  ),

  body: ListView.builder(

    itemCount: users.length,

    itemBuilder: (context,index){

      final user = users[index];

      return ListTile(

        title: Text(user["username"] ?? ""),

        subtitle: Text("${user["email"]} | ${user["role"]}"),

        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [

            IconButton(
              icon: const Icon(Icons.edit,color: Colors.blue),
              onPressed: (){
                showUserDialog(user: user);
              },
            ),

            IconButton(
              icon: const Icon(Icons.delete,color: Colors.red),
              onPressed: (){
                deleteUser(user["idUser"]);
              },
            ),

          ],
        ),

      );

    },

  ),

);


}

}
