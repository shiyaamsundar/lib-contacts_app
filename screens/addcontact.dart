import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import '../model/contact.dart';
import 'package:path/path.dart';

class Add_contact extends StatefulWidget {
  @override
  _Add_contactState createState() => _Add_contactState();
}

class _Add_contactState extends State<Add_contact> {
  DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();

  String _firstname = "empty",
      _lastname = "empty",
      _phone = "empty",
      _address = "empty",
      _email = "empty",
      _photourl = "empty";

  savecontact(BuildContext context) async {
    if (_firstname.isNotEmpty &&
        _lastname.isNotEmpty &&
        _phone.isNotEmpty &&
        _email.isNotEmpty &&
        _address.isNotEmpty &&
        _photourl.isNotEmpty) {
      Contact contact = Contact(this._firstname, this._lastname, this._phone,
          this._email, this._address, this._photourl);
      await _databaseReference.push().set(contact.toJson());
      navigatetolastscreen(context);
    }
    else {
      showDialog(context: context, builder: (context) {
        return AlertDialog(title: Text('Field Required'),
          content: Text('All fields are required'),
          actions: <Widget>[
            FlatButton(onPressed: () {
              Navigator.of(context).pop();
            }, child: Text('Closed'))
          ],);
      });
    }
  }

  navigatetolastscreen(context) {
    Navigator.of(context).pop();
  }

  Future pickimage() async {
    File file = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 200, maxWidth: 200,
    );
    String filename = basename(file.path);
    uploadimage(file, filename);
  }

  void uploadimage(File file, String filename) async {
    StorageReference storageReference = FirebaseStorage.instance.ref().child(
        filename);

    storageReference
        .putFile(file)
        .onComplete
        .then((firebasefile) async {
      var downloadurl = await firebasefile.ref.getDownloadURL();

      setState(() {
        _photourl = downloadurl;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Addcontact'),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10),
                child: GestureDetector(
                  onTap: () {
                    this.pickimage();
                  },
                  child: Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover, image: _photourl == 'empty'
                              ? AssetImage('assets/mascot.png')
                              : NetworkImage(_photourl),
                          )
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _firstname = value;
                    });
                  },
                  decoration: InputDecoration(
                      labelText: 'FirstName',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),

                      )
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _lastname = value;
                    });
                  },
                  decoration: InputDecoration(
                      labelText: 'LastName',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),

                      )
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _phone = value;
                    });
                  },
                  decoration: InputDecoration(
                      labelText: 'Phone',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),

                      )
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _email = value;
                    });
                  },
                  decoration: InputDecoration(
                      labelText: 'Email', hintText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),

                      )

                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _address = value;
                    });
                  },
                  decoration: InputDecoration(
                      labelText: 'Address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),

                      )
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                child: RaisedButton(
                  padding: EdgeInsets.fromLTRB(100, 5, 100, 10),
                  onPressed: () {
                    savecontact(context);
                  },
                  color: Colors.black,
                  child: Text('Save', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),

              )
            ],
          ),
        ),
      ),
    );
  }
}
