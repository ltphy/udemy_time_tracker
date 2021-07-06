import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:udemy_timer_tracker/common_widgets/custom_progress_indicator.dart';
import 'package:udemy_timer_tracker/pages/landing_page/landing_page.dart';
import 'package:udemy_timer_tracker/services/sign_in_services.dart';

void main() {
  //set up widget binding flutter.
  // ensure initialized
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // The future is apart of the state of our widget. We should not call `initialize directly in build'

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    // use FutureBuilder so that when rebuild it wont initialize again.
    return FutureBuilder(
      future: _initialization,
      builder: (BuildContext context, AsyncSnapshot<FirebaseApp> snapshot) {
        if (snapshot.hasError) {
          return Container(child: Text('Something went wrong'));
        }
        // dont connection state
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Time Tracker',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: LandingPage(
              auth: Auth(),
            ),
          );
        }
        return CustomProgressIndicator();
      },
    );
  }
}