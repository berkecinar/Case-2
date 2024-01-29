import 'login_response_parameters_model.dart';

class LoginResponse {
  LoginResponse({required this.loginResponseParameters, required this.statusCode});
  final LoginResponseParameters loginResponseParameters;
  final int statusCode;
}