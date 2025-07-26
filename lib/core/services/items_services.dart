import 'package:cloud_firestore/cloud_firestore.dart';

class DataServices {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  getCategories() async {
    var collectionReference = firestore.collection('ListOfMenuItems');
    var querySnapshot = await collectionReference.get();
    return querySnapshot;
  }

  getCategoriesById(String id) async {
    var collectionReference = firestore.collection('ListOfMenuItems');
    var querySnapshot = await collectionReference.doc(id).get();
    return querySnapshot;
  }

 
}