import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project_patch/model/note_model.dart';

Future<List<Note>> getallnotes() async {
  try {
    const url = 'https://jsonplaceholder.typicode.com/todos?_limit=20';

    final uri = Uri.parse(url);

    final response = await http.get(
      uri,
    );
    final json = jsonDecode(response.body) as List;
    if (response.statusCode == 200) {
      final result = json.map((e) => Note.fromjson(e)).toList();

      return result;
    }
  } catch (e) {
    print(e);
  }

  return [];
}

Future<bool> deletenotes(int id) async {
  try {
    final url = 'https://jsonplaceholder.typicode.com/todos/$id';

    final uri = Uri.parse(url);

    final response = await http.delete(uri);
    print('delete status code ' + response.statusCode.toString());
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  } catch (e) {
    print(e);
  }

  return false;
}

Future<bool> editnotes(Note data) async {
  try {
    final datas = {
      "userId": 1,
      "id": data.id,
      "title": data.note,
      "completed": data.iscompleted
    };
    final url =
        'https://jsonplaceholder.typicode.com/todos/${int.parse(data.id)}';

    final uri = Uri.parse(url);
    final header = {'Content-type': 'application/json; charset=UTF-8'};
    final response =
        await http.put(uri, body: jsonEncode(datas), headers: header);
    print(' Task updated (PUT)');
    print('Put status code ' + response.statusCode.toString());
    print(response.body);
    if (response.statusCode == 200) {
      return true;
    }
  } catch (e) {
    print(e);
  }

  return false;
}

Future<bool> patchnotes(Map<String, dynamic> data, int id) async {
  try {
    final url = 'https://jsonplaceholder.typicode.com/todos/$id';

    final uri = Uri.parse(url);
    final header = {'Content-type': 'application/json; charset=UTF-8'};
    final response =
        await http.put(uri, body: jsonEncode(data), headers: header);
    print(' Task updated (PUT)');
    print('Put status code ' + response.statusCode.toString());
    print(response.body);
    if (response.statusCode == 200) {
      return true;
    }
  } catch (e) {
    print(e);
  }

  return false;
}
