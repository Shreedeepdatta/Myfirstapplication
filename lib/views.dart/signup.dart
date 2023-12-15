import 'dart:html';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_2/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late final TextEditingController nameController; 
  late final TextEditingController emailController; 
  late final TextEditingController passwordController;
  late final TextEditingController usernameController;
  bool _isPasswordVisible = false;
  @override
  void initState(){
    nameController=TextEditingController();
    emailController=TextEditingController();
    passwordController=TextEditingController();
    usernameController=TextEditingController();
    super.initState();
  }
  
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      backgroundColor: const Color.fromARGB(255, 51, 50, 50), // Change the background color for the signup page
      body: Center(child: 
      Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 400.0,
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: nameController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.white),
                  labelText: 'Full Name',
                  focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100.0),
                  borderSide: BorderSide(
                    color: const Color.fromARGB(255, 242, 92, 81),
                  width: 2.0, // Set the border width
                  ),   
              ),
               enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 242, 92, 81).withOpacity(1)),
                  borderRadius: BorderRadius.circular(100.0) // Set the border color to red with opacity
                ),
                ),
              ),
            ),
            SizedBox(height: 10),
           SizedBox(
              width: 400.0,
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: emailController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.white),
                  labelText: 'Email',
                  focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100.0),
                  borderSide: BorderSide(
                    color: const Color.fromARGB(255, 242, 92, 81),
                  width: 2.0, // Set the border width
                  ),   
              ),
               enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 242, 92, 81).withOpacity(1)),
                  borderRadius: BorderRadius.circular(100.0) // Set the border color to red with opacity
                ),
              prefixIcon: Icon(Icons.person, color: Colors.white,),
                  
                  ),
              ),
            ),
            SizedBox(height: 10),
           SizedBox(
              width: 400.0,
              child: TextField(
                enableSuggestions: true,
                autocorrect: false,
                style: TextStyle(color: Colors.white),
                controller: usernameController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.white),
                  labelText: 'Username',
                  focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100.0),
                  borderSide: BorderSide(
                    color: const Color.fromARGB(255, 242, 92, 81),
                  width: 2.0, // Set the border width
                  ),   
              ),
               enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 242, 92, 81).withOpacity(1)),
                  borderRadius: BorderRadius.circular(100.0) // Set the border color to red with opacity
                ),
              prefixIcon: Icon(Icons.person, color: Colors.white,),
                  
                  ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 400.0,
              child: TextField(
                enableSuggestions: false,
                autocorrect: false,
                style: TextStyle(color: Colors.white),
                controller: passwordController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.white),
                  labelText: 'password',
                  focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100.0),
                  borderSide: BorderSide(
                    color: const Color.fromARGB(255, 242, 92, 81),
                  width: 2.0, // Set the border width
                  ),   
              ),
               enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 242, 92, 81).withOpacity(1)),
                  borderRadius: BorderRadius.circular(100.0) // Set the border color to red with opacity
                ),
              prefixIcon: Icon(Icons.lock, color: Colors.white,),
                  suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible?Icons.visibility:
                  Icons.visibility_off,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible=!_isPasswordVisible;
                  });
                },
                ),
                  ),
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: ElevatedButton(
                onPressed: () async{
                  await Firebase.initializeApp(
                    options: DefaultFirebaseOptions.web,
                  );
                  // Add your signup logic here
                  final String Name = nameController.text;
                  final String email=emailController.text;
                  final String username = usernameController.text;
                  final String password = passwordController.text;
                  // ignore: unused_local_variable
                  try{
                    final userCredential= 
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: email, 
                    password: password);
                    }
                    on FirebaseAuthException catch(e){
                      if(e.code=='weak-password'){
                        print('password so weak your boomer mom will crack it');
                      }
                      else if(e.code=='email-already-in-use'){
                        print('You have alzheimers you dipshit you already registered with this email');
                      }
                      else{
                        print(e.code);
                      }
                    }
                  // Navigate back to the login page
                  Navigator.pop(context);
                },
                child: Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 20.0),
                ),
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(200.0, 50.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            TextButton(
              onPressed: () {
                
                Navigator.pop(context); // Navigate back to the login page
              },
              child: Text('Back to Login'),
            ),
          ],
        ),
      ),
    ),);
  }
}