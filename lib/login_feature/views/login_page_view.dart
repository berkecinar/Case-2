import 'package:case_2/login_feature/controllers/login_controller.dart';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../local_storage/controllers/local_storage_controller.dart';
import '../models/login_request_arguments_model.dart';
import '../models/login_response_model.dart';
import '../models/login_response_parameters_model.dart';
import '../../home_page_feature/views/home_page_view.dart';

class LoginPageView extends StatefulHookConsumerWidget {
  const LoginPageView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageViewState();
}

class _LoginPageViewState extends ConsumerState<LoginPageView> {
  final formKey = GlobalKey<FormState>();

  TextEditingController loginMailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  bool isButtonEnable = true;

  @override
  void dispose() {
    loginMailController.dispose();
    loginPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(loginErrorMessageProvider, (prev, next) {
      print('test');
      if (next.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next),
          ),
        );
        setState(() {
          isButtonEnable = true;
        });
      } else {
        loginMailController.text = '';
        loginPasswordController.text = '';
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const Text(
                    'Hoşgeldiniz!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 8, 16, 32),
                    child: Text(
                      'Sisteme Girebilmek İçin Giriş Yapmalısınız',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: loginMailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Bu Alan Boş Bırakılamaz";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.indigo, width: 2)),
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: const Icon(
                          Icons.mail,
                          color: Colors.indigo,
                        ),
                        labelText: 'E-Posta',
                        labelStyle: const TextStyle(
                          color: Colors.indigo,
                        ),
                        contentPadding: const EdgeInsets.all(16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            width: 2,
                            color: Colors.indigo,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: TextFormField(
                      obscureText: true,
                      controller: loginPasswordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Bu Alan Boş Bırakılamaz";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.indigo,
                            width: 2,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon:
                            const Icon(Icons.lock, color: Colors.indigo),
                        labelText: 'Şifre',
                        labelStyle: const TextStyle(
                          color: Colors.indigo,
                        ),
                        contentPadding: const EdgeInsets.all(16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.indigo,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: isButtonEnable == false
                        ? null
                        : () async {
                            if (formKey.currentState!.validate()) {
                              ref.read(setLoginStateProvider.notifier).state =
                                  LoginResponse(
                                      loginResponseParameters:
                                          new LoginResponseParameters(),
                                      statusCode: 100);

                              ref.read(setIsLoggedInProvider(false));

                              LoginRequestArguments loginRequestArguments =
                                  LoginRequestArguments(
                                email: loginMailController.text,
                                password: loginPasswordController.text,
                              );

                              setState(() {
                                isButtonEnable = false;
                              });

                              ref.read(
                                loginProvider(loginRequestArguments),
                              );

                              dynamic isLoggedIn =
                                  await ref.read(getIsLoggedInProvider);
                              print(isLoggedIn.value!);

                              if ((await ref.read(getIsLoggedInProvider))
                                  .value!) {
                                setState(() {
                                  isButtonEnable = true;
                                });
                                if (context.mounted) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomePageView(),
                                    ),
                                  );
                                }
                              }
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Giriş Yap",
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Giriş Yaparken Sorun mu Yaşıyorsunuz?',
                    ),
                  ),
                  InkWell(
                    onTap: () {}, //TODO: Contact US / Get Help Part
                    child: const Text(
                      'Bize Ulaşın',
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}