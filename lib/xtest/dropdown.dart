import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:dialogs/dialogs.dart';

void main() => runApp(const MyApp2());

class MyApp2 extends StatelessWidget {
  const MyApp2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Slidable Example',
      home: Scaffold(
        body: ListView(
          children: [
            Slidable(
              // Specify a key if the Slidable is dismissible.
              key: const ValueKey(0),

              // The start action pane is the one at the left or the top side.
              startActionPane: ActionPane(
                // A motion is a widget used to control how the pane animates.
                motion: const ScrollMotion(),

                // A pane can dismiss the Slidable.
                dismissible: DismissiblePane(onDismissed: () {}),

                // All actions are defined in the children parameter.
                children: const [
                  // A SlidableAction can have an icon and/or a label.
                  SlidableAction(
                    onPressed: doNothing,
                    backgroundColor: Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                ],
              ),

              // The end action pane is the one at the right or the bottom side.
              endActionPane: const ActionPane(
                motion: ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: doNothing,
                    backgroundColor: Color(0xFF0392CF),
                    foregroundColor: Colors.white,
                    icon: Icons.edit,
                    label: 'Edit',
                  ),
                ],
              ),

              // The child of the Slidable is what the user sees when the
              // component is not dragged.
              child: Container(
                margin: EdgeInsets.all(4),
                height: 100,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Colors.black26, width: 1),
                  ),
                  elevation: 3,
                  child: Container(
                    child: Scaffold(
                      body: Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 10, top: 10),
                            child: const Text(
                              "Name",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontFamily: 'Roboto'),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 10, top: 37),
                            child: const Text(
                              "Role",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                  fontFamily: 'Roboto'),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 10, top: 60),
                            child: const Text(
                              "Specialization",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                  fontFamily: 'Roboto'),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 200, top: 45),
                            child: TextButton.icon(
                              style: TextButton.styleFrom(
                                primary: Colors.lightBlue,
                              ),
                              onPressed: () {
                                // Respond to button press
                              },
                              icon: Icon(Icons.edit, size: 20),
                              label: Text("Edit"),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 280, top: 45),
                            child: TextButton.icon(
                              style: TextButton.styleFrom(
                                primary: Colors.pink,
                              ),
                              onPressed: () {
                                final choice = ChoiceDialog(
                                  dialogBackgroundColor: Colors.white,
                                  title: 'Delete confirmation',
                                  titleColor: Colors.pink,
                                  message: 'Are you sure to delete ?',
                                  iconButtonCancel: Icon(Icons.cancel),
                                  iconButtonOk: Icon(Icons.check),
                                  buttonOkOnPressed: () {
                                    //DELETE STATEMENT HERE
                                  },
                                );

                                choice.show(
                                  context,
                                  barrierColor: Colors.black,
                                  barrierDismissible: true,
                                );
                              },
                              icon: Icon(Icons.delete, size: 20),
                              label: Text("Delete"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}

void doNothing(BuildContext context) {}
