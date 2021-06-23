import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:whatsapp/config.dart';
import 'package:whatsapp/customeUI/OwnMessageCard.dart';
import 'package:whatsapp/customeUI/ReplyCard.dart';
import 'package:whatsapp/model/ChatModel.dart';
import 'package:whatsapp/model/MessageModel.dart';

class IndividualPage extends StatefulWidget {
  final ChatModel chatModel;
  ChatModel sourceChat;

  IndividualPage({
    required this.chatModel,
    required this.sourceChat,
  });

  @override
  State<StatefulWidget> createState() {
    return _IndividualPageState();
  }
}

class _IndividualPageState extends State<IndividualPage> {
  List<MessageModel> messages = [];

  bool show = false;
  bool send = true;
  ScrollController _scrollController = ScrollController();

  FocusNode focusNode = FocusNode();
  IO.Socket socket = IO.io(SOCKET_URL, <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
  });

  TextEditingController _controller = TextEditingController(
    text: '',
  );

  void connect() {
    socket.connect();
    socket.onConnect((_) {
      print('connected');
      print(_.toString());

      setMessage('destination', 'welcome');
      socket.emit('signin', widget.sourceChat.id);

      socket.on('message', (msg) {
        print('received message');
        print('current Id is : ${widget.sourceChat.id}');
        print(msg);
        setMessage('destination', msg);
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: Duration(microseconds: 1000), curve: Curves.bounceIn);
      });
    });

    socket.onDisconnect((_) {
      print(_);
      print('disconnect');
      socket.emit('leave', widget.sourceChat.id);
    });

    print('connected is : ' + socket.connected.toString());
  }

  @override
  void initState() {
    super.initState();
    connect();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });

    setState(() {
      send = _controller.text.isNotEmpty;
    });
  }

  void sendMessage(String message, int sourceId, targetId) {
    if (message.isNotEmpty) {
      setMessage('source', message);
      socket.emit('message',
          {"message": message, "sourceId": sourceId, "targetId": targetId});
    } else {
      print('empty message');
    }
  }

  void setMessage(String type, String message, {String? time = ''}) {
    MessageModel messageModel = MessageModel(
        type: type,
        message: message,
        time: (time!.isNotEmpty ? DateTime.parse(time) : DateTime.now()));
    setState(() {
      setState(() {
        messages.add(messageModel);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context).copyWith(
        textTheme: TextTheme(
      caption: Theme.of(context).textTheme.caption!.apply(color: Colors.white),
      subtitle1:
          Theme.of(context).textTheme.subtitle1!.apply(color: Colors.white),
      headline5:
          Theme.of(context).textTheme.headline5!.apply(color: Colors.white),
    ));

    return Stack(
      children: [
        Image.asset(
          CHAT_BACKGROUND_IMAGE,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: AppBar(
              leadingWidth: 70,
              titleSpacing: 0,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_back,
                      size: 24,
                    ),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.blueGrey,
                      child: SvgPicture.asset(
                        "assets/${this.widget.chatModel.icon}",
                        color: Colors.white,
                        height: 35,
                        width: 35,
                      ),
                    ),
                  ],
                ),
              ),
              title: InkWell(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.chatModel.name.toString(),
                        style: theme.textTheme.headline5,
                      ),
                      Text(
                        'last seen today at 12:05',
                        style: theme.textTheme.caption,
                      )
                    ],
                  ),
                ),
              ),
              actions: [
                IconButton(onPressed: () {}, icon: Icon(Icons.videocam)),
                IconButton(onPressed: () {}, icon: Icon(Icons.call)),
                PopupMenuButton<String>(
                  padding: EdgeInsets.all(0),
                  onSelected: (value) {
                    print(value);
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text('View Contact'),
                      value: 'View Contact',
                    ),
                    PopupMenuItem(
                      child: Text('Media, Links, Documents'),
                      value: 'Media, Links, Documents',
                    ),
                    PopupMenuItem(
                      child: Text('Search'),
                      value: 'Search',
                    ),
                    PopupMenuItem(
                      child: Text('Mute Notification'),
                      value: 'Mute Notification',
                    ),
                    PopupMenuItem(
                      child: Text('Wallpaper'),
                      value: 'Wallpaper',
                    ),
                  ],
                ),
              ],
            ),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WillPopScope(
              onWillPop: () {
                if (show) {
                  setState(() {
                    show = false;
                  });
                } else {
                  Navigator.pop(context);
                }
                return Future.value(false);
              },
              child: Column(
                children: [
                  Expanded(
                    // height: MediaQuery.of(context).size.height - 140,
                    child: ListView.builder(
                      controller: _scrollController,
                      shrinkWrap: true,
                      itemCount: messages.length + 1,
                      itemBuilder: (context, index) {
                        if (index == messages.length) {
                          return Container(
                              // height: 70,
                              );
                        }
                        return messages[index].type == "source"
                            ? OwnMessageCard(message: messages[index])
                            : ReplyCard(message: messages[index]);
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: <Widget>[
                              Container(
                                  width: MediaQuery.of(context).size.width - 60,
                                  margin: const EdgeInsets.only(
                                      left: 2, right: 2, bottom: 8),
                                  child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: TextFormField(
                                        controller: _controller,
                                        focusNode: focusNode,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 5,
                                        onChanged: (value) {
                                          setState(() {
                                            this.send = this
                                                ._controller
                                                .text
                                                .isNotEmpty;
                                          });
                                        },
                                        minLines: 1,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Type a message",
                                            suffixIcon: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    showModalBottomSheet(
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      context: context,
                                                      builder: (builder) =>
                                                          bottomsheet(context),
                                                    );
                                                  },
                                                  icon: Icon(Icons.attach_file),
                                                ),
                                                IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(Icons.camera_alt),
                                                ),
                                              ],
                                            ),
                                            prefixIcon: IconButton(
                                              icon: Icon(Icons.emoji_emotions),
                                              onPressed: () {
                                                focusNode.unfocus();
                                                focusNode.canRequestFocus =
                                                    false;
                                                setState(() {
                                                  show = !show;
                                                });
                                              },
                                            ),
                                            contentPadding: EdgeInsets.all(10)),
                                      ))),
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 8, right: 1),
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: theme.accentColor,
                                  child: send
                                      ? IconButton(
                                          icon: Icon(Icons.send),
                                          onPressed: () {
                                            _scrollController.animateTo(
                                                _scrollController
                                                    .position.maxScrollExtent,
                                                duration: Duration(
                                                    microseconds: 1000),
                                                curve: Curves.bounceIn);
                                            sendMessage(
                                                _controller.text,
                                                widget.sourceChat.id,
                                                widget.chatModel.id);
                                            _controller.clear();
                                            setState(() {
                                              send = false;
                                            });
                                          },
                                        )
                                      : IconButton(
                                          icon: Icon(Icons.mic),
                                          onPressed: () {},
                                        ),
                                ),
                              ),
                            ],
                          ),
                          show ? emojiSelecet(context) : Container(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomsheet(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 278,
      child: Card(
        margin: const EdgeInsets.all(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconcreation(context, Icons.insert_drive_file, Colors.indigo,
                      'Document'),
                  SizedBox(
                    width: 40,
                  ),
                  iconcreation(
                      context, Icons.camera_alt, Colors.pink, 'Camera'),
                  SizedBox(
                    width: 40,
                  ),
                  iconcreation(
                      context, Icons.insert_photo, Colors.purple, 'Gallery'),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconcreation(context, Icons.headset, Colors.orange, 'Audio'),
                  SizedBox(
                    width: 40,
                  ),
                  iconcreation(
                      context, Icons.location_pin, Colors.teal, 'Location'),
                  SizedBox(
                    width: 40,
                  ),
                  iconcreation(context, Icons.person, Colors.blue, 'Contact'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconcreation(
      BuildContext context, IconData icon, Color color, String text) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icon,
              size: 29,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );
  }

  Widget emojiSelecet(BuildContext context) {
    return Offstage(
      offstage: !show,
      child: SizedBox(
        height: 300,
        child: EmojiPicker(
          config: const Config(
              verticalSpacing: 0,
              horizontalSpacing: 0,
              initCategory: Category.RECENT,
              bgColor: Color(0xFFF2F2F2),
              iconColor: Colors.grey,
              iconColorSelected: APP_COLOR,
              progressIndicatorColor: APP_COLOR,
              backspaceColor: APP_COLOR,
              showRecentsTab: true,
              recentsLimit: 28,
              emojiSizeMax: 32,
              columns: 7,
              noRecentsText: 'No Recents',
              noRecentsStyle: TextStyle(fontSize: 20, color: Colors.black26),
              categoryIcons: CategoryIcons(),
              buttonMode: ButtonMode.MATERIAL,
              indicatorColor: Colors.blueGrey),
          onEmojiSelected: (category, emoji) => {
            setState(() {
              _controller.text += emoji.emoji;
              send = _controller.text.isNotEmpty;
            })
          },
          onBackspacePressed: () {
            setState(() {
              send = _controller.text.isNotEmpty;
            });
          },
        ),
      ),
    );
  }
}
