import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduation_project_ui/Features/Auth/data/Models/User_Model.dart';
import 'package:graduation_project_ui/core/Services/Data_Base_Service.dart';

class FireBaseStoreService extends DatabaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<void> addData(
      {required String path,
      required Map<String, dynamic> data,
      String? documentId}) async {
    if (documentId != null) {
      await firestore
          .collection(path)
          .doc(documentId)
          .set(data, SetOptions(merge: true));
    } else {
      await firestore.collection(path).add(data);
    }
  }

  @override
  Future getData(
      {required String path,
      String? documentId,
      Map<String, dynamic>? query}) async {
    if (documentId != null) {
      await FirebaseFirestore.instance.clearPersistence();
      await FirebaseFirestore.instance.disableNetwork();
      await FirebaseFirestore.instance.enableNetwork();
      var data = await firestore.collection(path).doc(documentId).get();

      return data.data()! as Map<String, dynamic>;
    } else {
      Query<Map<String, dynamic>> data = firestore.collection(path);
      if (query != null) {
        if (query['orderBy'] != null) {
          var orderBy = query['orderBy'];
          var descending = query['descending'] ?? false;
          data = data.orderBy(orderBy, descending: descending);
        }

        if (query['limit'] != null) {
          var limit = query['limit'];
          data = data.limit(limit);
        }
      }

      var result = await data.get();

      return result.docs.map((e) {
        return e.data();
      }).toList();
    }
  }

  @override
  Future<void> addUserData(UserModel user) async {
    await addData(
      path: 'users', // تخزين في كولكشن users
      documentId: user.id, // استخدام uid الخاص بالمستخدم كمفتاح
      data: user.toMap(),
    );
  }
}
