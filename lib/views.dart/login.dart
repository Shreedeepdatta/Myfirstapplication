import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'signup.dart';
import 'package:flutter_application_2/firebase_options.dart';
class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Login Page',
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      backgroundColor: const Color.fromARGB(255, 51, 50, 50),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(padding: EdgeInsets.only(top: 70.0),
              child: Text(
                'Log In',
                style: TextStyle(
                  fontSize: 34.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                  ),
                  ),

                  SizedBox(height: 60.0),
             SizedBox(
              width: 400.0,
              child: TextField(
                enableSuggestions: true,
                style: TextStyle(color: Colors.white),
                controller: _usernameController,
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
            SizedBox(height: 20.0),
            SizedBox(
              width: 400.0,
              child: TextField(
                enableSuggestions: false,
                style: TextStyle(color: Colors.white),
              controller: _passwordController,
              obscureText: _isPasswordVisible,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100.0),
                  borderSide: BorderSide(
                  color: Color.fromARGB(255, 242, 92, 81), // Set the border color
                  width: 2.0, // Set the border width
                  ),
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 242, 92, 81).withOpacity(1)),
                  borderRadius: BorderRadius.circular(100.0) // Set the border color to red with opacity
                ),
              prefixIcon: Icon(Icons.lock, color: Colors.white),
              labelText: 'Password',
              labelStyle: TextStyle(color: Colors.white),
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
            SizedBox(height: 20.0), // Added spacing
            TextButton(
              onPressed: () {
                // Add your forgot password logic here
                // For simplicity, let's just print a message for now
                print('Forgot Password clicked');
              },
              child: Text(
                'Forgot Password?',
                style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            SizedBox(height: 20.0),
             Container(padding: EdgeInsets.only(left: 10.0), 
             child: ElevatedButton(
              onPressed: () async{
                  try {
                          await Firebase.initializeApp(
                            options: DefaultFirebaseOptions.currentPlatform                          
                            );
                          final String email=_usernameController.text;
                          final String password=_passwordController.text;
                          final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: email,
                          password: password,
                          );
                          print('User logged in: ${userCredential.user!.email}');
                      } 
                      on FirebaseAuthException catch (e) {
                        if(e.code=='wrong-password')
                        {
                          print("wrong password mate");
                        }
                      print(e.code);
                      }
              },
              child:Text('Login',
              style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(200, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                backgroundColor: Color.fromRGBO(80, 79, 97, 0.5)
              ),
            ),
            ),
            SizedBox(height: 10.0),
            Row(children: [
              Text('New to our page?',
              style: TextStyle(color: Colors.white),),
              TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupPage()),
                );
              },
              child: Text('Sign Up',
              style: TextStyle(color: Color.fromARGB(255, 242, 92, 81)
              ),),
            ),],)
          ],
        ),
      ),
    );
  }
}
