import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'local_storage/controllers/local_storage_controller.dart';
import 'login_feature/views/home_page_view.dart';
import 'login_feature/views/login_page_view.dart';

void main() {
  runApp(
    const ProviderScope(
      child: CaseTwoApp(),
    ),
  );
}

class CaseTwoApp extends HookConsumerWidget  {
  const CaseTwoApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Case Two',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ref.watch(getIsLoggedInProvider).when(
            data: (bool isAuthenticated) =>
                isAuthenticated ? const HomePageView() : const LoginPageView(),
            loading: () {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
            error: (error, stacktrace) => const LoginPageView(),
          ),
      routes: {
        "Home": (context) => const HomePageView(),
        "Login": (context) => const LoginPageView(),
      },
    );
  }
}
