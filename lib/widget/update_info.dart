// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:assignment_6/helpers/constants.dart';
import 'package:assignment_6/helpers/sql_helper.dart';
import 'package:assignment_6/helpers/validator.dart';
import 'package:assignment_6/model/user_model.dart';
import 'package:flutter/material.dart';

class UpdateInfoBottomSheet extends StatefulWidget {
  const UpdateInfoBottomSheet({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  State<UpdateInfoBottomSheet> createState() => _UpdateInfoBottomSheetState();
}

class _UpdateInfoBottomSheetState extends State<UpdateInfoBottomSheet> {
  final GlobalKey<FormState> _formFieldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    String updatedUsername = '', updatedPassword = '';

    void _getAllUsers() async {
      final data = await SQLHelper.getItems();
      setState(() {
        UserModel.allUsers = data;
      });
    }

    Future<void> _updateUser(int id) async {
      await SQLHelper.updateItem(
          id, UserModel.username.toString(), UserModel.password.toString());
      _getAllUsers();
    }

    return Container(
      color: Colors.black.withOpacity(0.8),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formFieldKey,
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Username",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextFormField(
                      onChanged: (value) {
                        updatedUsername = value;
                      },
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      initialValue: UserModel.allUsers[widget.index]
                          ["username"],
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      cursorHeight: 20,
                      cursorColor: Colors.white,
                      autofocus: true,
                      textAlign: TextAlign.left,
                      decoration: kInputDecoration,
                      validator: userNameValidator,
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Password",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextFormField(
                      onChanged: (value) {
                        updatedPassword = value;
                      },
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.name,
                      initialValue: UserModel.allUsers[widget.index]
                          ["password"],
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      cursorHeight: 20,
                      cursorColor: Colors.white,
                      autofocus: true,
                      textAlign: TextAlign.left,
                      decoration: kInputDecoration,
                      validator: passwordRequireValidator,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: Colors.grey, fontSize: 18),
                          ),
                        ),
                        SizedBox(width: 45),
                        InkWell(
                          onTap: () async {
                            if (_formFieldKey.currentState!.validate()) {
                              setState(() {
                                if (updatedUsername != "") {
                                  UserModel.username = updatedUsername;
                                }
                                if (updatedPassword != "") {
                                  UserModel.password = updatedPassword;
                                }
                              });
                              Navigator.pop(context);

                              _updateUser(
                                  UserModel.allUsers[widget.index]["id"]);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: kPinkShade,
                                  content: Text(
                                    'User details updated',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                          child: Text(
                            'Save',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
