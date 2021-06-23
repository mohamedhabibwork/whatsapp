import 'package:flutter/material.dart';
import 'package:whatsapp/config.dart';
import 'package:whatsapp/model/MessageModel.dart';

class OwnMessageCard extends StatelessWidget {
  final MessageModel message;
  const OwnMessageCard({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          // maxHeight: MediaQuery.of(context).size.height - 150,
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          color: CHAT_OWN_MESSAGE_COLOR,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 30, top: 10, bottom: 20),
                child: Text(
                  message.message,
                  style: TextStyle(
                    fontSize: 16,
                    locale: const Locale("en"),
                  ),
                ),
              ),
              Positioned(
                right: 4,
                bottom: 4,
                child: Row(
                  children: [
                    Text(
                      "${message.time.hour.toString()}:${message.time.minute.toString()}",
                      style: Theme.of(context).textTheme.caption,
                    ),
                    const SizedBox(width: 5),
                    Icon(Icons.done_all, size: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
