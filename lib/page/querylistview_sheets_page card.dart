import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sheets_update_example/api/sheets/phrases_fetch_api.dart';
import 'package:google_sheets_update_example/model/phrase.dart';
import 'package:google_sheets_update_example/page/phrase_page.dart';
import '/api/sheets/phrases_fetch_api.dart';
import '../model/phrase.dart';
import 'phrase_page.dart';

class QueryListViewSheetsPageCard extends StatelessWidget {
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
          final phrasesOut = phrases[index];

          return Card(
            color: Colors.black54,
            shadowColor: Colors.grey,
            elevation: 8,
            clipBehavior: Clip.antiAlias,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: InkWell(
              onTap: () {
                Get.to(PhrasePage(),
                    arguments: phrasesOut.catid, transition: Transition.zoom);
              },
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
                          phrasesOut.eng,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        Text(
                          phrasesOut.kor,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        Text(
                          phrasesOut.jap,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          phrasesOut.st,
                          style: TextStyle(fontSize: 14, color: Colors.white38),
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
