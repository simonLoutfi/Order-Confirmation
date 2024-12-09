import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proto/model/user_model.dart';
import 'dart:developer' as developer;

class User {
  User._privateConstructor();
  static final User instance = User._privateConstructor();

  final _db = FirebaseFirestore.instance;
  static String userId='';

  createUser(UserModel user) async{
    CollectionReference coll = _db.collection("Users");
    userId = coll.doc().id;
    await coll.doc(userId).set(user.toJson())
    .then((k)=>developer.log("User added successfully"))
    .catchError((error) {
      developer.log('Error creating document: $error');
    });
  }

  addPhoneUser(String phone) async{
    CollectionReference coll = _db.collection("Users");
    if(userId.isNotEmpty){
      await coll.doc(userId).set(
      {"phone number":phone},
      SetOptions(merge: true)
      )
      .then((k)=>developer.log("Phone added successfully"))
      .catchError((error) {
        developer.log('Error creating document: $error');
      });
    }
    
  }

Future<bool> getLock() async {
  CollectionReference coll = _db.collection("Users");
  if (userId.isEmpty) {
    return true;
  }

  try {
    DocumentSnapshot doc = await coll.doc(userId).get();
    if (doc.exists) {
      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
      
      if (data != null && data.containsKey("locked")) {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  } catch (e) {
    return true;
  }
}

Future<bool> getPhone() async {
  CollectionReference coll = _db.collection("Users");

  if (userId.isEmpty) {
    return false;
  }

  try {
    DocumentSnapshot doc = await coll.doc(userId).get();
    if (doc.exists) {
      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
      if (data != null && data.containsKey("phone number")) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  } catch (e) {
    return false; 
  }
}

Future<bool> getName() async {
  CollectionReference coll = _db.collection("Users");

  if (userId.isEmpty) {
    return false;
  }

  try {
    DocumentSnapshot doc = await coll.doc(userId).get();
    if (doc.exists) {
      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
      
      if (data != null && data.containsKey("name")) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  } catch (e) {
    return false; 
  }
}

  setLock() async{
    CollectionReference coll = _db.collection("Users");
    if (userId.isEmpty) {
      return false;
    }

    await coll.doc(userId).set(
      {"locked":1},
      SetOptions(merge: true)
    )
    .then((k)=>developer.log("locked added successfully"))
    .catchError((error) {
      developer.log('Error creating document: $error');
    });
  }

    setRate(double rating, String feedback) async{
      CollectionReference coll = _db.collection("Users");
      await coll.doc(userId).set(
        {
          "rating":rating,
          "feedback":feedback,
        },
        SetOptions(merge: true)
      )
      .then((k)=>developer.log("locked added successfully"))
      .catchError((error) {
        developer.log('Error creating document: $error');
      });
    }

    Future<double> getRating() async {
      CollectionReference coll = _db.collection("Users");
      DocumentSnapshot doc = await coll.doc(userId).get();
      if (doc.exists) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
        if (data != null && data.containsKey("rating")) {
          return data['rating'];
        } else {
          return 0;
        }
      } else {
        return 0;
      }
      
    }

    Future<String> getFeedback() async {
      CollectionReference coll = _db.collection("Users");
      DocumentSnapshot doc = await coll.doc(userId).get();
      if (doc.exists) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
        if (data != null && data.containsKey("feedback")) {
          return data['feedback'];
        } else {
          return '';
        }
      } else {
        return '';
      }
      
    }
}