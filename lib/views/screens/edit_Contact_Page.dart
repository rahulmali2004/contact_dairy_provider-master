import 'dart:io';
import 'package:contact_dairy_provider/views/componets/add_contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../componets/themeicon.dart';

class edit_Contact_Page extends StatelessWidget {
  edit_Contact_Page({Key? key}) : super(key: key);

  @override
  ImagePicker picker = ImagePicker();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    int index = ModalRoute.of(context)!.settings.arguments as int;
    Size s = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("edit_Contact_Page"),
        actions: [
          Theme_Icon(),
          SizedBox(
            width: s.width * 0.02,
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.done),
          ),
          SizedBox(
            width: s.width * 0.03,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Consumer<Add_Contact>(
          builder: (context, provider, widget) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.grey,
                          foregroundImage: provider?.image != null
                              ? FileImage(provider?.image! as File)
                              : null,
                          child: const Text(
                            "Add",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        FloatingActionButton.small(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => Theme(
                                data: ThemeData(useMaterial3: true),
                                child: AlertDialog(
                                  title: const Text("Select the method"),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        XFile? img = await picker.pickImage(
                                            source: ImageSource.camera);

                                        if (img != null) {
                                          provider.My_Image(
                                              img: File(img.path));
                                        }
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Camera"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        ImagePicker picker = ImagePicker();

                                        XFile? img = await picker.pickImage(
                                            source: ImageSource.gallery);

                                        if (img != null) {
                                          provider.My_Image(
                                              img: File(img.path));
                                        }
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Gallery"),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: s.height * 0.03,
                  ),
                  Text(
                    "Name",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: s.height * 0.01,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    initialValue: provider.allContacts[index].name,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please Enter The Name!!";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (val) {
                      provider.allContacts[index].name = val!;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter Your Name",
                      label: Text("Full Name"),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: s.height * 0.03,
                  ),
                  Text(
                    "Mobile Number",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: s.height * 0.01,
                  ),
                  TextFormField(
                    maxLength: 10,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    initialValue: provider.allContacts[index].number,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please Enter Mobile Number!!";
                      } else if (val!.length < 10) {
                        return "Contact number must have 10 digits...";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (val) {
                      provider.allContacts[index].number = val!;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter Your Mobile no",
                      label: Text("Mobile no"),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: s.height * 0.01,
                  ),
                  Text(
                    "Email Addrees",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: s.height * 0.01,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    initialValue: provider.allContacts[index].email,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please Enter The Email ID!!";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (val) {
                      provider.allContacts[index].email = val!;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter Your Email ID",
                      label: Text("Email ID"),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
