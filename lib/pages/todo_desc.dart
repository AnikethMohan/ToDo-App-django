import 'package:flutter/material.dart';

class TodoDescription extends StatelessWidget {
   TodoDescription({super.key,required this.desc, required this.title});
  final desc ;
  final title ;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(backgroundColor:Color(0xffF001133),title: Text('$title',style: TextStyle(fontWeight: FontWeight.w600),),),
      body:  Container(
        decoration: BoxDecoration(
          color: Color(0xffFBEAEB)
        ),
        child: Center(child: Text(desc,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),)),
      ),
    );
  }
}