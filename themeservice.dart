


import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class ThemeService{

  final _box=GetStorage();
  final _key='isDarkMode';
  _saveThemeToBox(bool isDarkmode)=>_box.write(_key,isDarkmode);
  bool _loadThemeFrombox()=>_box.read(_key)??false;
  ThemeMode get theme=>_loadThemeFrombox()?ThemeMode.dark:ThemeMode.light;

  void switchtheme() {
    Get.changeThemeMode(_loadThemeFrombox() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeToBox(!_loadThemeFrombox());
  }

}