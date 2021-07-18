import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sheets_update_example/api/sheets/phrases_fetch_api.dart';
import 'package:google_sheets_update_example/model/phrase.dart';
import 'package:google_sheets_update_example/page/phrase_page.dart';
import '/api/sheets/phrases_fetch_api.dart';
import '../model/phrase.dart';
import 'phrase_page.dart';

class QueryListViewSheetsPage1 extends StatelessWidget {
  var phrases;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: FutureBuilder<List<Phrase>>(
          future: PhrasesFetchApi.fetchPhrases(),
          builder: (context, snapshot) {
            final phrases = snapshot.data;

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return Center(child: Text('Some error occurred!'));
                } else {
                  return buildUsers(phrases!);
                }
            }
          },
        ),
      );

  Widget buildUsers(List<Phrase> phrases) => ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: phrases.length,
        itemBuilder: (context, index) {
          final phrases_out = phrases[index];

          return ListTile(
            onTap: () {
              Get.to(PhrasePage(),
                  arguments: phrases_out.catid, transition: Transition.zoom);
            },
            leading: CircleAvatar(
              backgroundImage:
                  NetworkImage('https://picsum.photos/id/237/200/300'),
            ),
            title: Text(phrases_out.eng),
            subtitle: Text(phrases_out.kor),
            trailing: Icon(Icons.keyboard_arrow_right),
          );
        },
      );
}
