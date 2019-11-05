import 'package:flutter_crud_with_rxdart/src/models/user_model.dart';

import 'user_provider.dart';

class Repository {
  final userProvider = UserProvider();

  Future getUsers({String query}) => userProvider.getUsers(query: query);

  Future getUser(int id) => userProvider.getUser(id: id);

  Future createUser(User user) => userProvider.createUser(user);

  Future updateUser(User user) => userProvider.updateUser(user);

  Future deleteUser(int id) => userProvider.deleteUser(id);
}