import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonCard extends StatelessWidget {
  final String name;
  final IconData icon;
  final Function? handler;
  final Color color;

  ButtonCard({
    Key? key,
    required this.name,
    required this.icon,
    this.handler,
    this.color = const Color(0xFF25D366),
  }) : super(key: key);

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

    return InkWell(
      onTap: () {
        handler!();
      },
      child: ListTile(
        leading: CircleAvatar(
          radius: 23,
          backgroundColor: color,
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        title: Text(
          name,
          style: theme.textTheme.subtitle1,
        ),
      ),
    );
  }
}
