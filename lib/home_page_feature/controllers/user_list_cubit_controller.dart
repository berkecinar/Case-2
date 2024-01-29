import 'package:case_2/home_page_feature/models/user_list_state.dart';
import 'package:case_2/home_page_feature/services/user_list_web_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserListCubit extends Cubit<UserListState> {
  UserListCubit() : super(UserListState(null));

  final userListWebService = UserListWebService();

  getUserList() async {
    emit(
      UserListState(
        await userListWebService.getUserListRequest(),
      ),
    );
  }
}
