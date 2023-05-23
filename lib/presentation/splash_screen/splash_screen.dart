import 'package:admin/presentation/login_screen/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(milliseconds: 1500),
      () => Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LogIn())),
    );
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                height: 100,
                child: Image.asset("assets/images/logo.png"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
