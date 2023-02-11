import 'package:flutter/material.dart';
import 'register.dart';
import 'package:conference_app/services/dbhelper.dart';
import 'package:dialogs/dialogs.dart';
import 'package:conference_app/pages/tabbar.dart';
import 'package:conference_app/util/Singleton.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  late DatabaseHelper dbHelper;
  Singleton session = Singleton.instance;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  String errorMsg = "";
  bool _validateUsername = false;
  bool _validatePassword = false;

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper();
    dbHelper.initDB().whenComplete(() async {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/login.png'), fit: BoxFit.cover),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(children: [
            Container(
              padding: const EdgeInsets.only(left: 80, top: 155),
              child: const Text(
                "EZConference",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 5, top: 135),
              child: Image.asset('assets/images/logo.png'),
              height: 210,
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    right: 35,
                    left: 35,
                    top: MediaQuery.of(context).size.height * 0.5),
                child: Column(children: [
                  Row(
                    children: const [
                      Text(
                        'Sign In',
                        style: TextStyle(
                          color: Color.fromRGBO(5, 49, 73, 1.0),
                          fontSize: 27,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      errorText:
                          _validateUsername ? 'Username cannot empty.' : null,
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintText: 'Username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      errorText:
                          _validatePassword ? 'Password cannot empty.' : null,
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Text(
                    errorMsg,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyRegister()),
                          );
                        },
                        child: Row(
                          children: const [
                            Text(
                              "Don't have account ? ",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            Text("Register",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                )),
                          ],
                        ),
                      ),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: const Color.fromRGBO(229, 29, 97, 1.0),
                        child: IconButton(
                          color: Colors.white,
                          onPressed: () async {
                            setState(() {
                              usernameController.text.isEmpty
                                  ? _validateUsername = true
                                  : _validateUsername = false;
                            });
                            setState(() {
                              passwordController.text.isEmpty
                                  ? _validatePassword = true
                                  : _validatePassword = false;
                            });

                            if (usernameController.text.isEmpty ||
                                passwordController.text.isEmpty) {
                              showDialog('Error',
                                  'Username or password cannot be empty');
                            } else {
                              int? check = await checkLogin();
                              String? getID = await getuserID();
                              if (check != 0) {
                                String username = usernameController.text;
                                session.setUsername(username);
                                session.setUserID(getID!);
                                showDialog('Logged In', 'Welcome, $username');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const MyMenu()),
                                );
                                passwordController.clear();
                              } else {
                                showDialog('Error',
                                    'Username or password is incorrect');
                              }
                            }
                          },
                          icon: const Icon(Icons.arrow_forward),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Future<void> showDialog(String title, String message) async {
    MessageDialog messageDialog = MessageDialog(
      dialogBackgroundColor: Colors.white,
      buttonOkColor: const Color.fromRGBO(229, 29, 97, 1.0),
      title: title,
      titleColor: Colors.black,
      message: message,
      messageColor: Colors.black,
      buttonOkText: 'Okay',
      dialogRadius: 5.0,
      buttonRadius: 5.0,
    );
    messageDialog.show(context, barrierColor: Colors.white);
  }

  Future<int?> checkLogin() async {
    String username = usernameController.text;
    String password = passwordController.text;
    int? check = await dbHelper.checkLogin(username, password);
    return check;
  }

  Future<String?> getuserID() async {
    String username = usernameController.text;
    String? getID = await dbHelper.getUserID(username);
    return getID;
  }
}
