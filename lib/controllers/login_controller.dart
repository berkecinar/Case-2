import 'package:case_2/controllers/local_storage_controller.dart';
import 'package:case_2/models/login_response_model.dart';
import 'package:case_2/services/login_web_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../models/login_request_arguments_model.dart';

//Login web service connection for riverpod providers
final authenticationHandlerProvider = StateProvider<LoginWebService>(
  (_) => LoginWebService(),
);

final loginProvider = FutureProvider.family<bool, LoginRequestArguments>(
  (ref, loginArguments) async {
    return Future.delayed(const Duration(seconds: 0), () async {
      final loginResponse =
          await ref.watch(authenticationHandlerProvider).sendLoginRequest(
                loginArguments,
              );

      print(loginResponse.statusCode);

      final isLoginSuccess = loginResponse.statusCode == 200;

      if (isLoginSuccess) {
        ref.read(setLoginStateProvider.notifier).state = LoginResponse(
            loginResponseParameters: loginResponse.loginResponseParameters,
            statusCode: loginResponse.statusCode);
        ref.read(setIsLoggedInProvider(isLoginSuccess));
        ref.read(
            setUserTokenProvider(loginResponse.loginResponseParameters.token!));
      } else if (loginResponse.statusCode == 400) {
        ref.read(loginErrorMessageProvider.notifier).state =
            'E-Posta veya Şifre Hatalı. Hata Kodu: ${loginResponse.statusCode}';
      } else {
        ref.read(loginErrorMessageProvider.notifier).state =
            'Beklenmedik Bir Hata Oluştu Lütfen Bağlantınızı Kontrol Edin. Hata Kodu: ${loginResponse.statusCode}';
      }

      return isLoginSuccess;
    });
  },
);

final loginErrorMessageProvider = StateProvider<String>(
  (ref) => '',
);
