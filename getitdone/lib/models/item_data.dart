import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:getitdone/models/item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemData with ChangeNotifier {
  final List<Item> _items = [
    //Item(title: "C++ Öğren"),
    //Item(title: "Java Öğren"),
    //Item(title: "İngilizce Çalış"),
  ];

  void toggleStatus(int index) {
    _items[index].toggleStatus();
    SaveItemToSharePref(_items);
    notifyListeners();
  }

  void addItem(String title) {
    _items.add(Item(title: title));
    SaveItemToSharePref(_items);
    notifyListeners();
  }

  void deleteItem(int index) {
    _items.removeAt(index);
    SaveItemToSharePref(_items);
    notifyListeners();
  }

  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  static SharedPreferences _sharedPref;
  List<String> _itemsAsString=[];

  Future<void> createPrefeObje() async {
    _sharedPref = await SharedPreferences.getInstance();
  }

  // ignore: non_constant_identifier_names
  void SaveItemToSharePref(List<Item> items) {
    _itemsAsString.clear();

    for (var item in items) {
      _itemsAsString.add(json.encode(item.toMap()));
    }

    _sharedPref.setStringList("toDoData", _itemsAsString);
  }

  void loadItemsFromSharePref() {
    List<String> tempList = _sharedPref.getStringList("toDoData") ?? [];
    _items.clear();
    for (var item in tempList) {
      _items.add(Item.fromMap(json.decode(item)));
    }
  }
}
