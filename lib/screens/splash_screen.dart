import 'package:flutter/material.dart';

import '../routes/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    navigatetosigin();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Container(
            width: 120,
            height: 120,
            color: Colors.black,
            child: Stack(
              children: [
                Positioned(
                  bottom: -15,
                  left: -12,
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 100,
                    height: 100,
                    color: Colors.white,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }

  void navigatetosigin() async{
    await Future.delayed(Duration(seconds: 3));
   // Routes().navigateToSignInScreen(context);
    Routes().navigateToHomeScreen(context);
  }
}

