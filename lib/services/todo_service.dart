import 'dart:convert';

import 'package:http/http.dart' as http;


class TodoService{
  static Future<bool> deleteById(String id) async 
  {
    final url = 'https://api.nstack.in/v1/todos/$id' ;
    final uri = Uri.parse(url);
    final response = await http.delete(uri); 
    return response.statusCode == 200;
  }

  static Future<List?> fetchTodos() async
  {
    final url = 'https://api.nstack.in/v1/todos?page=1&limit=15';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if(response.statusCode == 200)
    {
      final json = jsonDecode(response.body) as Map;
      final result = json['items'] as List;
      return result;
    }
    else
    {
      return null;
    }
  }


  static  Future<bool> updateTodo(String id, Map body) async 
  {
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.put(
      uri, 
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
      );

      return response.statusCode==200;
  }


  static  Future<bool> addTodo(Map body) async 
  {
    final url = 'https://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);
    final response = await http.post(
      uri, 
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
      );

      return response.statusCode==201;
  }


}