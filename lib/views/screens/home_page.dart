import 'dart:io';
import 'package:contact_dairy_provider/utild/routes.dart';
import 'package:contact_dairy_provider/views/componets/add_contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import '../componets/my_back_button.dart';
import '../componets/themeicon.dart';

class home_page extends StatelessWidget {
  const home_page({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Contacts",
          style: TextStyle(fontSize: 20),
        ),
        actions: const [
          Theme_Icon(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Consumer<Add_Contact>(
          builder: (context, provider, child) =>
              provider.getAllContacts.isNotEmpty
                  ? ListView.builder(
                      itemCount: provider.getAllContacts.length,
                      itemBuilder: (context, index) => Slidable(
                        closeOnScroll: true,
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (val) {
                                Navigator.of(context).pushNamed(
                                    MyRoutes.edit_Contact_Page,
                                    arguments: index);
                              },
                              icon: Icons.edit,
                              backgroundColor: Colors.green,
                            ),
                            SlidableAction(
                              onPressed: (val) {
                                provider.removeItem(index: index);
                              },
                              icon: Icons.delete,
                              backgroundColor: Colors.red,
                            ),
                          ],
                        ),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              foregroundImage: FileImage(
                                File(provider.allContacts[index].imagePath),
                              ),
                            ),
                            title: Text(provider.allContacts[index].name),
                            subtitle: Text(provider.allContacts[index].number),
                            trailing: IconButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                    MyRoutes.contact_Detail_Page,
                                    arguments: index);
                              },
                              icon: Icon(Icons.arrow_forward_ios),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Spacer(),
                            Image.asset(
                              "assets/images/box.png",
                              height: 150,
                              color: Colors.grey.shade400,
                            ),
                            const Text(
                              "You have no Contact!!",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(
                              flex: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(MyRoutes.Add_Contact_Page);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: Colors.teal,
      ),
    );
  }
}
