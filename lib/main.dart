import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/views.dart/login.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
    runApp(
       MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EDULEGAL',
      home: Homepage(),
    )
    );
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('home page')),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot)
        {
          switch(snapshot.connectionState){
            case ConnectionState.done:
            final user= FirebaseAuth.instance.currentUser;
            if(user?.emailVerified??false){
              print('Verified user');
            }
            else
            print('maybe impersonating someone');
            return const Text('Done');
            default:
            return const Text('Loading');
          }
        }
      ),
    );
  }
}