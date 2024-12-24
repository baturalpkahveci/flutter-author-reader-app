import 'package:flutter/material.dart';
import 'package:flutter_author_reader_app/providers/chat_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_author_reader_app/models/user_chat.dart';
import 'package:flutter_author_reader_app/models/group_chat.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  State<ChatsPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatsPage> {
  String filter = 'all'; // Possible values: 'all', 'user', 'group'

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);

    List<dynamic> chatsToDisplay;

    switch (filter) {
      case 'user':
        chatsToDisplay = chatProvider.userChats;
        break;
      case 'group':
        chatsToDisplay = chatProvider.groupChats;
        break;
      default:
        chatsToDisplay = chatProvider.allChats;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // Filter Options
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FilterButton(
                  label: 'All',
                  isActive: filter == 'all',
                  onTap: () => setState(() => filter = 'all'),
                ),
                FilterButton(
                  label: 'User Chats',
                  isActive: filter == 'user',
                  onTap: () => setState(() => filter = 'user'),
                ),
                FilterButton(
                  label: 'Group Chats',
                  isActive: filter == 'group',
                  onTap: () => setState(() => filter = 'group'),
                ),
              ],
            ),
          ),
          // Chat List
          Expanded(
            child: ListView.builder(
              itemCount: chatsToDisplay.length,
              itemBuilder: (context, index) {
                final chat = chatsToDisplay[index];

                return ChatTile(chat: chat);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const FilterButton({
    Key? key,
    required this.label,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class ChatTile extends StatelessWidget {
  final dynamic chat; // Can be UserChat or GroupChat

  const ChatTile({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String chatTitle;
    String lastMessage;
    bool isGroup;

    if (chat is UserChat) {
      chatTitle = chat.userName;
      lastMessage = chat.lastMessage;
      isGroup = false;
    } else if (chat is GroupChat) {
      chatTitle = chat.groupName;
      lastMessage = chat.lastMessage;
      isGroup = true;
    } else {
      return const SizedBox.shrink(); // Fallback for unexpected types
    }

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: isGroup ? Colors.green : Colors.blue,
        child: Text(chatTitle[0].toUpperCase()),
      ),
      title: Text(chatTitle),
      subtitle: Text(lastMessage),
      onTap: () {
        // Navigate to Chat Details Page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatDetailsPage(chat: chat),
          ),
        );
      },
    );
  }
}

class ChatDetailsPage extends StatelessWidget {
  final dynamic chat;

  const ChatDetailsPage({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String chatTitle;

    if (chat is UserChat) {
      chatTitle = chat.userName;
    } else if (chat is GroupChat) {
      chatTitle = chat.groupName;
    } else {
      chatTitle = 'Unknown Chat';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(chatTitle),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text('Chat Details for $chatTitle'),
      ),
    );
  }
}
