import 'package:flutter_session/flutter_session.dart';
import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: FutureBuilder(
          future: saveData(context),
          builder: (context, snapshot) {
            return Text("You will not see this");
          }),
    );
  }

  Future<void> saveData(context) async {
    String token = 'The token you got from the API';
    await FlutterSession().set('token', token);
    Navigator.push(context, MaterialPageRoute(builder: (_context) => Page2()));
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: FutureBuilder(
            future: FlutterSession().get('token'),
            builder: (context, snapshot) {
              return Text(snapshot.hasData ? snapshot.data : 'Loading...');
            }));
  }
}
