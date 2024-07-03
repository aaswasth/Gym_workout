import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: duplicate_import
import 'package:image_cropper/image_cropper.dart'; // For customizing system UI overlay styles
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _selectedImage;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final currentUser = FirebaseAuth.instance.currentUser;
  XFile? _imageFile;

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchUserProfile();
  }

  Future<void> _pickImageFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );

      try {
        CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: pickedFile.path,
        );
        if (croppedFile != null) {
          setState(() {
            _selectedImage = File(croppedFile.path);
          });
        }
      } catch (e) {
        print("Cropping failed: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildGlowingTitle(),
              const SizedBox(height: 20.0),
              Center(
                child: Stack(
                  children: [
                    // CircleAvatar(
                    //   radius: 50,
                    //   backgroundColor: Colors.grey[850],
                    //   // Use FileImage to load the image from a File
                    //   backgroundImage: _selectedImage != null
                    //       ? FileImage(_selectedImage!)
                    //       : null,
                    //   child: _selectedImage == null
                    //       ? Icon(Icons.person,
                    //           size: 50,
                    //           color: Colors.grey[500]) // Fallback icon
                    //       : null, // If _selectedImage is not null, the backgroundImage will be used
                    // ),
                    // Positioned(
                    //   bottom: 0,
                    //   right: 0,
                    //   child: IconButton(
                    //     onPressed: _pickImageFromGallery, // Open image picker
                    //     icon: Icon(
                    //       Icons.camera_alt,
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              // _selectedImage != null
              //     ? Image.file(_selectedImage!)
              //     : const Text("Please select and image"),
              const SizedBox(height: 20.0),
              buildTextField(nameController, 'Name'),
              buildTextField(ageController, 'Age', isNumeric: true),
              buildTextField(weightController, 'Weight (lbs)', isNumeric: true),
              buildTextField(heightController, 'Height (cms)', isNumeric: true),
              buildTextField(genderController, 'Sex'),
              const SizedBox(height: 20.0),
              Center(
                child: ElevatedButton(
                  onPressed: _saveProfile,
                  child: const Text('Save Profile'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.greenAccent[400],
                    onPrimary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGlowingTitle() {
    return Center(
      child: ShaderMask(
        shaderCallback: (bounds) => const RadialGradient(
          center: Alignment.center,
          radius: 10,
          colors: [Colors.white, Colors.transparent],
          tileMode: TileMode.mirror,
        ).createShader(bounds),
        child: const Text(
          'Profile Page',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                blurRadius: 5.0,
                color: Colors.blue,
                offset: Offset(0, 0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String label,
      {bool isNumeric = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(15.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.greenAccent),
            borderRadius: BorderRadius.circular(15.0),
          ),
          filled: true,
          fillColor: Colors.grey[850],
        ),
        keyboardType: isNumeric
            ? TextInputType.numberWithOptions(decimal: true)
            : TextInputType.text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Future<void> _saveProfile() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      final String userId = user.email ?? "";
      int age = int.tryParse(ageController.text) ?? 0;
      double weight = double.tryParse(weightController.text) ?? 0.0;
      double height = double.tryParse(heightController.text) ?? 0.0;
      String gender = genderController.text;

      final UserProfile profile = UserProfile(
        userEmail: currentUser?.email ?? 'Anonymous',
        name: nameController.text,
        age: age,
        weight: weight,
        height: height,
        gender: gender,
      );

      final Map<String, dynamic> profileMap = profile.toMap();

      await FirebaseFirestore.instance
          .collection('profiles')
          .doc(userId)
          .set(profileMap);

      print("Profile saved successfully.");
    }
  }

  void fetchUserProfile() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userId = user.email;

      FirebaseFirestore.instance
          .collection("profiles")
          .doc(userId)
          .get()
          .then((docSnapshot) {
        if (docSnapshot.exists) {
          final userData = docSnapshot.data() as Map<String, dynamic>;

          setState(() {
            nameController.text = userData['name'] ?? '';
            ageController.text = (userData['age'] ?? '0').toString();
            weightController.text = (userData['weight'] ?? '0.0').toString();
            heightController.text = (userData['height'] ?? '0.0').toString();
            genderController.text = userData['gender'] ?? '';
          });
        } else {
          print("User profile not found in Firestore.");
        }
      }).catchError((error) {
        print("Error retrieving user profile data from Firestore: $error");
      });
    }
  }
}

class UserProfile {
  final String userEmail;
  final String name;
  final int age;
  final double weight;
  final double height;
  final String gender;

  UserProfile({
    required this.userEmail,
    required this.name,
    required this.age,
    required this.weight,
    required this.height,
    required this.gender,
  });

  Map<String, dynamic> toMap() {
    return {
      'UserEmail': userEmail,
      'name': name,
      'age': age,
      'weight': weight,
      'height': height,
      'gender': gender,
    };
  }
}
