import 'package:conference_app/models/specialize.dart';
import 'package:conference_app/services/dbhelper.dart';
import 'package:flutter/material.dart';

class MyEvent extends StatefulWidget {
  const MyEvent({Key? key}) : super(key: key);
  @override
  State<MyEvent> createState() => _MyEvent();
}

class _MyEvent extends State<MyEvent> {
  late DatabaseHelper dbHelper;

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
    return Center(
      child: Column(
        children: [
          Text(
            "Specialization Area",
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
            height: 20,
          ),
          Expanded(
            flex: 2,
            child: SafeArea(child: eventWidget()),
          ),
        ],
      ),
    );
  }

  Widget eventWidget() {
    return FutureBuilder(
      future: dbHelper.retrieveSpecialize(),
      builder:
          (BuildContext context, AsyncSnapshot<List<Specialize>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, position) {
                return Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.black38, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Image.asset(
                          snapshot.data![position].imageUrl,
                          height: 50,
                        ),
                        title: Text(snapshot.data![position].area),
                        subtitle: Text(
                            '\n' + snapshot.data![position].description + '\n'),
                      ),
                    ],
                  ),
                );
              });
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
