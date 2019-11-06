import 'package:firebase_database/firebase_database.dart';

class Contact{
  String _id;
  String _firstname;
  String _lastName,_phone,_email,_address,_photourl;

  Contact(this._firstname,this._lastName,this._phone,this._email,this._address,this._photourl);
  Contact.withId(this._id,this._firstname,this._lastName,this._phone,this._email,this._address,this._photourl);
String get id=>this._id;
  String get firstname=>this._firstname;
  String get lastname=>this._lastName;
  String get photourl=>this._photourl;
  String get phone=>this._phone;
  String get address=>this._address;
  String get email=>this._email;

  set firstname(String firstname) {
    this._firstname=firstname;
  }
  set lastname(String lastname) {
    this._lastName=lastname;
  }
  set phone(String phone) {
    this._phone=phone;
  }
  set photourl(String photourl) {
    this._photourl=photourl;
  }
  set address(String address) {
    this._address=address;
  }
  set email(String email) {
    this._email=email;
  }

Contact.fromSnapshot(DataSnapshot snapshot)
{
  this._id=snapshot.key;
  this._firstname=snapshot.value['firstname'];
  this._lastName=snapshot.value['lastname'];
  this._phone=snapshot.value['phone'];
  this._address=snapshot.value['address'];
  this._email=snapshot.value['email'];
  this._photourl=snapshot.value['photourl'];
}
  Map<String,dynamic> toJson(){
    return {
      'firstname':_firstname,
      'lastname':_lastName,
      'phone':_phone,
      'email':_email,
      'address':_address,
      'photourl':_photourl,
    };
  }

}