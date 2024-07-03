import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({Key? key}) : super(key: key);

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _containerNameController =
      TextEditingController();
  String? _selectedContainerId;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Your Shopping List',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        // backgroundColor: Colors.grey[900],
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _containerNameController,
                    decoration: InputDecoration(
                      hintText: 'Enter container name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _createContainer,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    onPrimary: Colors.white,
                  ),
                  child: const Text('Create'),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('containers')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final container = snapshot.data!.docs[index];
                    return ContainerTile(
                      containerName: container['name'],
                      containerId: container.id,
                      onTap: () {
                        setState(() {
                          _selectedContainerId = container.id;
                        });
                      },
                      addItem: _addItem,
                      textEditingController: _textEditingController,
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

  void _createContainer() {
    final containerName = _containerNameController.text.trim();
    if (containerName.isNotEmpty) {
      FirebaseFirestore.instance.collection('containers').add({
        'name': containerName,
      }).then((value) {
        setState(() {
          _selectedContainerId = value.id;
        });
      });
      _containerNameController.clear();
    }
  }

  void _addItem(String newItem) {
    if (newItem.isNotEmpty && _selectedContainerId != null) {
      FirebaseFirestore.instance
          .collection('containers')
          .doc(_selectedContainerId)
          .collection('items')
          .add({
        'name': newItem,
        'completed': false,
      });
      _textEditingController.clear();
    }
  }
}

class ContainerTile extends StatelessWidget {
  final String containerName;
  final String containerId;
  final VoidCallback onTap;
  final Function(String) addItem;
  final TextEditingController textEditingController;

  const ContainerTile({
    required this.containerName,
    required this.containerId,
    required this.onTap,
    required this.addItem,
    required this.textEditingController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(containerName,
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteContainer(context, containerId),
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                  hintText: 'Enter item name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
                onSubmitted: addItem,
              ),
              trailing: IconButton(
                icon: const Icon(Icons.add, color: Colors.deepPurple),
                onPressed: () => addItem(textEditingController.text.trim()),
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('containers')
                .doc(containerId)
                .collection('items')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final items = snapshot.data!.docs;
              return Column(
                children: items.map<Widget>((item) {
                  final itemName = item['name'];
                  final bool completed = (item.data() as Map<String, dynamic>)
                          .containsKey('completed')
                      ? item['completed']
                      : false;

                  return ListTile(
                    title: Text(itemName),
                    leading: Checkbox(
                      value: completed,
                      onChanged: (bool? value) {
                        FirebaseFirestore.instance
                            .collection('containers')
                            .doc(containerId)
                            .collection('items')
                            .doc(item.id)
                            .update({'completed': value});
                      },
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection('containers')
                            .doc(containerId)
                            .collection('items')
                            .doc(item.id)
                            .delete();
                      },
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
        onExpansionChanged: (expanded) {
          if (expanded) {
            onTap();
          }
        },
      ),
    );
  }

  void _deleteContainer(BuildContext context, String containerId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm"),
          content: Text("Are you sure you want to delete this container?"),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Delete", style: TextStyle(color: Colors.red)),
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('containers')
                    .doc(containerId)
                    .delete()
                    .then((_) {
                  print("Container deleted successfully");
                  Navigator.of(context).pop();
                }).catchError((error) {
                  print("Failed to delete container: $error");
                  Navigator.of(context).pop();
                });
              },
            ),
          ],
        );
      },
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: ShoppingList(),
  ));
}
