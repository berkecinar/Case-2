class LoginResponseParameters {
  LoginResponseParameters({
    this.token,
    this.error,
  });
  final String? token;
  final String? error;

  LoginResponseParameters.fromJson(Map<String, dynamic> json)
      : token = json['token'],
        error = json['error'];
}