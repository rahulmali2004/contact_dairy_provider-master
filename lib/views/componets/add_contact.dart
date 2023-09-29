import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../modals/contact_modals.dart';

class Add_Contact extends ChangeNotifier {
  File? image;
  SharedPreferences prefs;
  Add_Contact({required this.prefs});

  final String _contact_Name = "all_contact_names";
  final String _contact_Number = "all_contact_Number";
  final String _contact_Image = "all_contact_Image";
  final String _contact_email = "all_contact_email";

  List<String> _all_contact_Names = [];
  List<String> _all_contact_Numbers = [];
  List<String> _all_contact_Images = [];
  List<String> _all_contact_Email = [];

  List<Contact> allContacts = [];

  void My_Image({required File img}) {
    image = img;
    notifyListeners();
  }

  List<Contact> get getAllContacts {
    _all_contact_Names = prefs.getStringList(_contact_Name) ?? [];
    _all_contact_Numbers = prefs.getStringList(_contact_Number) ?? [];
    _all_contact_Images = prefs.getStringList(_contact_Image) ?? [];
    _all_contact_Email = prefs.getStringList(_contact_email) ?? [];

    allContacts = List.generate(
      _all_contact_Names.length,
      (index) => Contact(
        name: _all_contact_Names[index],
        number: _all_contact_Numbers[index],
        imagePath: _all_contact_Images[index],
        email: _all_contact_Email[index],
      ),
    );

    return allContacts;
  }

  void addContact(
      {required String name,
      required String number,
      required String imagePath,
      required email}) {
    _all_contact_Names = prefs.getStringList(_contact_Name) ?? [];
    _all_contact_Numbers = prefs.getStringList(_contact_Number) ?? [];
    _all_contact_Images = prefs.getStringList(_contact_Image) ?? [];
    _all_contact_Email = prefs.getStringList(_contact_email) ?? [];

    _all_contact_Names.add(name);
    _all_contact_Numbers.add(number);
    _all_contact_Images.add(imagePath);
    _all_contact_Email.add(email);

    prefs.setStringList(_contact_Name, _all_contact_Names);
    prefs.setStringList(_contact_Number, _all_contact_Numbers);
    prefs.setStringList(_contact_Image, _all_contact_Images);
    prefs.setStringList(_contact_email, _all_contact_Email);
    notifyListeners();
  }

  void removeItem({required int index}) {
    _all_contact_Names = prefs.getStringList(_contact_Name) ?? [];
    _all_contact_Numbers = prefs.getStringList(_contact_Number) ?? [];
    _all_contact_Images = prefs.getStringList(_contact_Image) ?? [];
    _all_contact_Email = prefs.getStringList(_contact_email) ?? [];

    _all_contact_Names.removeAt(index);
    _all_contact_Numbers.removeAt(index);
    _all_contact_Images.removeAt(index);
    _all_contact_Email.removeAt(index);

    prefs.setStringList(_contact_Name, _all_contact_Names);
    prefs.setStringList(_contact_Number, _all_contact_Numbers);
    prefs.setStringList(_contact_Image, _all_contact_Images);
    prefs.setStringList(_contact_email, _all_contact_Email);
    notifyListeners();
  }
}
