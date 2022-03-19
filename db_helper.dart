

import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DBhelper{
  late Box box;
  late SharedPreferences preferences;
  

  DBhelper(){
    openbox();
  }

  Future deleteData (int index)async{
    await box.delete(index);
  }

  openbox(){
    box=Hive.box('money');
  }
  Future addData(int amount,DateTime ? date,String  note,String  type)async
  {
    var value={
      'amount':amount ,
      'date': date,
      'type':type ,
      'note':note,

    };

    box.add(value);




}

addName(String name)async {
    preferences=await SharedPreferences.getInstance();
    preferences.setString('name', name);
}
getname() async{
    preferences=await SharedPreferences.getInstance();
    preferences.getString('name');
}

}

