import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_dersleri/Personel/home_page.dart';
import 'package:flutter_firebase_dersleri/Personel/personel_login.dart';
import 'package:flutter_firebase_dersleri/services/admin_service.dart';
import 'package:flutter_firebase_dersleri/services/aut_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: App(),
    );
  }
}

class App extends StatefulWidget {
  // Create the initialization Future outside of `build`:
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  AuthService _authService = AuthService();
  AdminService _adminService = AdminService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Hata çıktı" + snapshot.error.toString()),
            ),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (_authService.auth.currentUser == null &&
                _adminService.auth.currentUser == null) {
              debugPrint("user null geldi");
              return buildAnimatedSplashScreen(SignInPage());
            } else if (_authService.auth.currentUser != null &&
                _adminService.auth.currentUser == null) {
              debugPrint("user null gelmedi");
              return buildAnimatedSplashScreen(HomePage());
            } else {
              return buildAnimatedSplashScreen(HomePage());
            }
          }
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  AnimatedSplashScreen buildAnimatedSplashScreen(Widget widget) {
    return AnimatedSplashScreen(
      splash: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          image: DecorationImage(
              image: AssetImage("assets/images/ayatek.jpg"), fit: BoxFit.cover),
        ),
      ),
      nextScreen: widget,
      backgroundColor: Colors.black,
    );
  }
}
/*
 if (snapshot.connectionState == ConnectionState.done) {
          if (_authService.auth.currentUser == null &&
              _adminService.auth.currentUser == null) {
            debugPrint("user null geldi");
            return buildAnimatedSplashScreen(SignInPage());
          } else if (_authService.auth.currentUser != null &&
              _adminService.auth.currentUser == null) {
            debugPrint("user null gelmedi");
            return buildAnimatedSplashScreen(HomePage());
          } else {
            return buildAnimatedSplashScreen(AdminPage());
          }
        }
 */
