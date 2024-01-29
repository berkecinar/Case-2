import 'package:flutter/material.dart';

class LoginPageView extends StatefulWidget {
  const LoginPageView({super.key});

  @override
  State<LoginPageView> createState() => _LoginPageViewState();
}

class _LoginPageViewState extends State<LoginPageView> {

  final formKey = GlobalKey<FormState>();

  TextEditingController loginMailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  @override
  void dispose() {
    loginMailController.dispose();
    loginPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
              child:
            Form(
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
                    onPressed: (){
                      if(formKey.currentState!.validate()){
                        print('login');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        )),
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
