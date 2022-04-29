// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:assignment_6/helpers/constants.dart';
import 'package:assignment_6/helpers/sql_helper.dart';
import 'package:assignment_6/helpers/validator.dart';
import 'package:assignment_6/model/user_model.dart';
import 'package:assignment_6/screens/all_data.dart';
import 'package:assignment_6/widget/my_button.dart';
import 'package:assignment_6/widget/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreens extends StatefulWidget {
  const LoginScreens({Key? key}) : super(key: key);

  @override
  State<LoginScreens> createState() => _LoginScreensState();
}

class _LoginScreensState extends State<LoginScreens> {
  final GlobalKey<FormState> _formFieldKey = GlobalKey();

  bool _isLoading = false;

  void _getAllUsers() async {
    final data = await SQLHelper.getItems();
    setState(() {
      UserModel.allUsers = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _getAllUsers();
  }

  Future<void> _addUser() async {
    await SQLHelper.createItem(
        UserModel.username.toString(), UserModel.password.toString());
    _getAllUsers();
  }

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Assignment_06")),
        backgroundColor: Colors.blueAccent,


      ),
      backgroundColor: Colors.black,
      body: ModalProgressHUD(
        color: Colors.black,
        inAsyncCall: _isLoading,
        progressIndicator: CircularProgressIndicator(color: Colors.white),
        child: Container(
          height: size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/andro6.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 120 / 3),
                  Text(
                    'SQLite App',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 45,
                    ),
                  ),
                  SizedBox(height: 390 / 3),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 105 / 3),
                    child: Form(
                      key: _formFieldKey,
                      child: Column(
                        children: [
                          MyTextInput(
                            icon: Icons.person,
                            hintText: 'Username',
                            controller: _usernameController,
                            validator: userNameValidator,
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(height: 45.6 / 3),
                          MyTextInput(
                            hintText: "Password",
                            icon: Icons.lock_rounded,
                            controller: _passwordController,
                            validator: passwordRequireValidator,
                            textInputAction: TextInputAction.done,
                          ),
                          SizedBox(height:110),
                          InkWell(
                            onTap: () async {
                              if (_formFieldKey.currentState!.validate()) {
                                setState(() {
                                  _isLoading = true;
                                  UserModel.username = _usernameController.text;
                                  UserModel.password = _passwordController.text;
                                });
                                await _addUser();
                                setState(() {
                                  _isLoading = false;
                                });
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AllData(),
                                  ),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: kSkyBlueShade,
                                    content: Text(
                                      'Successfully added a user',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                            child: MyButton(text: "Login"),
                          ),
                          SizedBox(height: 112.7 / 3),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AllData(),
                                ),
                              );
                            },
                            child: Container(
                              alignment: AlignmentDirectional.center,
                              height: 50,
                              width: size.width * 0.5,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: kSkyBlueShade,
                                  width: 2,
                                ),
                              ),
                              child: Text(
                                "Enter as a guest",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 74 / 3),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
