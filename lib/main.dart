import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:target_sistemas_teste/app/modules/home/ui/card_page.dart';
import 'package:target_sistemas_teste/core/my_summary.dart';

import 'app/modules/home/ui/home_page.dart';
import 'app/modules/login/ui/login_page.dart';
import 'core/dependency_injection_container.dart';

Future<void> main() async {
  final DependencyInjectionContainer dependencyInjectionContainer =
      DependencyInjectionContainer();

  runInAction(() {
    dependencyInjectionContainer.cardTextStore.saveMySummaryText();
  });

  runApp(AppWidget(dependencyInjectionContainer: dependencyInjectionContainer));
}

class AppWidget extends StatelessWidget {
  final DependencyInjectionContainer dependencyInjectionContainer;

  const AppWidget({super.key, required this.dependencyInjectionContainer});

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
        '/home': (context) => HomePage(
              store: dependencyInjectionContainer.homePageStore,
            ),
        '/card_page': (context) =>
            CardPage(store: dependencyInjectionContainer.cardTextStore),
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
