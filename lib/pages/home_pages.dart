import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fontend_for_django/Constants/api.dart';
import 'package:fontend_for_django/models/post_function.dart';
import 'package:fontend_for_django/models/todo.dart';
import 'package:fontend_for_django/pages/add_todo_page.dart';
import 'package:fontend_for_django/pages/todo_desc.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  
   HomePage({super.key});
   

  @override
  State<HomePage> createState() => _HomePageState();
  List<Todo> todo = [];
  
}

class _HomePageState extends State<HomePage> {
  List<Todo> mytodos = [];
  bool isloading = true ;
  PostClass controller = PostClass();
  bool show = false ;


  void fetchdate() async {
    try {
      http.Response response = await http.get(Uri.parse(api));
      //controller.postData();
    //   http.Response post = await http.post(Uri.parse(api),body: <String, String>{
    //   'title': 'application/json; charset=UTF-8',
    //   'desc':'test on post method',
    //   'isDone': 'true',
    //   'date':''
    // },);
      var data = json.decode(response.body);
      log('${data.length}');
     // var postdata = json.decode(post.body);
      
      data.forEach((todo) {
        Todo t = Todo(
            id: todo['id'],
            title: todo['title'],
            desc: todo['desc'],
            isdone: todo['isDone'],
            date: todo['date']);
        mytodos.add(t);
        widget.todo.add(t);
      });
     print(mytodos.length) ;
     setState(() {
       isloading = false ;
     });

      //log('response is ${data}');
    } catch (e) {
      log('error is $e');
    }
  }
  
  @override
  void initState() {
    fetchdate();
    super.initState();
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF001133),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add),onPressed: () {
        Navigator.push(context,MaterialPageRoute(builder: (context)=>AddToDoPage()));
      },backgroundColor: Colors.orange[700],),
      appBar: AppBar(
        title: Text(' Todos'),
        elevation: 0,
        backgroundColor: const Color(0xffF001133),
      ),
      body: isloading == true ? Center(child: CircularProgressIndicator()) : Container(
        height: double.infinity,
        width: double.infinity,
        child: ListView.builder(itemCount: mytodos.length,itemBuilder: (context, index) {
          return GestureDetector(
            onTap:() {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>TodoDescription(title: mytodos[index].title,desc: mytodos[index].desc,)));
            },
            onLongPress: () {
              setState(() {
                show = true ;
              });
            },
            child: Container(
              margin: EdgeInsets.all(10),
              height: 50,
              width: 200,
             
              decoration: BoxDecoration( color: Color(0xffFBEAEB),borderRadius: BorderRadius.circular(6)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Text('${mytodos[index].title}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)),
                  Visibility(
                    visible: show,
                    child: GestureDetector(
                      onTap: () {
                        controller.delete(mytodos[index].id!.toInt());
                        setState(() {
                          show = false ;
                          fetchdate();
                        });
                      },
                      child: Icon(Icons.delete)))
                ],
              ),
            ),
          );
        },),

      ),


    );
  }
}
