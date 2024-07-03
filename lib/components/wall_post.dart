import 'package:flutter/material.dart';

class WallPost extends StatelessWidget {
  final String user;
  final String message;
  final bool isCurrentUser;
  // final String name;

  const WallPost(
      {Key? key,
      required this.user,
      required this.message,
      required this.isCurrentUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color textColor =
        isCurrentUser ? Colors.lightBlue[400]! : Colors.white;
    final Color messageColor =
        isCurrentUser ? Colors.lightBlue[400]! : Colors.white70;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            user,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            message,
            style: TextStyle(
              fontSize: 14.0,
              color: messageColor,
            ),
          ),
        ],
      ),
    );
  }
}

  // @override
  // Widget build(BuildContext context) {
  //   return Row(
  //     children: [
  //       Column(
  //         children: [
  //           // Text('this is where the posts are'),
  //           Text(user),
  //           Text(message),
  //         ],
  //       )
  //     ],
  //   );
  // }
