import 'package:flutter/material.dart';

class TabBarWidget extends StatelessWidget {
  final String title;
  final List<Tab> tabs;
  final List<Widget> children;

  const TabBarWidget({
    Key? key,
    required this.title,
    required this.tabs,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text(title,
                style: TextStyle(fontSize: 30, color: Colors.white)),
            centerTitle: true,
            bottom: TabBar(
              isScrollable: true,
              indicatorColor: Colors.yellowAccent,
              indicatorWeight: 4,
              tabs: tabs,
            ),
            elevation: 20,
            titleSpacing: 20,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8),
            child: TabBarView(children: children),
          ),
        ),
      );
}
