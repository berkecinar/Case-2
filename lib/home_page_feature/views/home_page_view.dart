import 'dart:io';
import 'package:case_2/home_page_feature/controllers/user_list_cubit_controller.dart';
import 'package:case_2/home_page_feature/models/user_list_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../local_storage/controllers/local_storage_controller.dart';
import '../../login_feature/views/login_page_view.dart';

class HomePageView extends StatefulHookConsumerWidget {
  const HomePageView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageViewState();
}

class _HomePageViewState extends ConsumerState<HomePageView> {

  @override
  void initState() {
    context.read<UserListCubit>().getUserList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
      body: BlocBuilder<UserListCubit, UserListState>(
        builder: (context, state) {
          if (state.userList == null) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF214A73),
              ),
            );
          } else {
            if (state.userList!.data.isEmpty) {
              return const Center(
                child: Text(
                  "Kullanıcı Bulunamadı!.",
                  style: TextStyle(
                    color: Color(0xFF214A73),
                    fontSize: 24,
                  ),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: state.userList!.data.length,
                itemBuilder: (context, index) => ListTile(
                  leading: CircleAvatar(child: Image.network(state.userList!.data[index].avatar)),
                  title: Text(state.userList!.data[index].firstName + state.userList!.data[index].lastName),
                  subtitle: Text(state.userList!.data[index].email),
                ),
              );
            }
          }
        },
      ),
    );
  }
}

