import 'package:flutter/material.dart';
import 'package:flutter_crud_with_rxdart/src/blocs/user_list_bloc.dart';
import 'package:flutter_crud_with_rxdart/src/models/user_model.dart';
import 'package:flutter_crud_with_rxdart/src/ui/shared/error_message_widget.dart';
import 'package:flutter_crud_with_rxdart/src/ui/shared/loading_widget.dart';
import 'package:flutter_crud_with_rxdart/src/ui/shared/no_data_widget.dart';
import 'package:flutter_crud_with_rxdart/src/ui/shared/snackbar_widget.dart';
import 'package:flutter_crud_with_rxdart/src/ui/view/user_form_screen.dart';

class UserListScreen extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    userListBloc.getUsers();
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('List User'),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => UserForm()));
            }),
        body: StreamBuilder(
          stream: userListBloc.users,
          builder: (context, AsyncSnapshot<List<User>> snapshot) {
            if (snapshot.hasData) {
              return Container(
                  child: (snapshot.data.isNotEmpty
                      ? ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            User user = snapshot.data[index];
                            return _userCard(user, context);
                          },
                        )
                      : noData()));
            } else if (snapshot.hasError) {
              return errorMessage(snapshot.error.toString());
            }
            return loading();
          },
        ));
  }

  Card _userCard(User user, BuildContext context) {
    return Card(
        child: Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(padding: EdgeInsets.all(10), child: Text(user.name)),
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserForm(id: user.id)));
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  userListBloc.deleteUser(user.id);
                  _scaffoldKey.currentState
                      .showSnackBar(snackBar(user.name + ' deleted'));
                },
              )
            ],
          ),
        ],
      ),
    ));
  }
}
