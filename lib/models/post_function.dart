import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../Constants/api.dart';

class PostClass{
  Map<String,dynamic>? postdata ;
  void postData(String title,String desc,bool? isDone ) async{
http.Response post = await http.post(Uri.parse(api),body: <String, String>{
      'title': title,
      'desc':desc,
      'isDone': '$isDone',
      'date':''
    },);
   
     

    var data = json.decode(post.body);
    postdata = data ;
    log('${data.length}');
    log('${data.toString().length}');
  
  }
   void delete(int id)async{
       http.Response delete = await http.delete(Uri.parse('$api/$id'),);

    }
}