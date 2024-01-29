import 'dart:convert';

import '../models/login_request_arguments_model.dart';
import '../models/login_response_model.dart';
import 'package:http/http.dart';

import '../models/login_response_parameters_model.dart';

class LoginWebService {
  late LoginResponseParameters loginResponseParameters = LoginResponseParameters(
    token: '',
  );

  Future<LoginResponse> sendLoginRequest(LoginRequestArguments loginRequestArguments) async {
    dynamic header = {
      "content-type": "application/json"
    };

    Map bodyObject = {
      "email": loginRequestArguments.email,
      "password": loginRequestArguments.password
      //'token': 'my_token',
    };

    var body = json.encode(bodyObject);

    var uri = Uri.parse('https://reqres.in/api/login');

    var response = await post(uri, headers: header, body: body);

    loginResponseParameters = LoginResponseParameters.fromJson(
      jsonDecode(response.body),
    );

    // return response.statusCode;
    return LoginResponse(
      loginResponseParameters: loginResponseParameters,
      statusCode: response.statusCode,
    );
  }

}
