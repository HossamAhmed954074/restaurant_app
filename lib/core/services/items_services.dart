import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataServices {
  static const String _collectionName = 'ListOfMenuItems';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

 
  CollectionReference<Map<String, dynamic>> get _menuItemsCollection =>
      _firestore.collection(_collectionName);

 
  Future<QuerySnapshot<Map<String, dynamic>>> getCategories() async {
    try {
      log('Fetching all categories', name: 'DataServices');
      return await _menuItemsCollection.get();
    } on FirebaseException catch (e) {
      log(
        'Firebase error fetching categories: ${e.message}',
        name: 'DataServices',
      );
      rethrow;
    } catch (e) {
      log('Unexpected error fetching categories: $e', name: 'DataServices');
      rethrow;
    }
  }


  Future<DocumentSnapshot<Map<String, dynamic>>> getCategoriesById(
    String id,
  ) async {
    try {
      if (id.trim().isEmpty) {
        throw ArgumentError('Category ID cannot be empty');
      }

      log('Fetching category with ID: $id', name: 'DataServices');
      return await _menuItemsCollection.doc(id).get();
    } on FirebaseException catch (e) {
      log(
        'Firebase error fetching category $id: ${e.message}',
        name: 'DataServices',
      );
      rethrow;
    } catch (e) {
      log('Unexpected error fetching category $id: $e', name: 'DataServices');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getShuffledItems() async {
    try {
      log('Fetching and shuffling all menu items', name: 'DataServices');

      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _menuItemsCollection.get();

      if (querySnapshot.docs.isEmpty) {
        log('No menu items found', name: 'DataServices');
        return <Map<String, dynamic>>[];
      }

      final List<Map<String, dynamic>> items = <Map<String, dynamic>>[];

      for (final QueryDocumentSnapshot<Map<String, dynamic>> doc
          in querySnapshot.docs) {
        final Map<String, dynamic>? data = doc.data();
        if (data != null) {
          items.add(data);
        } else {
          log('Null data found for document: ${doc.id}', name: 'DataServices');
        }
      }

      items.shuffle();
      log(
        'Successfully shuffled ${items.length} menu items',
        name: 'DataServices',
      );
      return items;
    } on FirebaseException catch (e) {
      log(
        'Firebase error fetching shuffled items: ${e.message}',
        name: 'DataServices',
      );
      rethrow;
    } catch (e) {
      log('Unexpected error fetching shuffled items: $e', name: 'DataServices');
      rethrow;
    }
  }
}
