
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hisab/page/registered.dart';


class forget extends StatefulWidget {
  const forget({Key ? key}) : super(key: key);

  @override
  _forgetState createState() => _forgetState();
}

class _forgetState extends State<forget> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit( builder: ()=>Row(


      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(

            onPressed: (){}, child: Text("Forget Password",style: TextStyle(
          fontSize: 15.sp,fontWeight: FontWeight.w800,color: Colors.red
        ),),),
        TextButton(

          onPressed: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>Registered()));
          }, child: Text("Sign Up",style: TextStyle(
            fontSize: 15.sp,fontWeight: FontWeight.w800,color: Colors.blue
        ),),),


      ],




    ),

    );

  }
}
