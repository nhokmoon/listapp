import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'welcome to flutter',
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _bigerFont = const TextStyle(fontSize: 18.0);
  final _save = <WordPair>{};
  void _pushSave() {}

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return const Divider();

          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final alreadySave = _save.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _bigerFont,
      ),
      trailing: Icon(
        alreadySave ? Icons.favorite : Icons.favorite_border,
        color: alreadySave ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySave) {
            _save.remove(pair);
          } else {
            _save.add(pair);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('starup'),
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _pushSave,
          )
        ],
      ),
      body: _buildSuggestions(),
    );
  }
}
