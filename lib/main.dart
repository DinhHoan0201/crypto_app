import 'package:crypto_app/providers/selected_coin_provider.dart';
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
  await Notificationservice().initNotifications();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CoinProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => SelectedCoinProvider()),
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
    final navigatorKey = GlobalKey<NavigatorState>();
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: themeProvider.themeData,
      home: const MainScreen(),
    );
  }
}
