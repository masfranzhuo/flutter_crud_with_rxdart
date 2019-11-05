import 'package:flutter_crud_with_rxdart/src/models/user_model.dart';
import 'package:flutter_crud_with_rxdart/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc {
  final _repository = Repository();
  final _user = PublishSubject<User>();

  Observable<User> get user => _user.stream;
  
  getUser(int id) async {
    User user = id == null ? User() : await _repository.getUser(id);
    _user.sink.add(user);
  }

  createUser(User user) async {
    user.id = await _repository.createUser(user);
    _user.sink.add(user);
  }

  updateUser(User user) async {
    await _repository.updateUser(user);
    _user.sink.add(user);
  }

  dispose() {
    _user.close();
  }
}

final userBloc = UserBloc();