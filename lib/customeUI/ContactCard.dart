import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp/model/ChatModel.dart';

class ContactCard extends StatelessWidget {
  ChatModel contact;

  ContactCard({Key? key, required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context).copyWith(
        textTheme: TextTheme(
            caption:
                Theme.of(context).textTheme.caption!.apply(color: Colors.grey),
            subtitle1: Theme.of(context)
                .textTheme
                .subtitle1!
                .apply(color: Colors.black, fontWeightDelta: 2)));

    return ListTile(
      leading: Container(
        height: 53,
        width: 50,
        child: Stack(
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
                      backgroundColor: Colors.green[200],
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  )
                : Container()),
          ],
        ),
      ),
      title: Text(
        contact.name,
        style: theme.textTheme.subtitle1,
      ),
      subtitle: Text(
        contact.status,
        style: theme.textTheme.caption,
      ),
    );
  }
}
