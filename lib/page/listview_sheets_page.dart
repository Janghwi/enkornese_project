import 'package:flutter/material.dart';
import 'package:google_sheets_update_example/api/sheets/user_sheets_api.dart';
import 'package:google_sheets_update_example/main.dart';
import 'package:google_sheets_update_example/model/user.dart';
import 'package:google_sheets_update_example/widget/button_widget.dart';
import 'package:google_sheets_update_example/widget/navigate_users_widget.dart';
import 'package:google_sheets_update_example/widget/user_form_widget.dart';

class ListViewSheetsPage extends StatefulWidget {
  @override
  _ListViewSheetState createState() => _ListViewSheetState();
}

class _ListViewSheetState extends State<ListViewSheetsPage> {
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
        body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 40.0,
                    height: 40.0,
                    child: ClipOval(
                      child: Image.network(users[index].url,
                          fit: BoxFit.cover, width: 80, height: 80),
                    ),
                  ),
                  Text(users[index].id.toString()),
                  Expanded(
                    child: Container(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          users[index].name,
                          style: TextStyle(fontSize: 15),
                          //maxLines: 1,
                          //overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                  Text(users[index].email),
                ]);
          },
        ),
      );
}
