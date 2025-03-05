import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:random_string/random_string.dart';
import 'package:untitled8/datafile/datafile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class Homescreen  extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  bool perosnl=true,office=false,work=false;
  bool suggest=false;
  bool newValue=true;
  String id='';
  Stream? todoStream;
  getOnTheLoad() async{
    if(perosnl) {
      print("yes personal am true");
      todoStream= await DataFile().getTask("personal");
    }
    else if(office){
      todoStream=await DataFile().getTask('office');
      print("yes office is true");
    }
    else{
      print("yes work is true");
      todoStream=await DataFile().getTask('work');
    }

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOnTheLoad();
  }

  @override

  Widget toDoWork()  {
    return StreamBuilder(
        stream: todoStream,
        builder: (context,AsyncSnapshot snapshot){
          print("thi is snapshot $snapshot");
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: CircularProgressIndicator()); // ✅ Safe null check
          }
          print("Total Documents: ${snapshot.data!.docs.length}");

          return
           Expanded(
             child: ListView.builder(
               itemCount: snapshot.data.docs.length,
                 itemBuilder: (context,index){
                 DocumentSnapshot snap=snapshot.data.docs[index];
                 return ListTile(
                   leading: Checkbox(
                     activeColor: Colors.greenAccent.shade400,
                     value: snap['yes'],
                     onChanged: (newValue) async {
                       await DataFile().tickMethod(snap['id'], perosnl ? 'personal' : office ? 'office' : 'work');
                       setState(() {});
                     },
                   ),
                   title: Text(
                     snap['work'],
                     style: TextStyle(
                       fontSize: 20,
                       color: Colors.black,
                       fontWeight: FontWeight.bold,
                     ),
                   ),
                   trailing: IconButton(
                     icon: Icon(Icons.delete, color: Colors.red),
                     onPressed: () async {
                       // Call delete method
                       await DataFile().deleteTask(snap['id'], perosnl ? 'personal' : office ? 'office' : 'work');
                       setState(() {});
                     },
                   ),
                 );



                 }),
           );
    }
    );

  }
  TextEditingController todoControler=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,
          onPressed:(){openBox();},
        child: Icon(Icons.add,
        color: Colors.white),
      ),
      body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.white,
            Colors.white54,
            Colors.white
          ],
          begin: Alignment.topLeft,
            end: Alignment.topRight
          ),

        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(

              child: Text('Hii',
              style: TextStyle(
                fontSize: 30,
                color: Colors.black


              ),),

            ),
   SizedBox(height: 10,),
            Container(

              child: Text('Deep',
                style: TextStyle(
                    fontSize: 54,
                    color: Colors.black


                ),),


            ),
            SizedBox(height: 10,),
            Container(

              child: Text('Lets start the begin',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.black38


                ),),


            ),
            SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly ,

              children: [
              perosnl?  Container(
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.greenAccent.shade200,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Text('personal',style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),),

                ):GestureDetector(
                onTap: (){
                  perosnl=true;
                  office=false;
                  work=false;
                  getOnTheLoad();
                  setState(() {

                  });
                },
                  child: Text('personal'
                                ,style: TextStyle(
                    fontSize: 20,

                  ),),


                ),
                office?  Container(
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.greenAccent.shade200,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Text('office',style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),),

                ):GestureDetector(
                  onTap: (){
                    perosnl=false;
                    office=true;
                    work=false;
                    getOnTheLoad();
                    setState(() {

                    });
                  },
                  child: Text('office'
                    ,style: TextStyle(
                      fontSize: 20,

                    ),),


                ),
                work?  Container(
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.greenAccent.shade200,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Text('work',style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),),

                ):GestureDetector(
                  onTap: (){
                    perosnl=false;
                    office=false;
                    work=true;
                    getOnTheLoad();
                    setState(() {

                    });
                  },
                  child: Text('work'
                    ,style: TextStyle(
                      fontSize: 20,

                    ),),


                ),

              ],
            ),
            SizedBox(
              height: 20,
            ),

            toDoWork(),
          ],
        ),
      ),
      ),
    );

  }
  openBox(){
    return showDialog(context: context, builder: (context)=>AlertDialog(
      content: SingleChildScrollView(
        child: Container(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
        
                children: [GestureDetector(
                  onTap:(){
                    Navigator.pop(context);
                  },
                child:Icon(Icons.cancel)),
                  SizedBox(width: 60,),
                  Text('Add New Task',style: TextStyle(
                    color: Colors.black,
        
        
                  ),
                  ),
                 ],
        
        
              ),
              SizedBox(height: 20,),
              Text('Add Task'),
              SizedBox(height: 30,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2.0
                  )
                ),
                child: TextField(
                  controller: todoControler,
                 decoration: InputDecoration(
                   border: InputBorder.none,
                   hintText: "Enter the Task"
                 ),
                ),
              ),
              SizedBox(height: 10,),
              Center(
                child: Container(
                  width: 100,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: GestureDetector(
                    onTap: (){
                      var id=randomAlphaNumeric(10);
                      Map<String,dynamic>todo={
                        "work":todoControler.text,
                        "id":id,
                        'yes':false
                      };
                      if(perosnl){
                        DataFile().addPersonlTask(todo, id);
                      }
                      else if(office){
                        DataFile().addOfficeTask(todo, id);
                      }
                      else{
                        DataFile().addWorkTask(todo, id);
                      }
                      Navigator.pop(context);
                    },
                    child: Center(
                      child: Text(
                        'add',
                        style: TextStyle(
                          color: Colors.black
                        ),

                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        
        ),
      ),
    ));
  }
}
