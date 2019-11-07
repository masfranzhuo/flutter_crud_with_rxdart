import 'package:flutter_crud_with_rxdart/src/models/user_model.dart';
import 'package:flutter_crud_with_rxdart/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class UserListBloc {
  final _repository = Repository();
  final _users = PublishSubject<List<User>>();

  Observable<List<User>> get users => _users.stream;
  
  getUsers({String query}) async {
    List<User> users = await _repository.getUsers(query: query);
    _users.sink.add(users);
  }

  createUser(User user) async {
    await _repository.createUser(user);
    getUsers();
  }

  updateUser(User user) async {
    await _repository.updateUser(user);
    getUsers();
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