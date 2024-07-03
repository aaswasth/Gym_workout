import 'package:capstone_project/components/button.dart';
import 'package:capstone_project/components/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

// sign in user
  void signIn() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailTextController.text,
          password: passwordTextController.text);
      if (mounted) {
        Navigator.pop(
            context); // Dismiss loading indicator after successful sign-in
      }
    } on FirebaseAuthException catch (e) {
      // pop loading circle
      Navigator.pop(context);
      //display error message
      displayMessage("Please check the credentials");
    }
  }

// display a message
  void displayMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/indx.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 80),
                  // logo
                  // const Icon(
                  //   Icons.lock,
                  //   size: 80,
                  //   color: Colors.white,
                  // ),
                  // SizedBox(height: 10),
                  const Text(
                    'ACHIEVABLE',
                    style: TextStyle(color: Colors.blueGrey, fontSize: 50),
                  ),
                  // const SizedBox(height: 10),

                  // welcome back message
                  // const Text(
                  //   'Welcome back',
                  //   style: TextStyle(color: Colors.white54),
                  // ),
                  const SizedBox(height: 80),

                  // email TextField
                  MyTextField(
                    controller: emailTextController,
                    hintText: 'Email',
                    obscureText: false,
                  ),
                  const SizedBox(height: 10),

                  // PasswordField
                  MyTextField(
                    controller: passwordTextController,
                    hintText: 'Password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 10),

                  // sign in Button
                  MyButton(onTap: signIn, text: 'Sign in'),

                  const SizedBox(height: 10),

                  // signup page
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Not a member?  ',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          'Register now',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[700],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
