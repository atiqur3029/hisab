

import 'dart:async';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as i0;

import '../Model/usermodel.dart';

class Dbhelper {
  static Database? _db;
  static const int version = 1;
  static const String Database_name = 'test.db';
  static const String Table_user = 'user';
  static const String C_userId = 'UserId';
  static const String C_userName = 'UserName';
  static const String C_Email = 'Email';
  static const String C_Password = 'Password';
  static const String C_Confirmpassword = 'confirmPassword';

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }

    _db = await initdb();
    return _db;
  }

  initdb() async {
    i0.Directory documentdirectory = await getApplicationDocumentsDirectory();

    String path = join(documentdirectory.path, Database_name);
    var db = await openDatabase(path, version: version, onCreate: _onCrete);
    return db;
  }

  FutureOr<void> _onCrete(Database db, int version) async {
    await db.execute("CREATE TABLE $Table_user("
        "$C_userId TEXT,"
        "$C_userName TEXT,"
        "$C_Email TEXT,"
        "$C_Password TEXT,"
        " PRIMARY KEY ($C_userId)"
        ")");
  }

  Future<int?> Savedata(UserModel user)async{
    var dbClient=await db;
    var res=await dbClient?.insert(Table_user, user.toMap());
    //user.UserId=((await dbClient?.insert(Table_user, user.toMap())) as String?)!;
    return res;

  }

  Future<UserModel?> getLogginuser(String User_id,String password) async{
    var dbClient=await db;
    var res=await dbClient?.rawQuery("SELECT *FROM $Table_user WHERE "
        "$C_userId='$User_id' AND "
        "$C_Password='$password'");
    if(res!.isNotEmpty){

      return UserModel.fromMap(res.first);
    }

    return null;




  }
}
