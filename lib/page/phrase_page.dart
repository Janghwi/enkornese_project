import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sheets_update_example/model/phrase.dart';
import 'package:http/http.dart' as http;

import '/model/user.dart';

class PhrasePage extends StatelessWidget {
  const PhrasePage({
    Key? key,
  }) : super(key: key);

  Future<List<Phrase>> fetchPhrases() async {
    var catid = Get.arguments;

    final url = Uri.parse(
      //'http://gsx2json.com/api?id=1uBvyfmwv8LsuAbp87voiXmQYSchk4p1BlqIMxGtzSfg&sheet=4&display=all&columns=false',
      //'https://gsx2json.com/api?id=1uBvyfmwv8LsuAbp87voiXmQYSchk4p1BlqIMxGtzSfg&sheet=4&selection=선택947&columns=false',
      //'https://gsx2json.com/api?id=1uBvyfmwv8LsuAbp87voiXmQYSchk4p1BlqIMxGtzSfg&sheet=8&situation=$selection&columns=false',
      //'https://gsx2json.com/api?id=1uBvyfmwv8LsuAbp87voiXmQYSchk4p1BlqIMxGtzSfg&sheet=3&selection=인사&columns=false',
      //'https://immense-depths-63197.herokuapp.com//api?id=1uBvyfmwv8LsuAbp87voiXmQYSchk4p1BlqIMxGtzSfg&sheet=3&columns=false&catid=secondmenus.catid',
      'https://gsx2json.com/api?id=1uBvyfmwv8LsuAbp87voiXmQYSchk4p1BlqIMxGtzSfg&sheet=9&columns=false&catid=$catid',
    );
    final response = await http.get(url);

    final body =
        json.decode(response.body)['rows'].cast<Map<String, dynamic>>();
    print(response.body);

    return body.map<Phrase>(Phrase.fromJson).toList();

    //return body.map<User>(User.fromJson).toList();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(Get.arguments[1].toString()),
        ),
        body: FutureBuilder<List<Phrase>>(
          future: fetchPhrases(),
          builder: (context, snapshot) {
            final pharsesnapshot = snapshot.data;

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return Center(child: Text('Some error occurred!'));
                } else {
                  return buildUsers(pharsesnapshot!);
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
          var phraseNo = index + 1;
          return Card(
            child: Column(
              children: [
                Row(children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.blueGrey,
                    radius: 12,
                    child: Text(
                      phraseNo.toString(),
                      style: TextStyle(fontSize: 10, color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Text(
                      phrasesOut.eng,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ]),
                ListTile(
                  onTap: () => {},
                  // leading: CircleAvatar(
                  //   backgroundColor: Colors.blueGrey,
                  //   child: Text(
                  //     phraseNo.toString(),
                  //     style: TextStyle(fontSize: 15, color: Colors.white),
                  //   ),
                  // ),
                  title: Text(phrasesOut.kor, overflow: TextOverflow.ellipsis),
                  subtitle: Text(
                    phrasesOut.jap,
                    overflow: TextOverflow.ellipsis,
                  ),
                  isThreeLine: true,
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
              ],
            ),
          );
        },
      );
}
