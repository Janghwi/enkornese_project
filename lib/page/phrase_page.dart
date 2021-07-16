import 'package:flutter/material.dart';
import 'package:google_sheets_update_example/model/phrase.dart';
import '/model/user.dart';

class PhrasePage extends StatelessWidget {
  final Phrase phrases;

  const PhrasePage({
    Key? key,
    required this.phrases,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(phrases.eng),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundImage:
                    NetworkImage('https://picsum.photos/id/237/200/300'),
                radius: 80,
              ),
              const SizedBox(height: 40),
              Text(
                phrases.eng,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
              Text(
                phrases.kor,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
              Text(
                phrases.jap,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 64),
              ElevatedButton(
                child: Text(
                  'Send Email',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      );
}
