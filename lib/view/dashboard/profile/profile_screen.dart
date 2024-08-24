import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiers_final_project/res/color.dart';
import 'package:tiers_final_project/res/components/round_button.dart';
import 'package:tiers_final_project/utils/routes/route_name.dart';
import 'package:tiers_final_project/view_model/controller/profile_controller.dart';
import 'package:tiers_final_project/view_model/services/session_manager.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ref = FirebaseDatabase.instance.ref('Users');
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileController(),
      child: Consumer<ProfileController>(builder: (context, provider, child) {
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: StreamBuilder(
                stream:
                    ref.child(SessionController().userId.toString()).onValue,
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData) {
                    Map<dynamic, dynamic> map = snapshot.data.snapshot.value;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Center(
                                child: Container(
                                  height: 130,
                                  width: 130,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: AppColors.secondaryTextColor),
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: provider.image == null
                                          ? map['profile'].toString() == ''
                                              ? const Icon(
                                                  Icons.person,
                                                  size: 60,
                                                )
                                              : Image(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      map['profile']
                                                          .toString()),
                                                  loadingBuilder: (context,
                                                      child, loadingProgress) {
                                                    if (loadingProgress ==
                                                        null) {
                                                      return child;
                                                    }
                                                    return const Center(
                                                        child:
                                                            CircularProgressIndicator());
                                                  },
                                                  errorBuilder: (context, error,
                                                      errorTrace) {
                                                    return const SizedBox(
                                                      child: Icon(
                                                        Icons.error_outline,
                                                        color: Colors.red,
                                                      ),
                                                    );
                                                  })
                                          : Stack(children: [
                                              Image.file(
                                                  File(provider.image!.path)
                                                      .absolute),
                                              const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            ])),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                provider.pickImage(context);
                              },
                              child: const CircleAvatar(
                                  radius: 15,
                                  backgroundColor: AppColors.primaryIconColor,
                                  child: Icon(
                                    Icons.edit,
                                    color: AppColors.whiteColor,
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        GestureDetector(
                          onTap: () {
                            provider.showUserNameDialogAlert(
                                context, map['username']);
                          },
                          child: ReusableRow(
                            title: 'Username',
                            value: map['username'],
                            iconData: Icons.person,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            provider.showPhoneDialogAlert(
                                context, map['phone']);
                          },
                          child: ReusableRow(
                            title: 'Phone Number',
                            value: map['phone'] == ''
                                ? 'xxx-xxx-xxxx'
                                : map['phone'],
                            iconData: Icons.phone,
                          ),
                        ),
                        ReusableRow(
                          title: 'Email',
                          value: map['email'],
                          iconData: Icons.email_outlined,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        RoundButton(title: 'LOGOUT', onPress: () {}),
                      ],
                    );
                  } else {
                    return Center(
                      child: Text(
                        'Something went wrong',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        );
      }),
    );
  }
}

class ReusableRow extends StatelessWidget {
  final String title, value;
  final IconData iconData;
  const ReusableRow(
      {super.key,
      required this.title,
      required this.value,
      required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          horizontalTitleGap: 5,
          leading: Icon(
            iconData,
            color: AppColors.primaryIconColor,
          ),
          title: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          trailing: Text(
            value,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        Divider(
          color: AppColors.dividedColor.withOpacity(0.5),
        ),
      ],
    );
  }
}
