import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sheets_update_example/model/phrase.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_html/flutter_html.dart';
import '../model/htmlsrc.dart';

class WordHtmlPage extends StatelessWidget {
  const WordHtmlPage({
    Key? key,
  }) : super(key: key);

  Future<List<HtmlSrc>> fetchDatas() async {
    var catid = Get.arguments[0];

    final url = Uri.parse(
      //'http://gsx2json.com/api?id=1uBvyfmwv8LsuAbp87voiXmQYSchk4p1BlqIMxGtzSfg&sheet=4&display=all&columns=false',
      //'https://gsx2json.com/api?id=1uBvyfmwv8LsuAbp87voiXmQYSchk4p1BlqIMxGtzSfg&sheet=4&selection=선택947&columns=false',
      //'https://gsx2json.com/api?id=1uBvyfmwv8LsuAbp87voiXmQYSchk4p1BlqIMxGtzSfg&sheet=8&situation=$selection&columns=false',
      //'https://gsx2json.com/api?id=1uBvyfmwv8LsuAbp87voiXmQYSchk4p1BlqIMxGtzSfg&sheet=3&selection=인사&columns=false',
      //'https://immense-depths-63197.herokuapp.com/api?id=1uBvyfmwv8LsuAbp87voiXmQYSchk4p1BlqIMxGtzSfg&sheet=3&columns=false&catid=secondmenus.catid',
      'https://gsx2json.com/api?id=1i11vzA9wgOIeizHoX24Y5WqJAI-yj6d2FvtVgWXFq1Y&sheet=5&columns=false&catid=$catid',
    );
    final response = await http.get(url);

    final body =
        json.decode(response.body)['rows'].cast<Map<String, dynamic>>();
    print(response.body);

    return body.map<HtmlSrc>(HtmlSrc.fromJson).toList();

    //return body.map<User>(User.fromJson).toList();
  }

  final htmlData = r"""
<p id='top'><a href='#bottom'>Scroll to bottom</a></p>
      <h1>Header 1</h1>
      <h2>Header 2</h2>
      <h3>Header 3</h3>
      <h4>Header 4</h4>
      <h5>Header 5</h5>
      <h6>Header 6</h6>
      <h3>Ruby Support:</h3>
      <p>
        <ruby>
          漢<rt>かん</rt>
          字<rt>じ</rt>
        </ruby>
        &nbsp;is Japanese Kanji.
      </p>
      <h3>Support for maxLines:</h3>
      <h5>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec vestibulum sapien feugiat lorem tempor, id porta orci elementum. Fusce sed justo id arcu egestas congue. Fusce tincidunt lacus ipsum, in imperdiet felis ultricies eu. In ullamcorper risus felis, ac maximus dui bibendum vel. Integer ligula tortor, facilisis eu mauris ut, ultrices hendrerit ex. Donec scelerisque massa consequat, eleifend mauris eu, mollis dui. Donec placerat augue tortor, et tincidunt quam tempus non. Quisque sagittis enim nisi, eu condimentum lacus egestas ac. Nam facilisis luctus ipsum, at aliquam urna fermentum a. Quisque tortor dui, faucibus in ante eget, pellentesque mattis nibh. In augue dolor, euismod vitae eleifend nec, tempus vel urna. Donec vitae augue accumsan ligula fringilla ultrices et vel ex.</h5>
      <h3>Support for <code>sub</code>/<code>sup</code></h3>
      Solve for <var>x<sub>n</sub></var>: log<sub>2</sub>(<var>x</var><sup>2</sup>+<var>n</var>) = 9<sup>3</sup>
      <p>One of the most <span>common</span> equations in all of physics is <br /><var>E</var>=<var>m</var><var>c</var><sup>2</sup>.</p>
      <h3>Inline Styles:</h3>
      <p>The should be <span style='color: blue;'>BLUE style='color: blue;'</span></p>
      <p>The should be <span style='color: red;'>RED style='color: red;'</span></p>
      <p>The should be <span style='color: rgba(0, 0, 0, 0.10);'>BLACK with 10% alpha style='color: rgba(0, 0, 0, 0.10);</span></p>
      <p>The should be <span style='color: rgb(0, 97, 0);'>GREEN style='color: rgb(0, 97, 0);</span></p>
      <p>The should be <span style='background-color: red; color: rgb(0, 97, 0);'>GREEN style='color: rgb(0, 97, 0);</span></p>
      <p style="text-align: center;"><span style="color: rgba(0, 0, 0, 0.95);">blasdafjklasdlkjfkl</span></p>
      <p style="text-align: right;"><span style="color: rgba(0, 0, 0, 0.95);">blasdafjklasdlkjfkl</span></p>
      <p style="text-align: justify;"><span style="color: rgba(0, 0, 0, 0.95);">blasdafjklasdlkjfkl</span></p>
      <p style="text-align: center;"><span style="color: rgba(0, 0, 0, 0.95);">blasdafjklasdlkjfkl</span></p>
      <h3>Table support (with custom styling!):</h3>
      <p>
      <q>Famous quote...</q>
      </p>""";

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(Get.arguments[1].toString()),
          // title: Text(passparam.toString()),
        ),
        body: FutureBuilder<List<HtmlSrc>>(
          future: fetchDatas(),
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

  Widget buildUsers(List<HtmlSrc> datas) {
    final datasOut = datas[0];
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Html(
          data: datasOut.html,
          customRender: {
            // 'flutter' : (RenderContext context, Widget child, attributes, _){
            //   return FlutterLogo(
            //     style: FlutterLogoStyle.horizontal,
            //     textColor: Colors.blue,
            //     size: 100.0,
            //   );
            // }
          },
          // style: {
          //   'html': Style(backgroundColor: Colors.white12),
          //   'table': Style(backgroundColor: Colors.grey.shade200),
          //   //'p': Style(backgroundColor: Colors.grey.shade200),
          //   'td': Style(
          //     backgroundColor: Colors.grey.shade400,
          //     padding: EdgeInsets.all(10),
          //   ),
          //   'th': Style(padding: EdgeInsets.all(10), color: Colors.black),
          //   'tr': Style(
          //       backgroundColor: Colors.grey.shade300,
          //       border: Border(bottom: BorderSide(color: Colors.greenAccent))),
          // },
          // onLinkTap: (url){
          //     print('Open the url $url......');
          // },
          // onImageTap: (img){
          //     print('Image $img');
          // },
          // onImageError: (exception, stacktrace){
          //     print(exception);
          // },
        ),
      ),
    );
  }
}
