import 'package:flutter/material.dart';
import 'package:flutter_crud_with_rxdart/src/blocs/user_bloc.dart';
import 'package:flutter_crud_with_rxdart/src/blocs/user_bloc_provider.dart';
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

  UserBloc userBloc;

  @override
  void didChangeDependencies() {
    userBloc = UserBlocProvider.of(context);
    userBloc.getUserById(widget.id);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    userBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Edit User'),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
              child: StreamBuilder(
                  stream: userBloc.user,
                  builder: (context, AsyncSnapshot<Future<User>> snapshot) {
                    if (snapshot.hasData) {
                      return FutureBuilder(
                        future: snapshot.data,
                        builder: (context, AsyncSnapshot<User> itemSnapshot) {
                          if (itemSnapshot.hasData) {
                            User user = itemSnapshot.data;
                            return Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        labelText: 'Name',
                                      ),
                                      initialValue: user?.name ?? '',
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
                                      initialValue: user?.username ?? '',
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
                                      initialValue: user?.email ?? '',
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
                                        userListBloc.updateUser(user);
                                        Navigator.pop(context);
                                      }
                                    },
                                  )
                                ],
                              ),
                            );
                          }
                          return loading();
                        },
                      );
                    } else if (snapshot.hasError) {
                      return errorMessage(snapshot.error.toString());
                    }
                    return loading();
                  })),
        ),
      ),
    );
  }
}
