import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../componets/add_contact.dart';
import '../componets/my_back_button.dart';
import '../componets/themeicon.dart';

class Add_Contact_Page extends StatelessWidget {
  Add_Contact_Page({Key? key}) : super(key: key);
  String? _name;
  String? _phone_number;
  String? _email_id;
  ImagePicker picker = ImagePicker();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: My_Back_Button(),
        title: Text(
          "Add Conatact",
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          Theme_Icon(),
          SizedBox(
            width: s.width * 0.02,
          ),
          IconButton(
            onPressed: () async {
              Directory? dir = await getExternalStorageDirectory();
              File nImage =
                  await Provider.of<Add_Contact>(context, listen: false)
                      .image!
                      .copy("${dir!.path}/${_name}.jpg");
              if (formkey.currentState!.validate()) {
                formkey.currentState!.save();
                Provider.of<Add_Contact>(context, listen: false).addContact(
                    name: _name!,
                    number: _phone_number!,
                    imagePath: nImage.path,
                    email: _email_id!);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text("Contact added"),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 2),
                  ),
                );
                Navigator.of(context).pop();
              } else {
                SnackBar(
                  content: const Text("Failed!!"),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 2),
                );
              }
            },
            icon: Icon(Icons.done),
          ),
          SizedBox(
            width: s.width * 0.03,
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Consumer<Add_Contact>(
              builder: (context, provider, child) => Form(
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
                                              XFile? img =
                                                  await picker.pickImage(
                                                      source:
                                                          ImageSource.camera);

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
                                              ImagePicker picker =
                                                  ImagePicker();

                                              XFile? img =
                                                  await picker.pickImage(
                                                      source:
                                                          ImageSource.gallery);

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
                          initialValue: _name,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please Enter The Name!!";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (val) {
                            _name = val;
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
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                          initialValue: _phone_number,
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
                            _phone_number = val;
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
                          initialValue: _email_id,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please Enter The Email ID!!";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (val) {
                            _email_id = val;
                          },
                          decoration: InputDecoration(
                            hintText: "Enter Your Email ID",
                            label: Text("Email ID"),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  )),
        ),
      ),
    );
  }
}
