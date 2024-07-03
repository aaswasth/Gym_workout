import 'package:capstone_project/bottom_navigation_pages/shopping_cart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TemplateList extends StatefulWidget {
  const TemplateList({Key? key}) : super(key: key);

  @override
  State<TemplateList> createState() => _TemplateListState();
}

enum ActiveSection { template, shoppingList }

class _TemplateListState extends State<TemplateList> {
  List<TemplateItem> templates = [];
  ActiveSection _activeSection = ActiveSection.template;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchData(); // Fetch data when returning to the screen
  }

  void _fetchData() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('templates').get();

      setState(() {
        templates.clear();
      });

      // Iterate over the documents in the snapshot and add them to the templates list
      for (QueryDocumentSnapshot doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        String id = doc.id;
        String name = data['name'] ?? '';
        String content = data['content'] ?? '';
        TemplateItem template =
            TemplateItem(id: id, name: name, content: content);

        setState(() {
          templates.add(template);
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          setState(() {
            _activeSection = ActiveSection.template;
          });
        },
        child: Container(
          color: Colors.black,
          child: SingleChildScrollView(
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 4,
              ),
              itemCount: templates.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.all(8),
                  child: TemplateCard(
                    templateItem: templates[index],
                    onUpdate: (updatedTemplate) {
                      setState(() {
                        templates[index] = updatedTemplate;
                      });
                    },
                    onDelete: () {
                      _deleteTemplate(index);
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddOptions(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _deleteTemplate(int index) {
    final String? docId = templates[index].id;

    if (docId != null) {
      FirebaseFirestore.instance
          .collection("templates")
          .doc(docId)
          .delete()
          .then((_) {
        setState(() {
          templates.removeAt(index);
        });
      }).catchError((error) {
        print("Error deleting data from Firestore: $error");
      });
    } else {
      print("Error: Document ID was null.");
    }
  }

  // void _deleteTemplate(int index) {
  //   templates.removeAt(index); // Remove the specific template
  // }

  void _showAddOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.note_add),
                title: const Text('Create New Template'),
                onTap: () {
                  Navigator.pop(context);
                  _createNewTemplate();
                },
              ),
              ListTile(
                leading: const Icon(Icons.format_list_bulleted),
                title: const Text('Create / Manage Lists'),
                onTap: () {
                  Navigator.pop(context);
                  _createNewList();
                },
              ),
              // ListTile(
              //   leading: const Icon(Icons.bookmark),
              //   title: const Text('View List'),
              //   onTap: () {
              //     Navigator.pop(context);
              //     _createNewList();
              //   },
              // ),
              // ListTile(
              //   leading: const Icon(Icons.lock),
              //   title: const Text('Private Templates'),
              //   onTap: () {
              //     Navigator.pop(context);
              //     // _createNewList();
              //   },
              // ),
            ],
          ),
        );
      },
    );
  }

  void _createNewTemplate() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userId = user.email;
      final newTemplateName = "New Template";
      final newTemplateContent = "";

      FirebaseFirestore.instance.collection("templates").add({
        'content': newTemplateContent,
        'name': newTemplateName,
        'userEmail': userId,
        'timestamp': FieldValue.serverTimestamp(),
      }).then((DocumentReference docRef) {
        setState(() {
          templates.add(TemplateItem(
            id: docRef.id,
            name: newTemplateName,
            content: newTemplateContent,
          ));
        });
      }).catchError((error) {
        print("Error adding template to Firestore: $error");
      });
    }
  }

  void _createNewList() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ShoppingList()),
    );
  }
}

class TemplateItem {
  String id;
  String name;
  String content;

  TemplateItem({
    required this.id,
    required this.name,
    required this.content,
  });
}

class TemplateCard extends StatelessWidget {
  final TemplateItem templateItem;
  final Function(TemplateItem) onUpdate;
  final VoidCallback onDelete;

  const TemplateCard({
    Key? key,
    required this.templateItem,
    required this.onUpdate,
    required this.onDelete,
  }) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[850],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextField(
                    controller: TextEditingController(text: templateItem.name),
                    maxLines: 1,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Template Name',
                      labelStyle: const TextStyle(color: Colors.redAccent),
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                    ],
                    onSubmitted: (value) {
                      final updatedTemplate = TemplateItem(
                        id: templateItem.id,
                        name: value,
                        content: templateItem.content,
                      );
                      onUpdate(updatedTemplate);
                      _updateTemplate(updatedTemplate);
                    },
                    textInputAction: TextInputAction.done,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _showDeleteConfirmation(context),
                ),
              ],
            ),
            TextField(
              controller: TextEditingController(text: templateItem.content),
              minLines: 1,
              maxLines: 4,
              style: const TextStyle(fontSize: 18, color: Colors.white),
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'Template Content',
                labelStyle: const TextStyle(color: Colors.redAccent),
              ),
              onSubmitted: (value) {
                final updatedTemplate = TemplateItem(
                  id: templateItem.id,
                  name: templateItem.name,
                  content: value,
                );
                onUpdate(updatedTemplate);
                _updateTemplate(updatedTemplate);
              },
              textInputAction: TextInputAction.done,
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: const Text(
            'Confirm Delete',
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            'Are you sure you want to delete this template?',
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            TextButton(
              onPressed: () {
                onDelete();
                Navigator.of(context).pop();
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  void _updateTemplate(TemplateItem template) {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userId = user.email;
      FirebaseFirestore.instance
          .collection("templates")
          .doc(template.id)
          .update({
        'name': template.name,
        'content': template.content,
        'userEmail': userId,
        'timestamp': FieldValue.serverTimestamp(),
      }).catchError((error) {
        print("Error updating template in Firestore: $error");
      });
    }
  }
}

void main() {
  bool useTemplateList = true;

  runApp(MaterialApp(
    // ignore: dead_code
    home: useTemplateList ? const TemplateList() : const ShoppingList(),
  ));
}
