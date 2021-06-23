import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/model/ChatModel.dart';
import 'package:whatsapp/page/CameraPage.dart';
import 'package:whatsapp/page/StatusPage.dart';
import 'package:whatsapp/page/chat_page.dart';

class HomeScreen extends StatefulWidget {
  final List<ChatModel> chatsModels;
  ChatModel sourceChat;

  HomeScreen({Key? key, required this.chatsModels, required this.sourceChat})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  static const List<Tab> myTabs = <Tab>[
    Tab(
      icon: Icon(Icons.camera_alt),
    ),
    Tab(text: 'Chats'),
    Tab(text: 'Status'),
    Tab(text: 'Calls'),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Whatsapp'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          PopupMenuButton<String>(onSelected: (value) {
            print(value);
          }, itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                child: Text('New Group'),
                value: 'New Group',
              ),
              PopupMenuItem(
                child: Text('New Broadcast'),
                value: 'New Broadcast',
              ),
              PopupMenuItem(
                child: Text('Whatsapp Web'),
                value: 'Whatsapp Web',
              ),
              PopupMenuItem(
                child: Text('Starrted Messages'),
                value: 'Starrted Messages',
              ),
              PopupMenuItem(
                child: Text('Settings'),
                value: 'Settings',
              ),
            ];
          })
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: myTabs,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          CameraPage(),
          ChatPage(
              chatsModels: widget.chatsModels, sourceChat: widget.sourceChat),
          StatusPage(),
          Tab(
            icon: Icon(Icons.email),
          ),
        ],
      ),
    );
  }
}
