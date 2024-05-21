import 'package:flutter/material.dart';
import '../global/app_colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();
  bool _obscurepassword = true;
  bool _obscurerepeatpassword = true;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;


    return Scaffold(

        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(top: 23.0),
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                // Handle back button press
                Navigator.pop(context);
              },
            ),
          ),
          title: const Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: Text(
              'Registration',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

        ),

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(left: 25.0, top:25.0),
              child: Text(
                "Create a free",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 25.0, top:5.0),
              child: Text(
                "account",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 3.0, bottom: 2.0),
                    child: Text(
                      "Email",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                          color: Colors.black12,
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                          color: Colors.black12,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.only(left: 3.0, bottom: 2.0),
                    child: Text(
                      "Password",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  TextField(
                    controller: passwordController,
                   // obscureText: _obscureText,
                    decoration:  InputDecoration(
                      hintText: 'Enter your password',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                          color: Colors.black12,
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                          color: Colors.black54,
                          width: 2.0,
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurepassword   ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                         color: Colors.black54,
                        ),
                        onPressed: () {
                          setState(() {
                           _obscurepassword = !_obscurepassword;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.only(left: 3.0, bottom: 2.0),
                    child: Text(
                      "Repeat Password",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  TextField(
                    controller: repeatPasswordController,
                    obscureText: _obscurerepeatpassword,
                    decoration: InputDecoration(
                      hintText: 'Enter your password again',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                          color: Colors.black12,
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                          color: Colors.black54,
                          width: 2.0,
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurerepeatpassword ?
                          Icons.visibility_off_outlined : Icons.visibility_outlined,
                           color: Colors.black54,
                        ),
                        onPressed: () {
                          setState(() {
                           _obscurerepeatpassword = ! _obscurerepeatpassword;
                          });
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 30.0),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                      fixedSize: MaterialStateProperty.all<Size>(Size(screenWidth, 50)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const Center(child: Text("Or")),
                  const SizedBox(height: 20.0),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.transparentColor,
                      border: Border.all(color: Colors.white12),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Image.asset(
                            "assets/images/google.png",
                            width: 18,
                            height: 18,
                          ),
                        ),
                        const SizedBox(width: 75),
                        const Text(
                          "Continue with Google",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.transparentColor,
                      border: Border.all(color: Colors.white12),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Image.asset(
                            "assets/images/mac.png",
                            width: 18,
                            height: 18,
                          ),
                        ),
                        const SizedBox(width: 75),
                        const Text(
                          "Continue with Apple",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?"),
                      Text(
                        "Sign in",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
