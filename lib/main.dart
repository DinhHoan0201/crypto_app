import 'package:flutter/material.dart';
import 'package:crypto_app/screen/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:crypto_app/service/fetch_API.dart';
import 'package:crypto_app/themes/myTheme_Provider.dart';
import 'package:crypto_app/service/notification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Notificationservice().initNotifications();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CoinProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
  //await FirebaseAuth.instance.signOut();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeProvider.themeData,
      home: const MainScreen(),
    );
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,

    //   //theme: FlexThemeData.light(scheme: FlexScheme.mandyRed),
    //   // theme: ThemeData(
    //   //   scaffoldBackgroundColor: Colors.white,
    //   //   primaryColor: Colors.blueGrey,
    //   //   textTheme: GoogleFonts.poppinsTextTheme(
    //   //     Theme.of(context).textTheme.apply(
    //   //       bodyColor: Colors.black,
    //   //       displayColor: Colors.black,
    //   //     ),
    //   //   ),
    //   // ),
    //   home: const MainScreen(),
    // );
  }
}
