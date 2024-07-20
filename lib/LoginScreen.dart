// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, avoid_print, unused_element, use_build_context_synchronously, unnecessary_cast, unused_import, no_leading_underscores_for_local_identifiers, file_names
import 'package:devsoc_core_review_project/register.dart';
import 'package:devsoc_core_review_project/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5), // Soft grey background,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Login',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 32),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: 'Password',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  // sign up logic
                  createUser(emailController.text, passwordController.text);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Text('Sign Up'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  //sign in logic
                  bool loginSuccessful = await signIn(
                      context, emailController.text, passwordController.text);
                  if (loginSuccessful) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchScreen()));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Invalid email or password. Please try again.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: Text('Sign In'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  // Your login with email logic here
                  bool loginSuccessful = await signIn(
                      context, emailController.text, passwordController.text);
                  if (loginSuccessful) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchScreen()));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Invalid email or password. Please try again.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: Text('Login with Email'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
