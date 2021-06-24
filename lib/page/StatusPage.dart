import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/customeUI/StatusPage/HeadOwnStatus.dart';
import 'package:whatsapp/customeUI/StatusPage/OthersStatus.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 48,
            child: FloatingActionButton(
              elevation: 8,
              backgroundColor: Colors.blueGrey[100],
              onPressed: () {},
              child: Icon(Icons.edit, color: Colors.blueGrey[900]),
            ),
          ),
          const SizedBox(
            height: 13,
          ),
          FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.greenAccent[700],
            child: Icon(Icons.camera_alt, color: Colors.white),
            elevation: 5,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            HeadOwnStatus(),
            label('Recent update'),
            OthersStatus(
              name: 'Habib',
              image: "assets/bg_black.jpg",
              time: '12:34',
              statusNum: 2,
            ),
            label('Viewd updates'),
            OthersStatus(
              name: 'Habib',
              image: "assets/bg_black.jpg",
              time: '12:34',
              statusNum: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget label(String labelName) {
    return Container(
      height: 33,
      width: MediaQuery.of(context).size.width,
      color: Colors.grey[300],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 7),
        child: Text(
          labelName,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
    );
  }
}
