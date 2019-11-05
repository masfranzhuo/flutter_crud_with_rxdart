import 'package:flutter_crud_with_rxdart/src/models/user_model.dart';
import 'package:flutter_crud_with_rxdart/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class UserListBloc {
  final _repository = Repository();
  final _users = PublishSubject<List<User>>();

  Observable<List<User>> get users => _users.stream;
  
  getUsers() async {
    List<User> users = await _repository.getUsers();
    _users.sink.add(users);
  }

  deleteUser(int id) async {
    await _repository.deleteUser(id);
    getUsers();
  }

  dispose() {
    _users.close();
  }
}

final userListBloc = UserListBloc();