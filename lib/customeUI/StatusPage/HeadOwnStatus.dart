import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HeadOwnStatus extends StatelessWidget {
  HeadOwnStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context).copyWith(
        textTheme: TextTheme(
      caption: Theme.of(context)
          .textTheme
          .caption!
          .apply(color: Colors.grey[900], fontSizeDelta: 0),
      subtitle1: Theme.of(context)
          .textTheme
          .subtitle1!
          .apply(color: Colors.black, fontWeightDelta: 4),
    ));
    return ListTile(
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 27,
            backgroundColor: Colors.white,
            backgroundImage: AssetImage("assets/bg_blue.jpg"),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: CircleAvatar(
              radius: 10,
              backgroundColor: Colors.greenAccent[700],
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 20,
              ),
            ),
          )
        ],
      ),
      title: Text(
        'My Status',
        style: theme.textTheme.subtitle1,
      ),
      subtitle: Text(
        'Tap to add status',
        style: theme.textTheme.caption,
      ),
    );
  }
}
