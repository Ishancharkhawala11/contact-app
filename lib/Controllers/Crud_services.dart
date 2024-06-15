import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CrudServices {
  User? user = FirebaseAuth.instance.currentUser;
  //add new Contact
  Future AddNewContacts(String name, String phone, String email) async {
    Map<String, dynamic> data = {"name": name, "email": email, "phone": phone};
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .collection("contacts")
          .add(data);
      print("Document Added");
    } catch (e) {
      print(e.toString());
    }
  }
  Stream<QuerySnapshot> getContacts({String? SearchQuery})async*{
    var contactQuery=FirebaseFirestore.instance.collection("users").doc(user!.uid)
        .collection("contacts").orderBy("name");
    //filter to search
    if(SearchQuery!=null && SearchQuery.isNotEmpty){
      String stringEnd=SearchQuery+ "\uf8ff";
      contactQuery=contactQuery.where("name",isGreaterThanOrEqualTo:SearchQuery,isLessThan: stringEnd );
    }
    var contacts=contactQuery.snapshots();
    yield * contacts;
  }
  Future UpdateContacts(String name, String phone, String email,String Docid) async {
    Map<String, dynamic> data = {"name": name, "email": email, "phone": phone};
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .collection("contacts").doc(Docid)
          .update(data);
      print("Document updated");
    } catch (e) {
      print(e.toString());
    }
  }
  Future deleteContact(String docID) async
  {
  try{
    await FirebaseFirestore.instance.collection("users").doc(user!.uid).collection("contacts").doc(docID).delete();
    print("document delete");
  }
  catch(e){
    print(e.toString());
  }
  }
}
