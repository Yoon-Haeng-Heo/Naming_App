import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'saved.dart';
import 'bloc/Bloc.dart';

/*
tip : ctrl + alt + L 버튼 -> 코드 정렬
      shift + F6 -> refactor 단축키
 */
class RandomList extends StatefulWidget {
  @override
  _RandomListState createState() => _RandomListState();
}

class _RandomListState extends State<RandomList> {
  final List<WordPair> _suggestions = <WordPair>[]; // 단어 리스트
  final Set<WordPair> _saved = Set<WordPair>(); // 선택한 목록 저장할 set(중복 불가)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Naming App'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.list),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SavedList()));
              },
            )
          ],
        ),
        body: _buildList());
  }

  Widget _buildList() {
    return StreamBuilder<Set<WordPair>>(
      stream: bloc.SavedStream,
      builder: (context, snapshot) {    //data가 바뀔 때 마다 snapshot이 전달 됨
        return ListView.builder(itemBuilder: (context, index) {
          if (index.isOdd) {
            return Divider();
          }
          var realIndex = index ~/ 2; //2로 나눈 몫
          if (realIndex >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(snapshot.data,_suggestions[realIndex]);
        });
      }
    );
  }

  Widget _buildRow(Set<WordPair> saved , WordPair pair) {
    final bool alreadySaved = saved==null? false : saved.contains(pair);  //null에 대한 처리 ... 3항연산자

    return ListTile(
      title: Text(pair.asPascalCase, textScaleFactor: 1.5),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: Colors.pink,
      ),
      onTap: () {
        //click이 가능하도록 하는 것
        /*setState(() {
          // statefulwidget이므로 setState로 설정
          if (alreadySaved)
            saved.remove(pair); //이미 저장되어 있는 것이라면 제거
          else
            saved.add(pair); // 저장이 안되어 있다면 저장목록에 추가
          print(saved.toString());
        });*/
        bloc.addToOrRemoveFromSavedList(pair);
      },
    );
  }
}
