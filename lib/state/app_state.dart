import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class AppState extends ChangeNotifier{
 
  bool _isBusy;
  bool get isbusy => _isBusy;
  
  BehaviorSubject<int> pageIndex = BehaviorSubject()..add(0);
  set setpageIndex(int index){
    pageIndex.value = index;
  }

  @override
  void dispose() {
    pageIndex.close();
    super.dispose();
  }
}
