import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddPostView extends StatefulWidget {
  const AddPostView({super.key});

  @override
  State<AddPostView> createState() => _AddPostViewState();
}

class _AddPostViewState extends State<AddPostView> {
  final _titleController = TextEditingController();

  Future<void> createPost() async {
    final response = await http.post(
      Uri.parse('https://dummyjson.com/posts/add'),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        'title': _titleController.text,
        'userId': 5
      }),
    );
    if (response.statusCode == 201) {
      _titleController.clear();
    } else {
      throw Exception('Failed to create post');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Post')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                createPost();
              },
              child: const Text('Create Post'),
            ),
          ],
        ),
      ),
    );
  }
}