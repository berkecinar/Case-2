import 'login_response_parameters_model.dart';

class LoginResponse {
  LoginResponse({required this.authValues, required this.statusCode});
  final LoginResponseParameters authValues;
  final int statusCode;
}