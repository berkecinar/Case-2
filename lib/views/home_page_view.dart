import 'dart:io';

import 'package:case_2/controllers/local_storage_controller.dart';
import 'package:case_2/views/login_page_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePageView extends HookConsumerWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    if (Platform.isIOS) {
                      return CupertinoAlertDialog(
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Hayır'),
                            child: const Text('Hayır'),
                          ),
                          TextButton(
                            onPressed: () {

                              ref.read(
                                setIsLoggedInProvider(false),
                              );


                              ref.read(clearStorage);

                              Navigator.pushAndRemoveUntil<void>(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                  const LoginPageView(),
                                ),
                                    (Route<dynamic> route) => false,
                              );
                            },
                            child: const Text('Evet'),
                          ),
                        ],
                        title: const Text(
                          "Çıkış Yapmak Üzeresiniz",
                        ),
                        content: const Text(
                          'Hesabınızdan çıkış yapmak istediğniize emin misiniz?',
                        ),
                      );
                    } else {
                      return AlertDialog(
                        elevation: 0,
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Hayır'),
                            child: const Text('Hayır'),
                          ),
                          TextButton(
                            onPressed: () {
                              ref.watch(setLoginStateProvider);
                              ref.read(clearStorage);

                              Navigator.pushAndRemoveUntil<void>(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                  const LoginPageView(),
                                ),
                                    (Route<dynamic> route) => false,
                              );
                            },
                            child: const Text('Evet'),
                          ),
                        ],
                        title: const Text(
                          "Çıkış Yapmak Üzeresiniz",
                        ),
                        content: const Text(
                          'Hesabınızdan çıkış yapmak istediğniize emin misiniz?',
                        ),
                      );
                    }
                  });
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
