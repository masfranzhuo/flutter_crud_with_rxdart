import 'package:flutter_crud_with_rxdart/src/models/user_model.dart';
import 'package:flutter_crud_with_rxdart/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc {
  final _repository = Repository();
  final _userId = PublishSubject<int>();
  final _user = BehaviorSubject<Future<User>>();

  Function(int) get getUserById => _userId.sink.add;
  Observable<Future<User>> get user => _user.stream;

  UserBloc() {
    _userId.stream.transform(_userTransformer()).pipe(_user);
  }

  _userTransformer() {
    return ScanStreamTransformer(
      (Future<User> user, int id, int index) {
        user = _repository.getUser(id);
        return user;
      }
    );
  }

  dispose() async {
    _userId.close();
    await _user.drain();
    _user.close();
  }
}