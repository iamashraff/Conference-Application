import 'package:conference_app/pages/participate.dart';
import 'package:flutter/material.dart';

import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:conference_app/util/CustomShape.dart';
import 'package:conference_app/pages/event.dart';
import 'package:dialogs/dialogs.dart';
import 'package:conference_app/util/Singleton.dart';
import 'package:conference_app/pages/account.dart';

void main() => runApp(const MyMenu());

class MyMenu extends StatefulWidget {
  const MyMenu({Key? key}) : super(key: key);

  @override
  _MyMenuState createState() => _MyMenuState();
}

class _MyMenuState extends State<MyMenu> {
  int _selectedIndex = 0;
  Singleton session = Singleton.instance;
  @override
  void initState() {
    super.initState();
  }

  List<Widget> tabItems = [
    const Center(child: MyEvent()),
    Center(child: MyParticipate()),
    const Center(child: MyAccount()),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          toolbarHeight: 150,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          flexibleSpace: ClipPath(
            clipper: Customshape(),
            child: Container(
              height: 350,
              width: MediaQuery.of(context).size.width,
              color: const Color.fromRGBO(229, 29, 97, 1.0),
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(90, 120, 0, 0),
                    child: Image.asset('assets/images/logo.png'),
                    height: 450,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(170, 140, 0, 0),
                    child: const Text(
                      'EZConference',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(300, 55, 0, 0),
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                      ),
                      icon: const Icon(Icons.logout),
                      label: const Text('Logout'),
                      onPressed: () {
                        showDialogSuccess('Logged out',
                            'You have been successfully logged out.');
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 68, 0, 0),
                    child: Text(
                      'Hi, ' + session.getUsername().toString(),
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Center(
          child: tabItems[_selectedIndex],
        ),
        bottomNavigationBar: FlashyTabBar(
          animationCurve: Curves.linear,
          selectedIndex: _selectedIndex,
          showElevation: true, // use this to remove appBar's elevation
          onItemSelected: (index) => setState(() {
            _selectedIndex = index;
          }),
          items: [
            FlashyTabBarItem(
              activeColor: const Color.fromRGBO(229, 29, 97, 1.0),
              icon: const Icon(Icons.event_available),
              title: const Text('Events'),
            ),
            FlashyTabBarItem(
              activeColor: const Color.fromRGBO(229, 29, 97, 1.0),
              icon: const Icon(Icons.group_add),
              title: const Text('Participate'),
            ),
            FlashyTabBarItem(
              activeColor: const Color.fromRGBO(229, 29, 97, 1.0),
              icon: const Icon(Icons.account_circle),
              title: const Text('My Account'),
            ),
          ],
        ),
      ),
    );
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
}
