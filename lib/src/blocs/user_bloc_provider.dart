import 'package:flutter/material.dart';
import 'user_bloc.dart';
export 'user_bloc.dart';

class UserBlocProvider extends InheritedWidget {
  final UserBloc userBloc;

  UserBlocProvider({Key key, Widget child}) : userBloc = UserBloc(), super(key: key, child: child);

  @override
  bool updateShouldNotify(_) {
    return true;
  }

  static UserBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(UserBlocProvider) as UserBlocProvider).userBloc;
  }
}