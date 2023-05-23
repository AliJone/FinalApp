import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:finals/constants.dart';

class Profiling extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: CustomColors.backgroundColor,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 30),
              Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RotatedBox(
                      quarterTurns: -1,
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      alignment: Alignment.topLeft,
                      width: 150,
                      height: 80,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "A world of possibility in an app",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ]),
                    )
                  ],
                ),
              ),
              Container(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 40),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.black,
                            )),
                            fillColor: Colors.black,
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.black),
                            suffixIcon: Icon(Icons.email),
                            suffixIconColor: Colors.black,
                            focusColor: Colors.black,
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.black,
                            ))),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.black,
                            )),
                            fillColor: Colors.black,
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Colors.black),
                            suffixIcon: Icon(Icons.password),
                            suffixIconColor: Colors.black,
                            focusColor: Colors.black,
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.black,
                            ))),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.bottomRight,
                height: (MediaQuery.of(context).size.height / 3) + 50,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      final User? user =
                          (await _auth.signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      ))
                              .user;
                      if (!user!.emailVerified) {
                        await user.sendEmailVerification();
                      }
                      // Navigate to /data page
                      Navigator.pushNamed(context, '/crud');
                    } on FirebaseAuthException catch (e) {
                      print('Failed with error code: ${e.code}');
                      print(e.message);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                  child: Ink(
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: CustomColors.backgroundColor),
                        borderRadius: BorderRadius.circular(50)),
                    child: Container(
                      width: 150,
                      height: 50,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Spacer(),
                          const Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 15, fontStyle: FontStyle.italic),
                          ),
                          Icon(Icons.arrow_forward_outlined),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
