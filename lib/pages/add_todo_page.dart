import 'package:flutter/material.dart';
import 'package:fontend_for_django/models/post_function.dart';

class AddToDoPage extends StatefulWidget {
  const AddToDoPage({super.key});

  @override
  State<AddToDoPage> createState() => _AddToDoPageState();
}

class _AddToDoPageState extends State<AddToDoPage> {
  bool? ischecked = false;
  final _titleEditor = TextEditingController();
  final _descEditor = TextEditingController();
  bool _titleValidate = false;
  bool _descValidate = false;
  @override
  Widget build(BuildContext context) {
    PostClass controller = PostClass();
    return Scaffold(
      backgroundColor: Color(0xffFBEAEB),
      appBar: AppBar(
        title: Text(' Todos'),
        elevation: 0,
        backgroundColor: const Color(0xffF001133),
      ),
      body: ListView(children: [
        SizedBox(
          height: 20,
        ),
        Center(
          child: Container(
            width: 343,
            height: 60,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
            child: TextField(
              controller: _titleEditor,
              cursorColor: Color(0xffF001133),
              showCursor: true,
              decoration: InputDecoration(
                  hintText: 'Title',
                  border: InputBorder.none,
                  errorText:
                      _titleValidate == false ? 'Please Enter the Title' : null),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: TextFormField(
            textInputAction: TextInputAction.newline,
            keyboardType: TextInputType.multiline,
            showCursor: true,
            decoration: InputDecoration(
                hintText: 'Todo',
                border: InputBorder.none,
                errorText:
                    _descValidate == false ? 'Please Enter a Todo' : null),
            cursorColor: Colors.blue[900],
            maxLines: null,
            controller: _descEditor,
          ),
        ),
        SizedBox(
          height: 150,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Checkbox(
              value: this.ischecked,
              onChanged: (bool? value) {
                setState(() {
                  this.ischecked = value;
                });
              },
            ),
            SizedBox(
              width: 30,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _titleEditor.text.isEmpty
                      ? _titleValidate = false
                      : _titleValidate = true;
                  _descEditor.text.isEmpty
                      ? _descValidate = false
                      : _descValidate = true;

                      _titleValidate == true && _descValidate == true ?  controller.postData(_titleEditor.text,_descEditor.text, ischecked): null ;
                              Navigator.pop(context);
                });
              },
              child: Container(
                height: 50,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.blue[900],
                    borderRadius: BorderRadius.circular(6)),
                child: Center(
                    child: Text(
                  'Done',
                  style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                )),
              ),
            )
          ],
        )
      ]),
    );
  }
}
