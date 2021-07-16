import 'package:flutter/material.dart';
import 'package:google_sheets_update_example/api/sheets/user_sheets_api.dart';
import 'package:google_sheets_update_example/widget/user_form_widget.dart';

import '../main.dart';

class CreateSheetsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(MyApp.title),
          centerTitle: true,
        ),
        body: Builder(
          builder: (context) => Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: UserFormWidget(
                onSavedUser: (user) async {
                  final id = await UserSheetsApi.getRowCount() + 1;
                  final newUser = user.copy(id: id);

                  await UserSheetsApi.insert([newUser.toJson()]);

                  final snackBar = SnackBar(
                    content: Text('Added To Google Sheets!'),
                    backgroundColor: Colors.green,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
              ),
            ),
          ),
        ),
      );

  // Future insertUsers() async {
  //   final users = [
  //     User(id: 1, name: 'John', email: 'john@gmail.com', isBeginner: false),
  //     User(id: 2, name: 'Emma', email: 'emma@gmail.com', isBeginner: true),
  //     User(id: 3, name: 'Paul', email: 'paul@gmail.com', isBeginner: true),
  //     User(id: 4, name: 'Dean', email: 'dean@gmail.com', isBeginner: false),
  //     User(id: 5, name: 'Lisa', email: 'lisa@gmail.com', isBeginner: false),
  //   ];
  //   final jsonUsers = users.map((user) => user.toJson()).toList();

  //   await UserSheetsApi.insert(jsonUsers);
  // }
}
