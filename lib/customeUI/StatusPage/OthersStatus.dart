import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OthersStatus extends StatelessWidget {
  final String name;
  final String image;
  final String time;

  const OthersStatus(
      {Key? key, required this.name, required this.image, required this.time})
      : super(key: key);

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
      leading: CircleAvatar(
        radius: 26,
        backgroundColor: Colors.white,
        backgroundImage: AssetImage(image),
      ),
      title: Text(
        name,
        style: theme.textTheme.subtitle1,
      ),
      subtitle: Text(
        'today at, $time',
        style: theme.textTheme.caption,
      ),
    );
  }
}
