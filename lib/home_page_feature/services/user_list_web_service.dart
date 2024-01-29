import 'dart:convert';
import 'package:case_2/home_page_feature/models/user_list_model.dart';
import 'package:http/http.dart';


class UserListWebService {
  Future<UserList?> getUserListRequest() async {
    try {
      var uri = Uri.parse('https://reqres.in/api/{resource}?page=1&per_page=12');

      var response = await get(uri);

      if (response.statusCode == 200) {
        var json = response.body;
        return userListFromJson(json);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

}
