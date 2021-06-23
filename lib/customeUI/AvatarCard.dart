import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whatsapp/model/ChatModel.dart';

class AvatarCard extends StatelessWidget {
  final ChatModel contact;

  AvatarCard({Key? key, required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8.0),
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 23,
                backgroundColor: Colors.blueGrey[200],
                child: SvgPicture.asset(
                  "assets/" + contact.icon + ".svg",
                  color: Colors.white,
                ),
              ),
              (contact.checked
                  ? Positioned(
                      bottom: 4,
                      right: 5,
                      child: CircleAvatar(
                        radius: 11,
                        backgroundColor: Colors.red[500],
                        child: Icon(
                          Icons.remove,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    )
                  : Container()),
            ],
          ),
          Text(contact.name),
        ],
      ),
    );
  }
}
