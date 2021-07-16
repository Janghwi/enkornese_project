import 'package:flutter/material.dart';
import 'package:google_sheets_update_example/api/sheets/user_sheets_api.dart';
import 'package:google_sheets_update_example/main.dart';
import 'package:google_sheets_update_example/model/user.dart';
import 'package:google_sheets_update_example/widget/button_widget.dart';
import 'package:google_sheets_update_example/widget/navigate_users_widget.dart';
import 'package:google_sheets_update_example/widget/user_form_widget.dart';

class ModifySheetsPage extends StatefulWidget {
  @override
  _ModifySheetsPageState createState() => _ModifySheetsPageState();
}

class _ModifySheetsPageState extends State<ModifySheetsPage> {
  List<User> users = [];
  int index = 0;

  @override
  void initState() {
    super.initState();

    getUsers();
  }

  Future getUsers({int index = 0}) async {
    final users = await UserSheetsApi.getAll();

    setState(() {
      this.index = index;
      this.users = users;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(MyApp.title),
          centerTitle: true,
        ),
        body: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(16),
            children: [
              UserFormWidget(
                user: users.isEmpty ? null : users[index],
                onSavedUser: (user) async {
                  await UserSheetsApi.update(user.id!, user.toJson());

                  // UserSheetsApi.updateCell(
                  //   id: 4,
                  //   key: 'email',
                  //   value: 'dean@flutter.dev',
                  // );
                },
              ),
              const SizedBox(height: 16),
              if (users.isNotEmpty) buildUserControls(),
            ],
          ),
        ),
      );

  Widget buildUserControls() => Column(
        children: [
          ButtonWidget(
            text: 'Delete',
            onClicked: deleteUser,
          ),
          const SizedBox(height: 16),
          NavigateUsersWidget(
            text: '${index + 1}/${users.length} Users',
            onClickedNext: () {
              final nextIndex = index >= users.length - 1 ? 0 : index + 1;

              setState(() => index = nextIndex);
            },
            onClickedPrevious: () {
              final previousIndex = index <= 0 ? users.length - 1 : index - 1;

              setState(() => index = previousIndex);
            },
          ),
        ],
      );

  Future deleteUser() async {
    final user = users[index];

    await UserSheetsApi.deleteById(user.id!);

    /// Just for updating UI
    final newIndex = index > 0 ? index - 1 : 0;
    await getUsers(index: newIndex);
  }
}
