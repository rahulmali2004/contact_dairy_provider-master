import 'dart:io';
import 'package:contact_dairy_provider/views/componets/add_contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_whatsapp/open_whatsapp.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../componets/my_back_button.dart';
import '../componets/themeicon.dart';

class contact_Detail_Page extends StatelessWidget {
  const contact_Detail_Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int index = ModalRoute.of(context)!.settings.arguments as int;
    Size s = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: const My_Back_Button(),
        title: Consumer<Add_Contact>(
          builder: (context, provider, child) => Text(
            provider.allContacts[index].name,
            style: TextStyle(fontSize: 20),
          ),
        ),
        actions: [
          Theme_Icon(),
          Consumer<Add_Contact>(
            builder: (context, provider, child) => PopupMenuButton(
              elevation: 5,
              offset: Offset(0, 50),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: Text("Delete"),
                    onTap: () {
                      provider.removeItem(index: index);
                      Navigator.pop(context);
                    },
                  ),
                  PopupMenuItem(
                    child: Text("Email"),
                    onTap: () async {
                      Uri mail = Uri(
                        scheme: 'mailto',
                        path: provider.allContacts[index].email,
                      );

                      await launchUrl(mail);
                    },
                  ),
                  PopupMenuItem(
                    child: Text("Share"),
                    onTap: () {
                      Share.shareXFiles(
                          [XFile(provider.allContacts[index].imagePath!)],
                          text:
                              "Name: ${provider.allContacts[index].name}\nContact: ${provider.allContacts[index].number}\nEmail: ${provider.allContacts[index].email}\n\nShared from ContactDiaryApp.");
                    },
                  ),
                ];
              },
            ),
          )
        ],
      ),
      body: Consumer<Add_Contact>(
        builder: (context, provider, child) => Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 50,
                foregroundImage: FileImage(
                  File(provider.allContacts[index].imagePath),
                ),
              ),
              SizedBox(
                height: s.height * 0.01,
              ),
              Text(
                "${provider.allContacts[index].name}",
                style: TextStyle(fontSize: 34),
              ),
              SizedBox(
                height: s.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "+91 ${provider.allContacts[index].number}",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Mobile | India",
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  Spacer(),
                  FloatingActionButton.small(
                    shape: CircleBorder(),
                    onPressed: () async {
                      FlutterPhoneDirectCaller.callNumber(
                          provider.allContacts[index].number!);
                    },
                    child: Icon(
                      Icons.call,
                      color: Colors.white,
                    ),
                    backgroundColor: Colors.green,
                  ),
                ],
              ),
              SizedBox(
                height: s.height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Message",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  FloatingActionButton.small(
                    shape: CircleBorder(),
                    onPressed: () async {
                      Uri sms = Uri(
                        scheme: 'sms',
                        path: provider.allContacts[index].number,
                      );

                      await launchUrl(sms);
                    },
                    child: Icon(
                      Icons.message,
                      color: Colors.white,
                    ),
                    backgroundColor: Colors.blue,
                  ),
                ],
              ),
              SizedBox(
                height: s.height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "WhatsApp",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  FloatingActionButton.small(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: () {
                      FlutterOpenWhatsapp.sendSingleMessage(
                          "${provider.allContacts[index].number}", "hello");
                    },
                    child: FaIcon(
                      FontAwesomeIcons.whatsapp,
                      color: Colors.white,
                    ),
                    backgroundColor: Colors.green,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
