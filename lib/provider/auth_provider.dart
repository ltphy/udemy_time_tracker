import 'package:flutter/cupertino.dart';
import 'package:udemy_timer_tracker/services/sign_in_services.dart';

class AuthProvider extends InheritedWidget {
  final BaseAuth auth;

  AuthProvider({Key? key, required this.auth, required Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(AuthProvider authProvider) {
    // TODO: implement updateShouldNotify
    return authProvider.auth != this.auth;
  }

  static AuthProvider of(BuildContext context) {
    final AuthProvider? result =
        context.dependOnInheritedWidgetOfExactType<AuthProvider>();
    assert(result != null, 'No FrogColor found in context');
    return result!;
  }
}

class AuthenticateProvider {
  final BaseAuth auth;

  AuthenticateProvider({required this.auth});
}
