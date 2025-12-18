import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'service/auth_providers.dart';
import 'providers/auth_provider.dart';
import 'providers/chat_provider.dart';
import 'screens/auth/google_login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GooglesAuthProvider()),     // Google
        ChangeNotifierProvider(create: (_) => AuthProviders()),   // 🔥 API
        ChangeNotifierProvider(create: (_) => ChatProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Group Chat',
        theme: ThemeData(useMaterial3: true),
        home: const GoogleLoginScreen(),
      ),
    );
  }
}
