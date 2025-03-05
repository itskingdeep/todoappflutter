import 'package:cloud_firestore/cloud_firestore.dart';
class DataFile{
  Future  addPersonlTask(Map<String,dynamic> userPersonalTask,String id)async{
    try {
      return await FirebaseFirestore.instance.collection('personal')
          .doc(id)
          .set(userPersonalTask);
    }
    catch(e){
      print("this is error$e");
    }
}
  Future  addOfficeTask(Map<String,dynamic> userPersonalTask,String id)async{
    try{
      return await FirebaseFirestore.instance.collection('office').doc(id).set(userPersonalTask);
    }
    catch(e){
      print("this is error in addoffice $e");
    }

  }
  Future  addWorkTask(Map<String,dynamic> userPersonalTask,String id)async{
    try{
      return await FirebaseFirestore.instance.collection('work').doc(id).set(userPersonalTask);
    }
    catch(e){
      print("this is error in work $e");
    }

  }

  Future<Stream<QuerySnapshot>>getTask(String task) async{
    return await FirebaseFirestore.instance.collection(task).snapshots();
  }
  tickMethod(String id,String task){
    FirebaseFirestore.instance.collection(task).doc(id).update({'yes':true});
  }

    deleteTask(String id,String task){
    FirebaseFirestore.instance.collection(task).doc(id).delete();
  }
}