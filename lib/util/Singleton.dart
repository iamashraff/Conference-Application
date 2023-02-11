class Singleton {
  // Creating a Field/Property
  String username = "";
  String userid = "";

  // Creating the getter method
  // to get input from Field/Property
  String getUsername() {
    return username;
  }

  void setUsername(String name) {
    username = name;
  }

  String getUserID() {
    return userid;
  }

  void setUserID(String myID) {
    userid = myID;
  }

  Singleton._privateConstructor();

  static final Singleton _instance = Singleton._privateConstructor();

  static Singleton get instance {
    return _instance;
  }
}
