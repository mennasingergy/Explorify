import 'dart:developer';

import 'package:flutter/material.dart';
import '/Post/post.dart';
import '/Post/postCard.dart';
import '/Post/postList.dart';
import './SearchCard.dart';

class MySearchPage extends StatefulWidget {
  @override
  _MySearchPageState createState() => _MySearchPageState();
}

class _MySearchPageState extends State<MySearchPage> {
  String inputText = '';
  List<Post> searchResults = [];

  void search(List<Post> items, String keyword) {
    setState(() {
      searchResults = items
          .where((post) =>
              post.title.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    });
  }

  void saveInput(String text) {
    setState(() {
      inputText = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      //   title: Text('Search Page')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: saveInput,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(226, 239, 137, 48)),
                    borderRadius: BorderRadius.circular(12)),
                labelText: 'Search',
                labelStyle: TextStyle(
                  color: Color.fromARGB(226, 239, 137, 48), //<-- SEE HERE
                ),
                prefixIcon: Icon(Icons.search,
                    color: Color.fromARGB(226, 239, 137, 48)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 16),
            MaterialButton(
                onPressed: () {
                  search(postlist, inputText);
                },
                child: Text(
                  'Search',
                  style: TextStyle(fontSize: 15.0),
                ),
                color: Colors.orangeAccent),
            SizedBox(height: 16),
            // Text('Input Text: $inputText'),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  return SearchCard(po: searchResults[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
