class ChatItem {
  final String id;
  final String name;
  final String lastMessage;
  final bool isGroupChat;

  ChatItem({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.isGroupChat,
  });
}
