import 'package:ai_avatar/screens/ai_avatar_page.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:provider/provider.dart';

import 'provider/user_provider.dart';
import 'utils/text_style.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Connectivity _connectivity = Connectivity();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
  GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    _startMonitoringConnectivity();
  }

  void _startMonitoringConnectivity() {
    _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> resultList) {
      final result =
      resultList.isNotEmpty ? resultList.first : ConnectivityResult.none;
      bool isOnline = result != ConnectivityResult.none;

      final snackBar = SnackBar(
        backgroundColor: isOnline ? Colors.green : Colors.red,
        content: Text(
          isOnline ? "Internet Connected ✅" : "No Internet Connection ❌",
          style: const TextStyle(color: Colors.white),
        ),
        duration: const Duration(seconds: 3),
      );

      _scaffoldMessengerKey.currentState!
        ..removeCurrentSnackBar()
        ..showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppThemeWrapper(
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: _scaffoldMessengerKey,
        home: const AiAvatarPage(),
      ),
    );
  }
}
