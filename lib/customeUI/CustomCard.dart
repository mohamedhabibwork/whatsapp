import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp/model/ChatModel.dart';
import 'package:whatsapp/screens/IndividualPage.dart';

class CustomCard extends StatelessWidget {
  final ChatModel chat;
  ChatModel sourceChat;

  CustomCard({required this.chat, required this.sourceChat});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  IndividualPage(chatModel: chat, sourceChat: sourceChat),
            ));
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: SvgPicture.asset(
                "assets/${chat.icon}",
                color: Colors.white,
                height: 35,
                width: 35,
              ),
              backgroundColor: Colors.blueGrey,
            ),
            trailing: Text(chat.time),
            title: Text(
              chat.name,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              children: [
                Icon(Icons.done_all),
                SizedBox(
                  width: 3,
                ),
                Text(
                  chat.currentMessage,
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 20,
              left: 80,
            ),
            child: Divider(
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
