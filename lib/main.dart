import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sheets_update_example/api/sheets/user_sheets_api.dart';
import 'package:google_sheets_update_example/page/create_sheets_page.dart';
import 'package:google_sheets_update_example/page/modify_sheets_page.dart';
import 'package:google_sheets_update_example/page/querymenuview_sheets_pagecard.dart';

import 'page/listview_sheets_page.dart';
import 'page/querymenuview_sheets_pagecard.dart';

void main() {
  runApp(GetMaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  static final String title = 'Google Sheets API';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: MainPage(),
      );
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
        bottomNavigationBar: buildBottomBar(),
        body: buildMenus(),
      );

  Widget buildBottomBar() {
    final style = TextStyle(color: Colors.white);

    return BottomNavigationBar(
      backgroundColor: Theme.of(context).primaryColor,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      currentIndex: index,
      items: [
        BottomNavigationBarItem(
          icon: Text('Sheets', style: style),
          label: 'Menu',
        ),
        BottomNavigationBarItem(
          icon: Text('Sheets', style: style),
          label: 'Create',
        ),
        BottomNavigationBarItem(
          icon: Text('Sheets', style: style),
          label: 'Modify',
        ),
        BottomNavigationBarItem(
          icon: Text('Sheets', style: style),
          label: 'listview',
        ),
      ],
      onTap: (int index) => setState(() => this.index = index),
    );
  }

  Widget buildMenus() {
    switch (index) {
      case 0:
        return QueryMenuViewSheetsPage();
      case 3:
        return CreateSheetsPage();
      case 1:
        return ModifySheetsPage();
      case 2:
        return ListViewSheetsPage();
      default:
        return Container();
    }
  }
}
