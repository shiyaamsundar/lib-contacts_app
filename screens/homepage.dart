import 'package:flutter/material.dart';

import 'viewcontact.dart';
import 'addcontact.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();

  navigatetiaddscreen() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Add_contact();
    }));
  }

  navigatetiviewscreen(id) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return View_contact( id);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        child: FirebaseAnimatedList(
          query: _databaseReference,
          itemBuilder: (BuildContext context,DataSnapshot snapShot,
              Animation<double> animation, int index) {
            return GestureDetector(
              onTap: () {
                navigatetiviewscreen(snapShot.value['id']);
              },
              child: Card(
                color: Colors.white,
                elevation: 2,
                margin: EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover, image:AssetImage('assets/mascot.png')
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                              '${snapShot.value['firstname']}${snapShot.value['firstname']}'.toUpperCase(),style: TextStyle(fontWeight: FontWeight.bold),),
                          Text(
                              '${snapShot.value['phone']}'.toString(),style: TextStyle(fontWeight: FontWeight.bold),),

                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigatetiaddscreen,
        child: Icon(Icons.add),
      ),
    );
  }
}
