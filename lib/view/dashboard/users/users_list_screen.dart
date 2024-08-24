import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:tiers_final_project/res/color.dart';
import 'package:tiers_final_project/view/dashboard/chat/message_screen.dart';
import 'package:tiers_final_project/view_model/services/session_manager.dart';

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({super.key});

  @override
  State<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  DatabaseReference ref = FirebaseDatabase.instance.ref('Users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users List'),
      ),
      body: FirebaseAnimatedList(
        query: ref,
        itemBuilder: ((context, snapshot, animation, index) {
          if (SessionController().userId.toString() ==
              snapshot.child('uid').value.toString()) {
            return Container();
          } else {
            return Card(
              color: Color.fromARGB(255, 247, 247, 247),
              child: InkWell(
                onTap: () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: MessageScreen(
                      image: snapshot.child('profile').value.toString(),
                      name: snapshot.child('username').value.toString(),
                      email: snapshot.child('email').value.toString(),
                      recieverId: snapshot.child('uid').value.toString(),
                    ),
                  );
                },
                child: ListTile(
                  leading: Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: snapshot.child('profile').value.toString() == ''
                        ? const Icon(Icons.person)
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image(
                                fit: BoxFit.cover,
                                image: NetworkImage(snapshot
                                    .child('profile')
                                    .value
                                    .toString())),
                          ),
                  ),
                  title: Text(snapshot.child('username').value.toString()),
                  subtitle: Text(snapshot.child('email').value.toString()),
                ),
              ),
            );
          }
        }),
      ),
    );
  }
}
