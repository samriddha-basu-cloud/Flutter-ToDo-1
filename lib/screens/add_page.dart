import 'package:flutter/material.dart';
import 'package:todo_app/services/todo_service.dart';

import '../utils/snackbar_helper.dart';

class AddTodoPage extends StatefulWidget {
  final Map? todo; 
  const AddTodoPage({
    super.key,
    this.todo,
    });

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isEdit = false;

  @override
  void initState() {

    super.initState();
    final todo = widget.todo;

    if(todo != null)
    {
      isEdit = true;
      final title = todo['title'];
      final description = todo['description'];
      titleController.text = title;
      descriptionController.text = description;

    }
  }


  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit? 'Edit task' : 'Add New Task',
          ),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(hintText: 'Title'),
          ),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(hintText: 'Description'),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 10,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: isEdit? updateData : submitData,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              isEdit? 'Update':'Add',),
          ),)
        ],
      ),
    );
  }


  Future<void> updateData() async
  {
    final todo = widget.todo;
    if(todo == null)
    {
      print('You can not call updated without todo data');
      return;
    }
    final id = todo['_id'];
       
    final isSuccess = await TodoService.updateTodo(id, body);

    if(isSuccess)
    {
      showSuccessMessage(context, message: 'Updation Successfully');
    }
    else
    {
      showErrorMessage(context, message: 'Updation Failed');
    }


  }

  Future<void> submitData() async
  {
    
    
    final isSuccess = await TodoService.addTodo(body);
    if(isSuccess)
    {
      titleController.text = '';
      descriptionController.text = '';
      showSuccessMessage(context, message: 'Created Successfully');
    }
    else
    {
      showErrorMessage(context, message: 'Creation Failed');
    }
    
  }

  Map get body{
    final title = titleController.text;
    final description = descriptionController.text;
    return{
                    "title": title,
                    "description": description,
                    "is_completed": false,
                  };
  }


  
}