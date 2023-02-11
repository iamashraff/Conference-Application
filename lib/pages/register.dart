import 'package:flutter/material.dart';
import 'login.dart';
import 'package:conference_app/models/user.dart';
import 'package:conference_app/services/dbhelper.dart';
import 'package:dialogs/dialogs.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  late DatabaseHelper dbHelper;
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
              image: AssetImage('assets/images/register.png'),
              fit: BoxFit.cover),
        ),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          backgroundColor: Colors.transparent,
          body: Stack(children: [
            Container(
              padding: const EdgeInsets.only(left: 35, top: 60),
              child: const Text(
                "Create Account",
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    right: 35,
                    left: 35,
                    top: MediaQuery.of(context).size.height * 0.27),
                child: Column(children: [
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      errorText:
                          _validateUsername ? 'Username cannot empty.' : null,
                      errorStyle: TextStyle(
                        color: Colors.red.shade900,
                      ),
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Color.fromRGBO(80, 85, 97, 1.0)),
                      ),
                      hintText: 'Username',
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(5, 49, 73, 1.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      errorText:
                          _validatePassword ? 'Password cannot empty.' : null,
                      errorStyle: TextStyle(
                        color: Colors.red.shade900,
                      ),
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(80, 85, 97, 1.0),
                        ),
                      ),
                      hintText: 'Password',
                      hintStyle: const TextStyle(
                        color: Color.fromRGBO(5, 49, 73, 1.0),
                      ),
                    ),
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
                                  builder: (context) => const MyLogin()),
                            );
                          },
                          child: Row(
                            children: const [
                              Text(
                                "Already registered ?  ",
                                style: TextStyle(
                                  color: Color.fromRGBO(53, 56, 64, 1.0),
                                ),
                              ),
                              Text("Login",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    color: Colors.blue,
                                  )),
                            ],
                          ),
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor:
                              const Color.fromRGBO(229, 29, 97, 1.0),
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
                                int? check = await checkUserExist();
                                if (check != 0) {
                                  showDialog('Registration Failed',
                                      'Username already exist in the system.\nPlease register with a different username!');
                                } else {
                                  addUser();
                                  setState(() {});
                                  String username = usernameController.text;
                                  showDialog('Registration Success',
                                      'Successfully registered your username: $username .\nYou may now login.');
                                  usernameController.clear();
                                  passwordController.clear();
                                  Navigator.pop(context);
                                }
                              }
                            },
                            icon: const Icon(Icons.arrow_forward),
                          ),
                        ),
                      ]),
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

  Future<void> showDialogSuccess(String title, String message) async {
    MessageDialog messageDialog = MessageDialog(
      dialogBackgroundColor: Colors.white,
      buttonOkColor: const Color.fromRGBO(229, 29, 97, 1.0),
      title: title,
      titleColor: Colors.black,
      message: message,
      messageColor: Colors.black,
      buttonOkText: 'Ok',
      dialogRadius: 5.0,
      buttonRadius: 5.0,
    );
    messageDialog.show(context, barrierColor: Colors.white);
  }

  Future<int?> checkUserExist() async {
    String username = usernameController.text;
    int? check = await dbHelper.checkUserExist(username);
    return check;
  }

  Future<int> addUser() async {
    String username = usernameController.text;
    String password = passwordController.text;
    User user = User(username: username, password: password);
    return await dbHelper.insertUser(user);
  }
}
