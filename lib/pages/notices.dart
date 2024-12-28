import 'package:flutter/material.dart';
import 'package:flutter_author_reader_app/core/app_colors.dart';
import 'package:flutter_author_reader_app/providers/user_provider.dart';
import 'package:flutter_author_reader_app/providers/follow_provider.dart';
import 'package:provider/provider.dart';

class NoticesPage extends StatefulWidget {
  const NoticesPage({super.key});

  @override
  State<NoticesPage> createState() => _NoticesPageState();
}

class _NoticesPageState extends State<NoticesPage> {
  @override
  Widget build(BuildContext context) {
    var followProvider = Provider.of<FollowProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    userProvider.fetchCurrentUser();
    var currentUser = userProvider.currentUser;

    // Null check for currentUser.id
    if (currentUser == null) {
      return Scaffold(
        body: Center(
            child: Text("User is not authenticated.",
              style: TextStyle(
                  color: AppColors.primaryColor
              ),
            )
        ),
        backgroundColor: AppColors.backgroundColor,
      );
    }

    followProvider.fetchFollowRequests(currentUser.id);

    if (followProvider.followRequests.length == 0)  {
      return Scaffold(
        body: Center(
            child: Text("There is no new follow requests.",
              style: TextStyle(
                color: AppColors.primaryColor
              ),
            )
        ),
        backgroundColor: AppColors.backgroundColor,
      );
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: ListView.builder( //REQUESTS WILL SHOW UP WHEN THEY ACQUIRED HERE
        itemCount: followProvider.followRequests.length,
        itemBuilder: (context, index) {
          final followRequest = followProvider.followRequests[index];
          return ListTile(
            title: Text('Follow request from ${followRequest.userId}'),
            subtitle: Text('Requested at: ${followRequest.requestedAt}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () {
                    followProvider.acceptFollowRequest(currentUser.id!, followRequest.userId);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    followProvider.rejectFollowRequest(currentUser.id!, followRequest.userId);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
