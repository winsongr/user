import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user/global/global.dart';
import 'package:user/mainScreens/home_screen.dart';
import 'package:user/widgets/cus_textfield.dart';
import 'package:user/widgets/error_dialog.dart';
import 'package:user/widgets/loading_dialog.dart';
import 'package:firebase_storage/firebase_storage.dart' as fstorage;
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  XFile? imageXfile;

  final ImagePicker _picker = ImagePicker();
  _getImage() async {
    imageXfile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageXfile;
    });
  }

  String userImageUrl = "";
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  formValidation() async {
    if (imageXfile == null) {
      showDialog(
          context: context,
          builder: (c) {
            return const ErrorDialog(
              message: "select an image",
            );
          });
    } else {
      if (passwordController.text == confirmPasswordController.text) {
        if (confirmPasswordController.text.isNotEmpty &&
            emailController.text.isNotEmpty &&
            nameController.text.isNotEmpty ) {
          showDialog(
              context: context,
              builder: (c) {
                return const LoadingDialog(message: "Registering Account");
              });
          String fileName = DateTime.now().millisecondsSinceEpoch.toString();
          fstorage.Reference reference = fstorage.FirebaseStorage.instance
              .ref()
              .child("users")
              .child(fileName);
          fstorage.UploadTask uploadTask =
              reference.putFile(File(imageXfile!.path));
          fstorage.TaskSnapshot taskSnapshot =
              await uploadTask.whenComplete(() => {});
          await taskSnapshot.ref.getDownloadURL().then((url) {
            userImageUrl = url;

            //save to firebase
            authenticateuserAndSignUp();
          });
        } else {
          showDialog(
              context: context,
              builder: (c) {
                return const ErrorDialog(
                  message: "fill required fields",
                );
              });
        }
      } else {
        showDialog(
            context: context,
            builder: (c) {
              return const ErrorDialog(
                message: "Password not matching",
              );
            });
      }
    }
  }

  void authenticateuserAndSignUp() async {
    User? currentUser;
    await firebaseAuth
        .createUserWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    )
        .then((auth) {
      currentUser = auth.user;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(
              message: error.message.toString(),
            );
          });
    });
    if (currentUser != null) {
      saveDataToFirestore(currentUser!).then((value) {
        Navigator.pop(context);
        Route newRoute =
            MaterialPageRoute(builder: ((context) => const HomeScreen()));
        Navigator.pushReplacement(context, newRoute);
      });
    }
  }

  Future saveDataToFirestore(User currentUser) async {
    FirebaseFirestore.instance.collection("users").doc(currentUser.uid).set({
      "userUid": currentUser.uid,
      "userEmail": currentUser.email,
      "userName": nameController.text.trim(),
      "photoUrl": userImageUrl,
      "status": "approved",

    });
    //save locally
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.setString("userUid", currentUser.uid);
    await sharedPreferences!.setString("userName", nameController.text.trim());
    await sharedPreferences!.setString("userEmail", currentUser.email.toString());
    await sharedPreferences!.setString("photoUrl", userImageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              _getImage();
            },
            child: CircleAvatar(
              radius: MediaQuery.of(context).size.width * 0.20,
              backgroundColor: Colors.white,
              backgroundImage: imageXfile == null
                  ? null
                  : FileImage(File(imageXfile!.path)),
              child: imageXfile == null
                  ? Icon(
                      Icons.add_photo_alternate,
                      size: MediaQuery.of(context).size.width * 0.20,
                      color: Colors.grey,
                    )
                  : null,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    isObsecre: false,
                    data: Icons.person,
                    controller: nameController,
                    hintText: "Name",
                  ),
                  CustomTextField(
                    isObsecre: false,
                    data: Icons.email,
                    controller: emailController,
                    hintText: "Email",
                  ),
                  CustomTextField(
                    isObsecre: true,
                    data: Icons.lock,
                    controller: passwordController,
                    hintText: "Password",
                  ),
                  CustomTextField(
                    isObsecre: true,
                    data: Icons.lock,
                    controller: confirmPasswordController,
                    hintText: "confirm password",
                  ),
                ],
              )),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              formValidation();
            },
            child: const Text(
              "Sign Up ",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              padding:
                  const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            ),
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
