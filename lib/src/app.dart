import 'package:flutter/material.dart';
import 'package:flutter_crud_with_rxdart/src/ui/view/user_list_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: UserListScreen(),
    );
  }
}