import 'dart:developer';
import 'package:dog_app/Database/Database.dart';
import 'package:dog_app/Database/SessionTable.dart';
import 'package:dog_app/Database/UsersTable.dart';
import 'package:dog_app/Widgets/InputTextWidget.dart';
import 'package:dog_app/Screens/MyHomepage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({
    Key? key,
    this.newsignUpModel,
  }) : super(key: key);

  final UsersModel? newsignUpModel;

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final _databaseProviderr = Databaseprovider.instance;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            )),
        elevation: 0.0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
            ),
            width: screenWidth,
            height: screenHeight,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    InputTextWidget(
                        controller: _namecontroller,
                        labelText: "Name",
                        icon: Icons.person,
                        obscureText: false,
                        keyboardType: TextInputType.text),
                    SizedBox(
                      height: 16.0,
                    ),
                    InputTextWidget(
                        controller: _emailController,
                        labelText: "Enter Email",
                        icon: Icons.email,
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress),
                    SizedBox(
                      height: 16.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Container(
                        child: Material(
                          elevation: 1.0,
                          shadowColor: Colors.black,
                          borderRadius: BorderRadius.circular(15.0),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(right: 20.0, left: 15.0),
                            child: TextFormField(
                                obscureText: true,
                                textInputAction: TextInputAction.next,
                                autofocus: false,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.lock,
                                    color: Colors.black,
                                    size: 24.0,
                                  ),
                                  labelText: "Enter password",
                                  labelStyle: TextStyle(
                                      color: Colors.black54, fontSize: 14.0),
                                  hintText: '',
                                  enabledBorder: InputBorder.none,
                                  border: InputBorder.none,
                                ),
                                controller: _pass,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'type a password';
                                  } else if (val.length < 6) {
                                    return 'password must be > 6 characters';
                                  }

                                  return null;
                                }),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Container(
                        child: Material(
                          elevation: 1.0,
                          shadowColor: Colors.black,
                          borderRadius: BorderRadius.circular(15.0),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(right: 20.0, left: 15.0),
                            child: TextFormField(
                                obscureText: true,
                                textInputAction: TextInputAction.done,
                                autofocus: false,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.lock,
                                    color: Colors.black,
                                    size: 24.0,
                                  ),
                                  labelText: "Confirm Password",
                                  labelStyle: TextStyle(
                                      color: Colors.black54, fontSize: 14.0),
                                  hintText: '',
                                  enabledBorder: InputBorder.none,
                                  border: InputBorder.none,
                                ),
                                controller: _confirmPass,
                                validator: (val) {
                                  if (val!.isEmpty) return 'confirm Password!!';
                                  if (val != _pass.text)
                                    return 'Incorrect Password';
                                  return null;
                                }),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 8),
                      child: Container(
                        height: 50.0,
                        child: ElevatedButton(
                          clipBehavior: Clip.antiAlias,
                          onPressed: () async {
                            final FormState? formm = _formKey.currentState;
                            if (formm!.validate()) {
                              var userEmail = _emailController.text.toString();

                              final newexpensess = UsersModel(
                                userEmail: userEmail,
                                userPassword: _pass.text.toString(),
                                confirmPassword: _confirmPass.text.toString(),
                                userName: _namecontroller.text.toString(),
                              );

                              final autoExpensess = SessionModel(
                                userEmail: userEmail,
                                userPassword: _pass.text.toString(),
                                confirmPassword: _confirmPass.text.toString(),
                                userName: _namecontroller.text.toString(),
                              );

                              var existingUser = await _databaseProviderr
                                  .getUserByEmail(userEmail);
                              log('existingUser: $existingUser');
                              if (existingUser != Null) {
                                Fluttertoast.showToast(
                                    msg:
                                        "'$userEmail' is already taken. Please try another email.",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.blue,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                return;
                              }
                              await _databaseProviderr
                                  .addSignUpdetail(newexpensess);
                              await _databaseProviderr
                                  .addSessionDetails(autoExpensess);

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MyHomePage(title: 'Dogs_Diary'),
                                ),
                              );
                            }
                          },
                          child: Ink(
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                "Continue",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
