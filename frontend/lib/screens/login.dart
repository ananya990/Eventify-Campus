import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  // Sign in with Google method
  Future<void> signInWithGoogle() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      setState(() {
        _isLoading = false;
      });

      if (googleUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Google Sign-In canceled")),
        );
        return;
      }

      Navigator.pushReplacementNamed(context, 'home');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Signed in as ${googleUser.displayName}")),
      );
    } catch (error) {
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Google Sign-In failed: $error")),
      );
    }
  }

  // Login user with email and password
  void _loginUser() async {
    if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });

      final response = await http.post(
        Uri.parse('http://localhost:3000/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': _emailController.text,
          'password': _passwordController.text,
        }),
      );

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200) {
        Navigator.pushReplacementNamed(context, 'home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login failed")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter email and password")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/login.jpg'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(),
            if (_isLoading)
              Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            if (!_isLoading)
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.5),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 35),
                        child: Column(
                          children: [
                            TextField(
                              controller: _emailController,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Email",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            TextField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Password",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            SizedBox(height: 40),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Sign in',
                                  style: TextStyle(
                                      fontSize: 27,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                ),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Color(0xff4c505b),
                                  child: IconButton(
                                    color: Colors.white,
                                    onPressed: _loginUser,
                                    icon: Icon(Icons.arrow_forward),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 20),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              onPressed: signInWithGoogle,
                              icon: Image.asset('assets/googlelogo.jpg', height: 24),
                              label: Text("Sign in with Google",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16)),
                            ),
                            SizedBox(height: 20),
                            Row(
  mainAxisAlignment: MainAxisAlignment.center, // Center the text
  children: [
    TextButton(
      onPressed: () {
        Navigator.pushNamed(context, 'register');
      },
      child: Text(
        'Sign Up',
        style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.white,
            fontSize: 18),
      ),
    ),
  ],
)

                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
