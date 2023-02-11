import 'dart:async';
import 'package:conference_app/models/specialize.dart';
import 'package:conference_app/models/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:conference_app/models/conference.dart';

class DatabaseHelper {
  static final DatabaseHelper _databaseHelper = DatabaseHelper._();

  DatabaseHelper._();

  late Database db;

  factory DatabaseHelper() {
    return _databaseHelper;
  }

  Future<void> initDB() async {
    String path = await getDatabasesPath();
    db = await openDatabase(
      join(path, 'usertest.db'),
      onCreate: (database, version) async {
        await database.execute(
          """
            CREATE TABLE users (
              id INTEGER PRIMARY KEY AUTOINCREMENT, 
              username TEXT NOT NULL,
              password TEXT NOT NULL
            )
          """,
        );
        await database.execute(
          """
            CREATE TABLE specialize_area (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              area TEXT NOT NULL,
              description TEXT NULL,
              imageUrl TEXT NULL
              )
          """,
        );
        await database.execute(
          """
            CREATE TABLE conference_info (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT NOT NULL,
              email TEXT NOT NULL,
              phone INTEGER NOT NULL,
              role TEXT NOT NULL,
              specialize INTEGER NOT NULL,
              user INTEGER NOT NULL,
              FOREIGN KEY(specialize) REFERENCES specialize_area(id),
              FOREIGN KEY(user) REFERENCES users(id)
            )
          """,
        );
        await database.execute(
          """
            INSERT INTO  users ('id', 'username', 'password')
            VALUES (1, 'test', 'test')

          """,
        );
        await database.execute(
          """
            INSERT INTO  specialize_area ('id', 'area', 'description', 'imageUrl')
            VALUES (1, 'Artificial Intelligence', 'Artificial intelligence is the simulation of human intelligence processes by machines, especially computer systems. Specific applications of AI include expert systems, natural language processing, speech recognition and machine vision.', 'assets/images/ai.png')
          """,
        );
        await database.execute(
          """
            INSERT INTO  specialize_area ('id', 'area', 'description', 'imageUrl')
            VALUES (2, 'Data Mining', 'Data mining is the process of sorting through large data sets to identify patterns and relationships that can help solve business problems through data analysis.', 'assets/images/dm.png')
          """,
        );
        await database.execute(
          """
            INSERT INTO  specialize_area ('id', 'area', 'description', 'imageUrl')
            VALUES (3, 'Computer Security', 'Computer security, also called cybersecurity, is the protection of computer systems and information from harm, theft, and unauthorized use.', 'assets/images/cs.png')
          """,
        );
        await database.execute(
          """
            INSERT INTO  specialize_area ('id', 'area', 'description', 'imageUrl')
            VALUES (4, 'Internet of Things', 'The Internet of Things describes physical objects with sensors, processing ability, software, and other technologies that connect and exchange data with other devices and systems over the Internet or other communications networks.', 'assets/images/iot.png')
          """,
        );
        await database.execute(
          """
            INSERT INTO  specialize_area ('id', 'area', 'description', 'imageUrl')
            VALUES (5, 'Software Engineering', 'Software engineering is a systematic engineering approach to software development. A software engineer is a person who applies the principles of software engineering to design, develop, maintain, test, and evaluate computer software.', 'assets/images/se.png')
          """,
        );
      },
      version: 1,
    );
  }

  Future<int> insertUser(User user) async {
    int result = await db.insert('users', user.toMap());
    return result;
  }

  Future<int> insertConference(Conference conference) async {
    int result = await db.insert('conference_info', conference.toMap());
    return result;
  }

  Future<int> updateConference(Conference conference) async {
    Database db = await this.db;
    return await db.update('conference_info', conference.toMap(),
        where: 'id = ?', whereArgs: [conference.id]);
  }

  Future<int?> checkLogin(String username, String password) async {
    Database db = await this.db;
    var result = Sqflite.firstIntValue(await db.rawQuery(
        "SELECT COUNT (*) FROM users WHERE username = '$username' AND password = '$password'"));
    return result;
  }

  Future<String?> getUserID(String username) async {
    Database db = await this.db;
    String sql = "SELECT id FROM users WHERE username = '$username'";
    var dbQuery = await db.rawQuery(sql);
    if (dbQuery.length > 0) {
      String result = dbQuery.first.values.first.toString();
      return result;
    } else {
      return null;
    }
  }

  Future<String> getSpecializeName(int specializeID) async {
    Database db = await this.db;
    String sql = "SELECT area FROM specialize_area WHERE id = $specializeID";
    var dbQuery = await db.rawQuery(sql);
    if (dbQuery.length > 0) {
      String defn = dbQuery.first.values.first.toString();
      return defn;
    } else {
      return "";
    }
  }

  Future<int?> checkUserExist(String username) async {
    Database db = await this.db;
    var result = Sqflite.firstIntValue(await db
        .rawQuery("SELECT COUNT (*) FROM users WHERE username = '$username'"));
    return result;
  }

  Future<List<User>> retrieveUsers() async {
    final List<Map<String, Object?>> queryResult = await db.query('users');
    return queryResult.map((e) => User.fromMap(e)).toList();
  }

  Future<List<Specialize>> retrieveSpecialize() async {
    final List<Map<String, Object?>> queryResult =
        await db.query('specialize_area');
    return queryResult.map((e) => Specialize.fromMap(e)).toList();
  }

  Future<List<Conference>> retrieveConference(int id) async {
    final List<Map<String, Object?>> queryResult = await db.query(
      'conference_info',
      where: "user = ?",
      whereArgs: [id],
    );
    return queryResult.map((e) => Conference.fromMap(e)).toList();
  }

  Future<int?> getCount() async {
    Database db = await this.db;
    var result =
        Sqflite.firstIntValue(await db.rawQuery("SELECT COUNT (*) FROM users"));
    return result;
  }

  Future<void> deleteUser(int id) async {
    await db.delete(
      'users',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> deleteConference(int id) async {
    await db.delete(
      'conference_info',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
