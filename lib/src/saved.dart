import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'bloc/Bloc.dart';

class SavedList extends StatefulWidget {
  //SavedList({@required this.saved}); // 매개변수가 있는 constructor
  //final Set<WordPair> saved;

  @override
  _SavedListState createState() => _SavedListState();
}

class _SavedListState extends State<SavedList> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved'),
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return StreamBuilder<Set<WordPair>>(
      stream: bloc.SavedStream,
      builder: (context, snapshot) {
        var saved = Set<WordPair>();
        if(snapshot.hasData)
          saved.addAll(snapshot.data);
        else
          bloc.addCurrentSaved;

        return ListView.builder(
            itemCount: saved.length * 2,
            itemBuilder: (context, index) {
              // saved.length에 *2를 하는 이유는 divider도 포함되므로
              if (index.isOdd) return Divider();
              var realIndex = index ~/ 2;

              return _buildRow(saved.toList()[realIndex]);
              //saved는 현재 Set이므로 Set은 인덱스로 item을 받아올 수 없으므로 list로 바꿔준 후 접근
            });
      }
    );

  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        textScaleFactor: 1.5,
      ),
      onTap: (){
        /*setState(() {
          widget.saved.remove(pair);
        });*/
        bloc.addToOrRemoveFromSavedList(pair);
      },
    );
  }
}
