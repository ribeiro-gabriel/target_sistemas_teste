import 'package:flutter/material.dart';

import 'app/modules/login/ui/login_page.dart';

void main() {
  runApp(const AppWidget());
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Teste Target Sistemas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const LoginPage(),
        // '/home': (context) => HomePage(),
      },
      builder: (context, child) {
        return Scaffold(
          body: SafeArea(
            child: Center(
                child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF1F4F62),
                          Color(0xFF2C948E),
                        ],
                      )),
              child: child!,
            )),
          ),
        );
      },
    );
  }
}
