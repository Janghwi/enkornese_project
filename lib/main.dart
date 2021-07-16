import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:staggered_gridview_example/widget/basic_grid_widget.dart';
// import 'package:staggered_gridview_example/widget/custom_scroll_view_grid_widget.dart';
// import 'package:staggered_gridview_example/widget/dynamic_size_grid_widget.dart';
// import 'package:staggered_gridview_example/widget/tabbar_widget.dart';

import 'page/create_sheets_page.dart';
import 'page/listview_sheets_page.dart';
import 'page/modify_sheets_page.dart';
import 'page/1querymenuonelevel_page.dart';
import 'widget/tabbar_widget.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'ENKORNESE';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData.dark(),
        home: MainPage(title: title),
      );
}

class MainPage extends StatelessWidget {
  final String title;

  const MainPage({
    required this.title,
  });

  Widget build(BuildContext context) => TabBarWidget(
        title: title,
        tabs: [
          Tab(
            text: '문장',
            icon: Icon(Icons.home),
          ),
          Tab(
            text: '명언',
            icon: Icon(Icons.dynamic_feed),
          ),
          Tab(
            text: '자기계발',
            icon: Icon(Icons.dynamic_feed),
          ),
          Tab(
            text: '즐겨찾기',
            icon: Icon(Icons.dynamic_feed),
          ),
        ],
        children: [
          QueryMenuOnelevelPage(),
          CreateSheetsPage(),
          ModifySheetsPage(),
          ListViewSheetsPage(),
        ],
      );
}
