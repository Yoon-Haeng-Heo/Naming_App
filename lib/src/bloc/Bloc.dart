
import 'dart:async';
import 'package:english_words/english_words.dart';

class Bloc{
  Set<WordPair> saved = Set<WordPair>();
  final _savedController = StreamController<Set<WordPair>>.broadcast(); //stream에서 snapshot을 보내줄 때 여러개일 경우 한 번에 보내주기 위함
  get SavedStream =>_savedController.stream;  //받아오는 메소드
    //Stream<Set<WordPair>> getSavedStream(){} 과 같은 문법
  get addCurrentSaved => _savedController.sink.add(saved);
  addToOrRemoveFromSavedList(WordPair item){
    if(saved.contains(item)){
      saved.remove(item);
    }
    else{
      saved.add(item);
    }
    _savedController.sink.add(saved);   //controller에 알려주는 것
  }

  dispose(){    //반드시 해줘야 하는 작업 (메모리 누수가 안생기도록!)
    _savedController.close();
  }
}
var bloc = Bloc();