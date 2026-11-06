import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'providers/api_provider.dart';
import 'providers/auth_provider.dart';
import 'providers/transaction_provider.dart';
import 'screens/auth_gate.dart';
import 'services/api_service.dart';
import 'services/auth_service.dart';
import 'services/firestore_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(AuthService()),
        ),
        ChangeNotifierProvider(
          create: (_) => TransactionProvider(FirestoreService()),
        ),
        ChangeNotifierProvider(
          create: (_) => ApiProvider(ApiService()),
        ),
      ],
      child: const KasKecilApp(),
    ),
  );
}

class KasKecilApp extends StatelessWidget {
  const KasKecilApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kas Kecil',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF176B57)),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF6F8F7),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF6F8F7),
          centerTitle: false,
        ),
      ),
      home: const AuthGate(),
    );
  }
}
