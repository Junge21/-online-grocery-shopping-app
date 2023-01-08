import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socion/provider/auth_service.dart';
import 'package:socion/screens/home_screen.dart';
import 'package:socion/screens/login.dart';
import 'package:socion/screens/signup.dart';
import 'package:socion/screens/splash_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Socion());
}

class Socion extends StatelessWidget {
  const Socion({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
         ChangeNotifierProvider(create: (context)=>AuthService()),
      ],
      builder: ((context, child)=> MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Isaatech Ecommerce',
        theme: ThemeData(
          fontFamily: 'Gilroy',
          primarySwatch: Colors.blue,
          appBarTheme:
              const AppBarTheme(elevation: 0, backgroundColor: Colors.white),
          colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Color(0xFF999CF4),
            primaryVariant: Color(0xFF6569C0),
            secondary: Color(0xFFEFC3FE),
            secondaryVariant: Color(0xFF9F83BE),
            onPrimary: Colors.white,
            surface: Colors.white,
            onSecondary: Colors.white,
            onSurface: Colors.black87,
            background: Colors.white,
            error: Colors.red,
            onBackground: Colors.black87,
            onError: Colors.white,
          ),
        ),
        routes: {
          SplashScreen.id: (context) => const SplashScreen(),
          LoginScreen.id: (context) => const LoginScreen(),
          SignUpScreen.id: (context) => const SignUpScreen(),
          HomeScreen.id: (context) => const HomeScreen()
        },
      )
      ),
    );
  }
}
