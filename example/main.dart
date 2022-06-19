import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';

class Data {
  final int id;
  final String data;

  Data({required this.data, required this.id});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["data"] = this.data;
    return data;
  }
}

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
    Data myData = Data(data: "Lorem ipsum, something, something...", id: 1);

    await FlutterSession().set('myData', myData);
    Navigator.push(context, MaterialPageRoute(builder: (_context) => Page2()));
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: FutureBuilder(
            future: FlutterSession().get('myData'),
            builder: (context, snapshot) {
              return Text(snapshot.hasData
                  ? "${(snapshot.data as Map)['id'] ?? ""}| ${(snapshot.data as Map)['data']}"
                  : 'Loading...');
            }));
  }
}
