class LoginResponseParameters {
  LoginResponseParameters({
    required this.token,
    required this.refreshToken,
    required this.email,
    required this.clientId,
  });
  final String token;
  final String refreshToken;
  final String clientId;
  final String email;

  LoginResponseParameters.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        token = json['token'],
        refreshToken = json['refreshToken'],
        clientId = json['clientId'];
}