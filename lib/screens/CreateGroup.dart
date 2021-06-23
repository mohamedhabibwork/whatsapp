import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/customeUI/AvatarCard.dart';
import 'package:whatsapp/customeUI/ContactCard.dart';
import 'package:whatsapp/model/ChatModel.dart';

class CreateGroup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CreateGroupState();
  }
}

class _CreateGroupState extends State<CreateGroup> {
  final List<ChatModel> groups = [];

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
              'New Group',
              style: theme.textTheme.subtitle1,
            ),
            Text(
              'Add participants',
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
      body: Stack(
        children: [
          ListView.builder(
            itemBuilder: (context, index) {
              if (index == 0) {
                return Container(
                  height: groups.length > 0 ? 90 : 0,
                );
              }
              return InkWell(
                  onTap: () {
                    setState(() {
                      contacts[index - 1].checked =
                          !contacts[index - 1].checked;
                      if (contacts[index - 1].checked) {
                        groups.add(contacts[index - 1]);
                      } else {
                        groups.remove(contacts[index - 1]);
                      }
                    });
                  },
                  child: ContactCard(contact: contacts[index - 1]));
            },
            itemCount: contacts.length + 1,
          ),
          (groups.length > 0
              ? Column(
                  children: [
                    Container(
                      height: 75,
                      color: Colors.white,
                      child: ListView.builder(
                        itemCount: contacts.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => contacts[index].checked
                            ? InkWell(
                                onTap: () {
                                  setState(() {
                                    contacts[index].checked = false;
                                    groups.remove(contacts[index]);
                                  });
                                },
                                child: AvatarCard(contact: contacts[index]))
                            : Container(),
                      ),
                    ),
                    Divider(
                      thickness: 1,
                    )
                  ],
                )
              : Container()),
        ],
      ),
    );
  }
}
