import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../login_feature/models/login_response_model.dart';


// Constant SharedPereferences Key's
const isLoggedInKey = 'isLoggedIn';
const userTokenKey = 'userToken';

//Sharedpreferences Getter
final sharedPreferencesProvider = Provider((_) async {
  return await SharedPreferences.getInstance();
});

//Provider must watched by every methods which update state
final setLoginStateProvider = StateProvider<LoginResponse?>(
  (ref) => null,
);


//isLogged Getter/Setter
final getIsLoggedInProvider = FutureProvider<bool>(
      (ref) async {
    final prefs = await ref.watch(sharedPreferencesProvider);
    ref.watch(setLoginStateProvider);
    return prefs.getBool(isLoggedInKey) ?? false;
  },
);

final setIsLoggedInProvider = StateProvider.family<void, bool>(
  (ref, isLoggedIn) async {
    print('method $isLoggedIn');
    final prefs = await ref.watch(sharedPreferencesProvider);
    ref.watch(setLoginStateProvider);
    prefs.setBool(
      isLoggedInKey,
      isLoggedIn,
    );
  },
);


//userToken Getter/Setter
final getUserTokenProvider = FutureProvider<String>(
  (ref) async {
    final prefs = await ref.watch(sharedPreferencesProvider);
    ref.watch(setLoginStateProvider);
    return prefs.getString(userTokenKey) ?? '';
  },
);

final setUserTokenProvider = StateProvider.family<void, String>(
      (ref, userToken) async {
        print('method $userToken');
    final prefs = await ref.watch(sharedPreferencesProvider);
    ref.watch(setLoginStateProvider);
    prefs.setString(
      userTokenKey,
      userToken,
    );
  },
);

final clearStorage = StateProvider<dynamic>(
  (ref) async {
    final prefs = await ref.watch(sharedPreferencesProvider);
    final isCleared = await prefs.clear();

    print(prefs.get("isLoggedIn"));
    print(prefs.get("userToken"));
    print(isCleared);

    return isCleared;
  },
);
