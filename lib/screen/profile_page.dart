import 'package:flutter/material.dart';
import 'package:kawi_app/screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? username;
  String? email;
  String? firstName;
  String? lastName;
  String? image;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username');
      email = prefs.getString('email');
      firstName = prefs.getString('firstName');
      lastName = prefs.getString('lastName');
      image = prefs.getString('image');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('profile'),
          leading: IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
        ),
        body: username == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'username : $username',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'email : $email',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'firstName : $firstName',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'lastName : $lastName',
                      style: TextStyle(fontSize: 18),
                    ),
                    Image.network(image!,
                        errorBuilder: (context, error, stackTrace) => Icon(
                              Icons.error,
                              size: 50,
                            ))
                  ],
                ),
              ));
  }
}
