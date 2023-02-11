import 'package:flutter/material.dart';
import 'package:conference_app/services/dbhelper.dart';
import 'package:conference_app/models/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late DatabaseHelper dbHelper;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  late User _user;

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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: usernameController,
              decoration: const InputDecoration(
                  hintText: 'Username', labelText: 'Username'),
            ),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                  hintText: 'Password', labelText: 'Password'),
            ),
            ElevatedButton(
              onPressed: () {
                addUser();
                setState(() {});
              },
              child: const Text('Add'),
            ),
            ElevatedButton(
              onPressed: () {
                checkLogin();
              },
              child: const Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                getUserCount();
              },
              child: const Text('Count'),
            ),
            Expanded(
              flex: 1,
              child: SafeArea(child: userWidget()),
            )
          ],
        ),
      ),
    );
  }

  Widget userWidget() {
    return FutureBuilder(
      future: dbHelper.retrieveUsers(),
      builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, position) {
                return Dismissible(
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: const Icon(Icons.delete_forever),
                    ),
                    key: UniqueKey(),
                    onDismissed: (DismissDirection direction) async {
                      await dbHelper.deleteUser(snapshot.data![position].id!);
                    },
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: Column(
                        children: <Widget>[
                          Card(
                            elevation: 3,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  title:
                                      Text(snapshot.data![position].username),
                                  subtitle:
                                      Text(snapshot.data![position].password),
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            height: 2.0,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ));
              });
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Future<void> getUserCount() async {
    print(await dbHelper.getCount());
  }

  Future<int> addUser() async {
    String username = usernameController.text;
    String password = passwordController.text;
    User user = new User(username: username, password: password);
    return await dbHelper.insertUser(user);
  }

  Future<void> checkLogin() async {
    String username = usernameController.text;
    String password = passwordController.text;
    print(await dbHelper.checkLogin(username, password));
  }

  void clearData() {
    usernameController.clear();
    passwordController.clear();
  }
}
