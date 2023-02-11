import 'package:flutter/material.dart';
import 'package:conference_app/services/dbhelper.dart';
import 'package:conference_app/models/conference.dart';
import 'package:flutter/services.dart';
import 'package:slide_popup_dialog_null_safety/slide_dialog.dart';
import 'package:slide_popup_dialog_null_safety/slide_popup_dialog.dart'
    as slideDialog;
import 'package:conference_app/pages/tabbar.dart';
import 'package:select_form_field/select_form_field.dart';
import 'tabbar.dart';
import 'package:dialogs/dialogs.dart';
import 'package:conference_app/util/Singleton.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lottie/lottie.dart';

class MyParticipate extends StatefulWidget {
  MyParticipate({Key? key}) : super(key: key);
  @override
  State<MyParticipate> createState() => _MyParticipate();
}

class _MyParticipate extends State<MyParticipate> {
  late DatabaseHelper dbHelper;
  Singleton session = Singleton.instance;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  String rolesString = "";
  String specializeString = "";

  String tempName = "";
  String tempEmail = "";
  String tempPhone = "";
  String tempRoles = "";
  String tempSpecialize = "";
  String tempConferenceID = "";

  final List<Map<String, dynamic>> _roles = [
    {
      'value': 'Participant',
      'label': 'Participant',
      'icon': const Icon(Icons.people_alt),
    },
    {
      'value': 'Presenter',
      'label': 'Presenter',
      'icon': const Icon(Icons.present_to_all_outlined),
    },
    {
      'value': 'Reviewer',
      'label': 'Reviewer',
      'icon': const Icon(Icons.reviews_outlined),
    },
    {
      'value': 'Judges',
      'label': 'Judges',
      'icon': const Icon(Icons.app_registration_outlined),
    },
  ];

  final List<Map<String, dynamic>> _specialize = [
    {
      'value': '1',
      'label': 'Artificial Intelligence',
    },
    {
      'value': '2',
      'label': 'Data Mining',
    },
    {
      'value': '3',
      'label': 'Computer Security',
    },
    {
      'value': '4',
      'label': 'Internet of Things',
    },
    {
      'value': '5',
      'label': 'Software Engineering',
    },
  ];

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
      body: Column(
        children: [
          Text(
            "My Conference(s)",
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
            child: SafeArea(child: conferencelistWidget()),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAction("addConference");
        },
        backgroundColor: Colors.pink,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAction(String action) {
    clearTextField();
    String btnTitle = '';
    String title = '';
    if (action == "addConference") {
      btnTitle = 'Submit Registration';
      title = 'Add conference registration';
      tempRoles = '';
      tempSpecialize = '';
    } else {
      btnTitle = 'Update Registration';
      title = 'Update conference registration';
      nameController.text = tempName;
      emailController.text = tempEmail;
      phoneController.text = '0' + tempPhone;
      rolesString = tempRoles;
      specializeString = tempSpecialize;
    }
    slideDialog.showSlideDialog(
        context: context,
        child: Expanded(
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 1.20,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 17,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      //NAME
                      TextField(
                        controller: nameController,
                        style: const TextStyle(fontSize: 16),
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(fontSize: 16),
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(fontSize: 16),
                        decoration: const InputDecoration(
                          labelText: 'Phone',
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SelectFormField(
                        type: SelectFormFieldType.dialog, // or can be dialog
                        initialValue: tempRoles,
                        dialogTitle: 'Select a role',
                        dialogCancelBtn: 'Cancel',
                        labelText: 'Roles',
                        items: _roles,
                        onChanged: (val) {
                          rolesString = val;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SelectFormField(
                        type: SelectFormFieldType.dialog, // or can be dialog
                        initialValue: tempSpecialize,
                        dialogTitle: 'Select specialize area',
                        dialogCancelBtn: 'Cancel',
                        labelText: 'Specialize Area',
                        items: _specialize,
                        onChanged: (val) {
                          specializeString = val;
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      ElevatedButton.icon(
                        onPressed: () async {
                          if (nameController.text.isEmpty ||
                              emailController.text.isEmpty ||
                              phoneController.text.isEmpty ||
                              rolesString == "" ||
                              specializeString == "") {
                            showDialog('Error',
                                'Registration details cannot be empty');
                          } else {
                            if (action == "addConference") {
                              addConference();
                              setState(() {});
                              showDialog('Success Register',
                                  'Conference has been successfully registered !');
                              clearTextField();
                            } else {
                              updateConference();
                              setState(() {});
                              showDialog('Success Edit',
                                  'Conference has been successfully edited !');
                            }
                          }
                        },
                        icon: const Icon(Icons.check, size: 18),
                        label: Text(btnTitle),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.pinkAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ], mainAxisAlignment: MainAxisAlignment.center),
          ),
        ));
  }

  Widget conferencelistWidget() {
    return FutureBuilder(
      future: dbHelper.retrieveConference(int.parse(session.getUserID())),
      builder:
          (BuildContext context, AsyncSnapshot<List<Conference>> snapshot) {
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          List<String> specialize = [
            "Artificial Intelligence",
            "Data Mining",
            "Computer Security",
            "Internet of Things",
            "Software Engineering"
          ];

          return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, position) {
                return Slidable(
                  // Specify a key if the Slidable is dismissible.
                  key: UniqueKey(),

                  // The start action pane is the one at the left or the top side.
                  startActionPane: ActionPane(
                    // A motion is a widget used to control how the pane animates.
                    motion: const ScrollMotion(),

                    // A pane can dismiss the Slidable.
                    dismissible: DismissiblePane(onDismissed: () async {
                      await dbHelper
                          .deleteConference(snapshot.data![position].id!);

                      setState(() {});
                      showDialog('Conferences details deleted !',
                          'You have successfully deleted a conference details.');
                    }),

                    // All actions are defined in the children parameter.
                    children: [
                      // A SlidableAction can have an icon and/or a label.
                      SlidableAction(
                        onPressed: doNothing,
                        backgroundColor: const Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),

                  // The end action pane is the one at the right or the bottom side.

                  child: Container(
                    margin: const EdgeInsets.all(4),
                    height: 100,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: const BorderSide(color: Colors.black26, width: 1),
                      ),
                      elevation: 3,
                      child: Scaffold(
                        body: Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 10, top: 10),
                              child: Text(
                                snapshot.data![position].name,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontFamily: 'Roboto'),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 10, top: 37),
                              child: Text(
                                snapshot.data![position].role,
                                style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16,
                                    fontFamily: 'Roboto'),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 10, top: 60),
                              child: Text(
                                specialize[int.parse(snapshot
                                            .data![position].specialize
                                            .toString()) -
                                        1]
                                    .toString(),
                                style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 14,
                                    fontFamily: 'Roboto'),
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 200, top: 45),
                              child: TextButton.icon(
                                style: TextButton.styleFrom(
                                  primary: Colors.lightBlue,
                                ),
                                onPressed: () async {
                                  tempName =
                                      snapshot.data![position].name.toString();
                                  tempEmail =
                                      snapshot.data![position].email.toString();
                                  tempPhone =
                                      snapshot.data![position].phone.toString();
                                  tempRoles =
                                      snapshot.data![position].role.toString();
                                  tempSpecialize = snapshot
                                      .data![position].specialize
                                      .toString();
                                  tempRoles =
                                      snapshot.data![position].role.toString();
                                  tempSpecialize = snapshot
                                      .data![position].specialize
                                      .toString();
                                  tempConferenceID =
                                      snapshot.data![position].id.toString();
                                  _showAction("editConference");
                                },
                                icon: const Icon(Icons.edit, size: 20),
                                label: const Text("Edit"),
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 280, top: 45),
                              child: TextButton.icon(
                                style: TextButton.styleFrom(
                                  primary: Colors.pink,
                                ),
                                onPressed: () async {
                                  await dbHelper.deleteConference(
                                      snapshot.data![position].id!);

                                  setState(() {});
                                  showDialog('Conferences details deleted !',
                                      'You have successfully deleted a conference details.');
                                },
                                icon: const Icon(Icons.delete, size: 20),
                                label: const Text("Delete"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        } else {
          return Center(
            child: Scaffold(
              body: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Stack(children: [
                      Container(
                        padding: const EdgeInsets.only(left: 10, top: 0),
                        child: Lottie.asset(
                          'assets/images/noconference.json',
                          height: 200,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 88, top: 200),
                        child: const Text(
                          "Oh, Snap!",
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 0, top: 220),
                        child: const Text(
                          "I can't find your conference registration :(",
                          style: TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  void doNothing(BuildContext context) {}

  void clearTextField() {
    rolesString = "";
    specializeString = "";
    nameController.clear();
    emailController.clear();
    phoneController.clear();
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

  Future<String> getspecializeID(int specializeID) async {
    String getID = await dbHelper.getSpecializeName(specializeID);
    return getID;
  }

  Future<int> addConference() async {
    String name = nameController.text;
    String email = emailController.text;
    int phone = int.parse(phoneController.text);
    String role = rolesString;
    int specialize = int.parse(specializeString);
    int user = int.parse(session.getUserID());
    Conference conference = Conference(
        name: name,
        email: email,
        phone: phone,
        role: role,
        specialize: specialize,
        user: user);
    return dbHelper.insertConference(conference);
  }

  Future<int> updateConference() async {
    String name = nameController.text;
    String email = emailController.text;
    int phone = int.parse(phoneController.text);
    String role = rolesString;
    int specialize = int.parse(specializeString);
    int user = int.parse(session.getUserID());
    int conferenceID = int.parse(tempConferenceID);
    Conference conference = Conference(
        id: conferenceID,
        name: name,
        email: email,
        phone: phone,
        role: role,
        specialize: specialize,
        user: user);
    return dbHelper.updateConference(conference);
  }
}
