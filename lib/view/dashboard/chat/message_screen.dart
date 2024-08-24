import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tiers_final_project/res/color.dart';
import 'package:tiers_final_project/utils/utils.dart';
import 'package:tiers_final_project/view_model/services/session_manager.dart';

class MessageScreen extends StatefulWidget {
  String name, image, email, recieverId;
  MessageScreen(
      {super.key,
      required this.image,
      required this.name,
      required this.email,
      required this.recieverId});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('Chats');
  final messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: null,
      appBar: AppBar(
        title: Text(widget.name.toString()),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    return Text(index.toString());
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      cursorColor: AppColors.cursorColor,
                      controller: messageController,
                      keyboardType: TextInputType.text,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(height: 0, fontSize: 19),
                      decoration: InputDecoration(
                        suffixIcon: InkWell(
                          onTap: () {
                            sendMessage();
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: CircleAvatar(
                                backgroundColor: AppColors.primaryIconColor,
                                child: Icon(
                                  Icons.send,
                                  color: AppColors.whiteColor,
                                )),
                          ),
                        ),
                        hintText: 'Enter Message',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(height: 1, color: AppColors.hintColor),
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: AppColors.textFieldDefaultBorderColor,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: AppColors.textFieldFocusBorderColor,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: AppColors.textFieldDefaultFocus,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: AppColors.alertColor,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  sendMessage() {
    if (messageController.text.isEmpty) {
      Utils.toastMessage('Please enter a message');
    } else {
      final timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
      ref.child(timeStamp).set({
        'isSeen': false,
        'message': messageController.text.toString(),
        'sender': SessionController().userId.toString(),
        'reciever': widget.recieverId,
        'type': 'text',
        'timeStamp': timeStamp.toString(),
      }).then((value) {
        messageController.clear();
      });
    }
  }
}
