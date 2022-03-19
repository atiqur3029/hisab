

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ScreenUtilInit Logbuttons(String title,Function()  fun,
{Color color =Colors.blue,Color textcolor =Colors.white}){

  return ScreenUtilInit(
    builder: ()=>MaterialButton(onPressed: fun,
      textColor: textcolor,
      color: color,
      child: SizedBox(width: double.infinity,
        child: Text(title,
        textAlign: TextAlign.center,),

      
      ),
      height: 45,
      minWidth: 600,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.r))
      ),
    ),





  );


}