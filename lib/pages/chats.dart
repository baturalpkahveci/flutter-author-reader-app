import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_author_reader_app/providers/chat_provider.dart';
import 'package:flutter_author_reader_app/core/app_colors.dart';
import 'package:flutter_author_reader_app/models/user_chat.dart';
import 'package:flutter_author_reader_app/models/group_chat.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatsPage> {
  String filter = 'all'; // Options: 'all', 'user', 'group'

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);
    List<dynamic> filteredChats = [];

    // Determine the chat list based on the current filter
    switch (filter) {
      case 'user':
        filteredChats = chatProvider.userChats;
        break;
      case 'group':
        filteredChats = chatProvider.groupChats;
        break;
      default:
        filteredChats = chatProvider.allChats;
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          // Filter buttons
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _filterButton('All', 'all', filter),
                _filterButton('User Chats', 'user', filter),
                _filterButton('Group Chats', 'group', filter),
              ],
            ),
          ),
          Expanded(
            child: filteredChats.isEmpty
                ? const Center(
              child: Text(
                'No chats available.',
                style: TextStyle(
                  color: AppColors.primaryColor,
                ),
              ),
            )
                : ListView.builder(
              itemCount: filteredChats.length,
              itemBuilder: (context, index) {
                final chat = filteredChats[index];
                final isGroupChat = chat.runtimeType.toString() == 'GroupChat';

                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.highlightColor,
                    child: Icon(
                      isGroupChat ? Icons.group : Icons.person,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  title: Text(isGroupChat ? chat.name : chat.userName),
                  subtitle: Text(chat.lastMessage),
                  trailing: Text(
                    _formatTimestamp(chat.lastMessageTimestamp),
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  onTap: () {
                    // Navigate to ChatDetailsPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatDetailsPage(chat: chat),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterButton(String label, String value, String currentFilter) {
    return GestureDetector(
      onTap: () {
        setState(() {
          filter = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        decoration: BoxDecoration(
          color: filter == value ? AppColors.primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.primaryColor),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: filter == value ? Colors.white : AppColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    if (now.difference(timestamp).inDays < 1) {
      return '${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}';
    }
    return '${timestamp.month}/${timestamp.day}/${timestamp.year}';
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
