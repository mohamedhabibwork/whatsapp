import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/customeUI/ButtonCard.dart';
import 'package:whatsapp/model/ChatModel.dart';
import 'package:whatsapp/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  late ChatModel sourceChat;
  List<ChatModel> chatsModels = [
    ChatModel(
        id: 1,
        name: 'test 1',
        time: '16:40',
        icon: 'person.svg',
        currentMessage: 'message',
        isGroup: false),
    ChatModel(
        id: 2,
        name: 'test 2',
        time: '16:40',
        icon: 'person.svg',
        currentMessage: 'message',
        isGroup: false),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemBuilder: (context, index) => ButtonCard(
            name: chatsModels[index].name,
            icon: Icons.person,
            handler: () {
              setState(() {
                sourceChat = chatsModels.removeAt(index);
              });
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(
                        chatsModels: chatsModels, sourceChat: sourceChat),
                  ));
            }),
        itemCount: chatsModels.length,
      ),
    );
  }
}
