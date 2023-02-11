import 'package:conference_app/services/dbhelper.dart';
import 'package:conference_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:conference_app/util/Singleton.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);
  @override
  State<MyAccount> createState() => _MyAccount();
}

class _MyAccount extends State<MyAccount> {
  late DatabaseHelper dbHelper;
  Singleton session = Singleton.instance;
  final useridController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Text(
              "My Account",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                foreground: Paint()
                  ..shader = const LinearGradient(
                    colors: <Color>[
                      Colors.pinkAccent,
                      Colors.deepPurpleAccent,
                      Colors.red
                    ],
                  ).createShader(
                    const Rect.fromLTWH(0.0, 0.0, 200.0, 100.0),
                  ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              flex: 2,
              child: SafeArea(
                child: Center(
                  child: conferencelistWidget(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget conferencelistWidget() {
    getUser();
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text(
                'Account Information',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          TextField(
            controller: useridController,
            readOnly: true,
            enabled: false,
            style: const TextStyle(fontSize: 16),
            decoration: const InputDecoration(
              labelText: 'User ID',
              contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          TextField(
            controller: usernameController,
            readOnly: true,
            enabled: false,
            style: const TextStyle(fontSize: 16),
            decoration: const InputDecoration(
              labelText: 'Username',
              contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          const Text(
            'EZConference v1.0.0.0',
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          const Text(
            'Developed by Ashraff & Hadif',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  void getUser() {
    usernameController.text = session.getUsername().toString();
    useridController.text = session.getUserID().toString();
  }
}
