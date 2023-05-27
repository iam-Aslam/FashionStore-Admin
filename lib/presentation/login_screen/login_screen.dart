import 'dart:developer';
import 'package:admin/presentation/home_screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/constants.dart';
import '../widgets/logo.dart';
import '../widgets/snackbar.dart';
import 'reset_password/reset_screen.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
bool passenable = true;
bool isLoading = false;

class _LogInState extends State<LogIn> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    if (isLoading == false) {
      return SafeArea(
          child: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(25.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Logo(),
                        khieght60,
                        Text(
                          'Hello Admin',
                          style: GoogleFonts.sahitya(
                            textStyle: const TextStyle(
                              letterSpacing: .5,
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        khieght10,
                        Text(
                          'Welcome to our fashion world',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              letterSpacing: .5,
                              fontSize: 14,
                              color: Colors.black45,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        khieght20,
                        khieght20,
                        TextFormField(
                          controller: emailController,
                          validator: (value) {
                            if (value!.isEmpty ||
                                !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                              return "Enter Valid Email";
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                          ),
                        ),
                        khieght10,
                        TextFormField(
                          controller: passwordController,
                          obscureText: passenable,
                          enableSuggestions: false,
                          autocorrect: false,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 6) {
                              return "Enter Valid Password";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              labelText: 'Password',
                              suffix: IconButton(
                                  onPressed: () {
                                    //add Icon button at end of TextField
                                    setState(() {
                                      //refresh UI
                                      if (passenable) {
                                        //if passenable == true, make it false
                                        passenable = false;
                                      } else {
                                        passenable =
                                            true; //if passenable == false, make it true
                                      }
                                    });
                                  },
                                  icon: Icon(passenable == true
                                      ? Icons.remove_red_eye
                                      : Icons.password))
                              //eye icon if passenable = true, else, Icon is ***__
                              ),
                        ),
                        khieght5,
                        Row(
                          children: [
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                log('Forgot Password');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ResetScreen(),
                                    ));
                              },
                              child: Text(
                                'Forgot Password?',
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    // letterSpacing: .5,
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        khieght20,
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 150.0, vertical: 15.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                isLoading = true;
                                log('validation success');
                                FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: emailController.text,
                                        password: passwordController.text)
                                    .then((value) {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                    builder: (context) {
                                      return const ScreenHome();
                                    },
                                  ));
                                }).onError((error, stackTrace) {
                                  alertSnackbar(
                                      context, 'Error: ${error.toString()}');
                                  log("Error ${error.toString()}");
                                });
                                isLoading = false;
                              }
                            },
                            child: Text(
                              'Login',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  letterSpacing: .5,
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            )),
                        khieght10,
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            Future.delayed(
              const Duration(milliseconds: 100),
              () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScreenHome(),
                ),
              ),
            );
          }
          return Container(
            color: Colors.white,
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            ),
          );
        },
      ));
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
