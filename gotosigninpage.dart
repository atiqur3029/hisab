
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'logg_in.dart';

class GotoSigninpage extends StatefulWidget {
  const GotoSigninpage({Key ?key}) : super(key: key);

  @override
  _GotoSigninpageState createState() => _GotoSigninpageState();
}

class _GotoSigninpageState extends State<GotoSigninpage> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit( builder: ()=>Row(


      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(

          onPressed: (){}, child: Text("Do You Have Any Account?",style: TextStyle(
            fontSize: 15.sp,fontWeight: FontWeight.w800,color: Colors.teal
        ),),),
        TextButton(

          onPressed: (){
            Navigator.pushAndRemoveUntil(context, 
                MaterialPageRoute(builder: (_)=>Loggin()),

                    (Route<dynamic> route) => false);
          }, child: Text("Sign in ",style: TextStyle(
            fontSize: 15.sp,fontWeight: FontWeight.w800,color: Colors.blue
        ),),),


      ],




    ),

    );

  }
}
