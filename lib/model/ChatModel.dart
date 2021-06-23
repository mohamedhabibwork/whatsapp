class ChatModel {
  int id;
  String name;
  String icon;
  bool isGroup;
  String time;
  String currentMessage;
  String status;
  bool checked;

  ChatModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.isGroup,
    required this.time,
    required this.currentMessage,
    this.checked = false,
    this.status = "Devanagari Sangam MN",
  });
}
