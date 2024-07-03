import 'package:capstone_project/bottom_navigation_pages/temp_list.dart';
import 'package:capstone_project/bottom_navigation_pages/workout_screen.dart';
import 'package:capstone_project/components/text_field.dart';
import 'package:capstone_project/components/wall_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  int _currentIndex = 0;

  final currentUser = FirebaseAuth.instance.currentUser;
  final textController = TextEditingController();

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  void postMessage() {
    if (textController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection("User Posts").add({
        'UserEmail': currentUser?.email ?? 'Anonymous',
        'Message': textController.text,
        'TimeStamp': Timestamp.now(),
      });
      textController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'ACHIEVABLE',
          style: TextStyle(color: Colors.white, fontSize: 35),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        actions: [
          // IconButton(
          //   onPressed: signOut,
          //   icon: const Icon(Icons.logout),
          // )
        ],
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildBodyContent(),
          ),
          if (_currentIndex == 0)
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                children: [
                  Expanded(
                    child: MyTextField(
                      controller: textController,
                      hintText: 'Text',
                      obscureText: false,
                    ),
                  ),
                  IconButton(
                    onPressed: postMessage,
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          Text("Logging in as ${currentUser?.email ?? 'Anonymous'}"),
        ],
      ),
    );
  }

  Widget _buildBodyContent() {
    switch (_currentIndex) {
      case 0:
        return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("User Posts")
              .orderBy(
                "TimeStamp",
                descending: true,
              )
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                reverse: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final post = snapshot.data!.docs[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: WallPost(
                      user: post['UserEmail'],
                      message: post['Message'],
                      isCurrentUser: currentUser?.email == post['UserEmail'],
                      // name: post['Name'],
                      // timestamp: post['TimeStamp'].toDate(),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        );
      case 1:
        return const WorkoutScreen();
      case 2:
        return const TemplateList();
      default:
        return Container();
    }
  }
}
