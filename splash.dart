
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hisab/controlar/db_helper.dart';
//import 'package:hisab/homepage/myhomepage.dart';


import '../income_expenses/income_expenses.dart';
import '../page/logg_in.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  DBhelper dBhelper=DBhelper();

  Future getSetting () async{
   String? name=await dBhelper.getname();
   await Future.delayed(Duration(milliseconds: 1500));
   if(name !=null){
     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Incomeexpenses()));

   }else{
     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Loggin()));
   }
  }

  @override
  void initState() {
    super.initState();
    getSetting();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: ()=>Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      backgroundColor: Colors.purple[50],
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.all(18.0),
          child: Image.asset('images/notebook.jpg'),
          width: 120.0,
          height: 120.0,
        ),

      ),

    ));

  }
}
