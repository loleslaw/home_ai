import 'package:HomeAI/Widgets/MainAppBar.dart';
import 'package:HomeAI/main.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(tekst: 'strona glowna'),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('strona glowna'),
            RaisedButton(
              onPressed: () {
                auth.signOut();
                Navigator.pushNamed(context, '/loginPage');
              },
              child: Text('logout'),
            )
          ],
        ),
      ),
    );
  }
}
