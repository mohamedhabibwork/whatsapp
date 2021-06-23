import 'package:flutter/material.dart';
import 'package:whatsapp/config.dart';

class OtherMessageCard extends StatelessWidget {
  const OtherMessageCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          // maxHeight: MediaQuery.of(context).size.height - 150,
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          color: CHAT_OTHER_MESSAGE_COLOR,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 30, top: 10, bottom: 20),
                child: Text(
                  'message message message message message message message ',
                  style: TextStyle(
                    fontSize: 16,
                    locale: Locale("en"),
                  ),
                ),
              ),
              Positioned(
                right: 4,
                bottom: 10,
                child: Text(
                  '20:56',
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
