import 'package:flutter/material.dart';
import 'package:flutter_crud_with_rxdart/src/blocs/user_bloc.dart';
import 'package:flutter_crud_with_rxdart/src/blocs/user_list_bloc.dart';
import 'package:flutter_crud_with_rxdart/src/models/user_model.dart';
import 'package:flutter_crud_with_rxdart/src/ui/shared/error_message_widget.dart';
import 'package:flutter_crud_with_rxdart/src/ui/shared/loading_widget.dart';

class UserForm extends StatefulWidget {
  final int id;

  UserForm({this.id});

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    userBloc.getUser(widget.id);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.id == null ? 'Add' : 'Edit' + ' User'),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
              child: StreamBuilder(
                  stream: userBloc.user,
                  builder: (context, AsyncSnapshot<User> snapshot) {
                    User user = snapshot.data;
                    _nameController.value =
                        _nameController.value.copyWith(text: user?.name ?? '');
                    _usernameController.value = _usernameController.value
                        .copyWith(text: user?.username ?? '');
                    _emailController.value = _emailController.value
                        .copyWith(text: user?.email ?? '');
                    return Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: 'Name',
                              ),
                              controller: _nameController,
                              // initialValue: user?.name ?? '',
                              onChanged: (value) {
                                user?.name = value;
                              },
                              validator: (value) {
                                if (value.length < 1) {
                                  return 'Name cannot be empty';
                                }
                                return null;
                              }),
                          TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: 'Username',
                              ),
                              controller: _usernameController,
                              // initialValue: user?.username ?? '',
                              onChanged: (value) {
                                user?.username = value;
                              },
                              validator: (value) {
                                if (value.length < 1) {
                                  return 'Username cannot be empty';
                                }
                                return null;
                              }),
                          TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: 'Email',
                              ),
                              controller: _emailController,
                              // initialValue: user?.email ?? '',
                              onChanged: (value) {
                                user?.email = value;
                              },
                              validator: (value) {
                                if (value.length < 1) {
                                  return 'Email cannot be empty';
                                }
                                return null;
                              }),
                          RaisedButton(
                            child: Text('Submit'),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                widget.id == null
                                    ? userBloc.createUser(user)
                                    : userBloc.updateUser(user);
                                userListBloc.getUsers();
                                Navigator.pop(context);
                              }
                            },
                          )
                        ],
                      ),
                    );
                  })),
        ),
      ),
    );
  }
}
