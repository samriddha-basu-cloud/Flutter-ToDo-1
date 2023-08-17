
import 'package:flutter/material.dart';
import 'package:todo_app/screens/add_page.dart';
import 'package:todo_app/services/todo_service.dart';

import '../utils/snackbar_helper.dart';
import '../widget/todo_card.dart';


class TodoListPage extends StatefulWidget { 
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {

  bool isLoading = true;
  List items = [];
  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    fetchTodo();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
      ),
      body: Visibility(
        visible: isLoading,
        child: Center(child: CircularProgressIndicator()),
        replacement: RefreshIndicator(
          onRefresh: fetchTodo,
          child: Visibility(
            visible: items.isNotEmpty,
            replacement: Center(
              child: Text(
                'Add Tasks ☟',
                style: Theme.of(context).textTheme.headline3,
                )
              ),
            child: ListView.builder(
              itemCount: items.length,
              padding: EdgeInsets.all(8.0),
              itemBuilder: (context, index)
              {
                final item = items[index] as Map;
                return TdodCard(
                  index: index,
                  item: item,
                  deleteById: deleteById,
                  navigateEdit: navigateToEditPage,
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToAddPage, 
        label: Text('New Task')),
    );
  }

  
  Future<void> navigateToEditPage(Map item) async
  {
    final route = MaterialPageRoute(
      builder: (context) => AddTodoPage(todo: item),
      );
     await  Navigator.push(context, route);
     setState(() {
       isLoading = true;
     });
     fetchTodo();
  }


  Future<void> navigateToAddPage() async
  {
    final route = MaterialPageRoute(
      builder: (context) => AddTodoPage(),
      );
      await Navigator.push(context, route);
      setState(() {
        isLoading = true;
      });
      fetchTodo();
  }

  Future<void> deleteById(String id) async
  {
    
    final isSuccess = await TodoService.deleteById(id);

    if(isSuccess)
    {
        final filtered = items.where((element) => element['_id'] != id).toList();
        setState(() {
          items = filtered;
        });
    }
    else
    {
      showErrorMessage(context, message: 'Deletion unsuccessful!!');
    }

  }


  Future<void> fetchTodo() async
  {
    final response = await TodoService.fetchTodos();
    if(response != null)
    {
      setState(() {
        items = response;
      },);
    }
    else
    {
      // ignore: use_build_context_synchronously
      showErrorMessage(context, message: 'Something Went Wrong Bro!!');
    }
    
    setState(() {
      isLoading = false;
    });
  }



  
}