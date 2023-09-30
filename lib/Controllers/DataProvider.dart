import 'dart:convert';

import 'package:bhagvat_geeta_mobile_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Modals/Details Modal.dart';
import '../Modals/FullChapterModal.dart';

class DataProvider extends ChangeNotifier {
  int slokType = 1;
  ThemeMode themeMode = ThemeMode.light;
  List<DetailsModal> chapterDetails = [];
  FullChapterModal fullChapter = FullChapterModal();
  List favSlok = [];
  List finalfavSlok = [];

  void addToFav(String value)async{
    favSlok.add(value);
    notifyListeners();
    sp = await SharedPreferences.getInstance();
    sp.setString('favSlok', jsonEncode(favSlok));
  }

  void deleteToFav(int index)async{
  favSlok.removeAt(index);
  notifyListeners();
  sp = await SharedPreferences.getInstance();
  sp.setString('favSlok', jsonEncode(favSlok));
  }

  void getFavSlok()async{
    sp = await SharedPreferences.getInstance();
    List decode = jsonDecode(sp.getString('favSlok')??'');
    favSlok = decode;
    notifyListeners();
  }

  void changeLang(int lang) async{
    slokType = lang;
    notifyListeners();
    sp = await SharedPreferences.getInstance();
    sp.setString('slokType', lang.toString());
  }

  void getLang() async {
    sp = await SharedPreferences.getInstance();
    String? tm = sp.getString('slokType');
    if(tm=='1'){
      slokType = 1;
    }else if(tm=='2'){
      slokType = 2;
    }else if(tm=='3'){
      slokType = 3;
    }else{
      slokType = 1;
    }
    notifyListeners();
  }

  void changeTheme(ThemeMode themeMode) async {
    this.themeMode = themeMode;
    notifyListeners();
    sp = await SharedPreferences.getInstance();
    sp.setString('themeMode', themeMode.toString());
  }

  void getThemeMode() async {
    sp = await SharedPreferences.getInstance();
    String? tm = sp.getString('themeMode');
    if(tm=='ThemeMode.light'){
      themeMode = ThemeMode.light;
    }else if(tm=='ThemeMode.dark'){
      themeMode = ThemeMode.dark;
    }else if(tm=='ThemeMode.system'){
      themeMode = ThemeMode.system;
    }else{
      themeMode=ThemeMode.light;
    }
    notifyListeners();
  }

  void loadHomeData() async {
    String loadChapterDetailsString =
        await rootBundle.loadString('assets/index.json');
    chapterDetails = detailsModalFromJson(loadChapterDetailsString);
    notifyListeners();
  }

  void loadVerse(int chapter, int slok) async {
    String loadFullChapterModalString =
        await rootBundle.loadString('assets/slok/$chapter/$slok/index.json');
    fullChapter = fullChapterModalFromJson(loadFullChapterModalString);
    notifyListeners();
  }
}
