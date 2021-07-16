import 'package:flutter/material.dart';
import 'package:google_sheets_update_example/api/sheets/menus_fetch_api.dart';
import 'package:google_sheets_update_example/api/sheets/phrases_fetch_api.dart';
import 'package:google_sheets_update_example/model/menu.dart';
import 'package:google_sheets_update_example/model/phrase.dart';
import 'package:google_sheets_update_example/page/phrase_page.dart';
import '/api/sheets/menus_fetch_api.dart';
import '../model/menu.dart';
import 'menu_page.dart';

class QueryMenuViewSheetsPage extends StatelessWidget {
  var menus;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: FutureBuilder<List<Menu>>(
          future: MenusFetchApi.fetchMenus(),
          builder: (context, snapshot) {
            final menus = snapshot.data;

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return Center(child: Text('Some error occurred!'));
                } else {
                  return buildMenus(menus!);
                }
            }
          },
        ),
      );

  Widget buildMenus(List<Menu> menus) => ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: menus.length,
        itemBuilder: (context, index) {
          final menusOut = menus[index];

          return Card(
            color: Colors.black54,
            shadowColor: Colors.grey,
            elevation: 8,
            clipBehavior: Clip.antiAlias,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => MenuPage(
                  menu: menusOut,
                ),
              )),
              child: Container(
                // decoration: BoxDecoration(
                //   gradient: LinearGradient(
                //     colors: [Colors.blue.shade600, Colors.blue.shade200],
                //     begin: Alignment.topCenter,
                //     end: Alignment.bottomCenter,
                //   ),
                // ),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          menusOut.eng,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        Text(
                          menusOut.kor,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        Text(
                          menusOut.jap,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.chat_bubble_outline_rounded),
                            ),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Learn More',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.blue),
                                )),
                          ],
                        ),
                      ],
                    )),
              ),
            ),
          );
        },
      );
}
