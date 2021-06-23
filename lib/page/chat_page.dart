import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/customeUI/CustomCard.dart';
import 'package:whatsapp/model/ChatModel.dart';
import 'package:whatsapp/screens/SelectContact.dart';

class ChatPage extends StatefulWidget {
  final List<ChatModel> chatsModels;
  ChatModel sourceChat;

  ChatPage({Key? key, required this.chatsModels, required this.sourceChat})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ChatPageState();
  }
}

class _ChatPageState extends State<ChatPage> {
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SelectContact(),
              ));
        },
        child: Icon(Icons.chat),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => CustomCard(
          chat: widget.chatsModels[index],
          sourceChat: widget.sourceChat,
        ),
        itemCount: widget.chatsModels.length,
      ),
    );
  }
}
