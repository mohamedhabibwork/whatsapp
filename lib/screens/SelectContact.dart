import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/customeUI/ButtonCard.dart';
import 'package:whatsapp/customeUI/ContactCard.dart';
import 'package:whatsapp/model/ChatModel.dart';
import 'package:whatsapp/screens/CreateGroup.dart';

class SelectContact extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SelectContactState();
  }
}

class _SelectContactState extends State<SelectContact> {
  final List<ChatModel> contacts = [
    ChatModel(
      id: 1,
      name: 'dev 1',
      isGroup: false,
      currentMessage: 'message',
      icon: 'person',
      time: '15:00',
    ),
    ChatModel(
        id: 2,
        name: 'dev 2',
        isGroup: false,
        currentMessage: 'message',
        icon: 'person',
        time: '15:00'),
    ChatModel(
        id: 3,
        name: 'dev 3',
        isGroup: false,
        currentMessage: 'message',
        icon: 'person',
        time: '15:00'),
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
    ThemeData theme = Theme.of(context).copyWith(
        textTheme: TextTheme(
            caption:
                Theme.of(context).textTheme.caption!.apply(color: Colors.white),
            subtitle1: Theme.of(context)
                .textTheme
                .subtitle1!
                .apply(color: Colors.white)));

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              'Select Contact',
              style: theme.textTheme.subtitle1,
            ),
            Text(
              '256 contacts',
              style: theme.textTheme.caption,
            )
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          PopupMenuButton<String>(
            padding: EdgeInsets.all(0),
            onSelected: (value) {
              print(value);
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('Invite a friend'),
                value: 'Invite a friend',
              ),
              PopupMenuItem(
                child: Text('Refresh'),
                value: 'Refresh',
              ),
              PopupMenuItem(
                child: Text('Help'),
                value: 'Help',
              ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          if (index == 0) {
            return ButtonCard(
                name: 'new groups',
                icon: Icons.groups,
                handler: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateGroup(),
                      ));
                });
          } else if (index == 1) {
            return ButtonCard(
              name: 'new contact',
              icon: Icons.person_add,
            );
          }
          return ContactCard(contact: contacts[index - 2]);
        },
        itemCount: contacts.length + 2,
      ),
    );
  }
}
