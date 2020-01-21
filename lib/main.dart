import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new RandomWordsState();
  }
}

class RandomWordsState extends State<RandomWords> {
  final _words = <WordPair>[];
  final _checkedWords = new Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('ListView'),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: () {
            _pushToSavedWordsScreen();
          })
        ],
      ),
      body: new ListView.builder(itemBuilder: (context, index) {
        if (index >= _words.length) {
          _words.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_words[index], index);
      }),
    );
  }

  _pushToSavedWordsScreen() {
    final pageRoute = new MaterialPageRoute(builder: (context) {
      final listTiles = _checkedWords.map((wordPair) {
        return new ListTile(
          title: new Text(
            wordPair.asUpperCase,
            style: new TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold
            ),
          ),
        );
      });
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('List Checked'),
        ),
        body: new ListView(children: listTiles.toList(),),
      );
    });
    Navigator.of(context).push(pageRoute);
  }

  Widget _buildRow(WordPair wordPair, int index) {
    final color = index % 2 == 0 ? Colors.red : Colors.blue;
    final isChecked = _checkedWords.contains(wordPair);
    return ListTile(
      leading: new Icon(
        isChecked ? Icons.check_box : Icons.check_box_outline_blank,
        color: color,
      ),
      title: new Text(
        wordPair.asUpperCase,
        style: new TextStyle(
            fontSize: 22.0,
            color: color
        ),
      ),
      onTap: () {
        setState(() {
          if (isChecked) {
            _checkedWords.remove(wordPair);
          } else {
            _checkedWords.add(wordPair);
          }
        });
      },
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'My App',
      home: new RandomWords()
    );
  }
}