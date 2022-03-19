

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'package:hisab/income_expenses/income_expenses.dart';


import '../controlar/dbhelper_Register.dart';

import 'forget.dart';
import 'getTextFormfiled.dart';



class Loggin extends StatefulWidget {
  const Loggin({Key? key}) : super(key: key);

  @override
  _LogginState createState() => _LogginState();
}

class _LogginState extends State<Loggin> {
  final formkey= GlobalKey<FormState> ();
  final userIdcontrolar=TextEditingController();
  final Userpasswordcontrolar=TextEditingController();
  var dBhelper;

  lggin() async{
    String uid=userIdcontrolar.text;
    String password=Userpasswordcontrolar.text;
    if(uid.isEmpty){
      return "Please Enter userId";
    }else if(password.isEmpty){
     return "Please Enter Password";
    }else{

      await dBhelper.getLogginuser(uid, password).then((userdata){

        if(userdata!=null){
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>Incomeexpenses()), (Route<dynamic>route) => false);
          return "Logg in Successfully";
        }else{
          return "Logg in Fail";

        }
        


      }).catchError((onError){
        return "Logg in fail";
        
      });

    }

  }

  @override
  void initState() {
    super.initState();
    dBhelper=Dbhelper();
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return ScreenUtilInit(
      builder: ()=>Scaffold(

        appBar: AppBar(title:Text("Logg in"),),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15.w),
            child: Form(child: Column(
              key: formkey,

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h,),
                Text("User Id",style: TextStyle(color: Colors.blue,fontSize: 20.sp,fontWeight: FontWeight.bold),),
                SizedBox(height: 5.h,),


                GetTextformtext(controller: userIdcontrolar,icon: Icons.person,hintname:"Enter Your User Id",isObscureText: false,keyboardtype:TextInputType.text,),
                // TextFormField(
                //   autofocus: false,
                //   keyboardType: TextInputType.name,
                //   decoration: InputDecoration(
                //     hintText: "Enter Your Name",
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(20.r),
                //     ),
                //     prefixIcon: Icon(Icons.email),
                //
                //   ),
                //   // autofillHints: [AutofillHints.email],
                //   // validator: (email)=>!EmailValidator.validate(email!)
                //   // ? "Enter Your Valid Email"
                //   // :null,
                //   // onSaved: (value)=>_username=value,
                // ),
                SizedBox(height: 20.h,),
                Text("Password",style: TextStyle(color: Colors.blue,fontSize: 20.sp,fontWeight: FontWeight.bold),),
                SizedBox(height: 8.h,),
                GetTextformtext(controller: Userpasswordcontrolar,icon:Icons.lock,hintname: "Enter Your Password",isObscureText: true,keyboardtype:TextInputType.visiblePassword ,),

                // TextFormField(
                //   autofocus: false,
                //   keyboardType: TextInputType.visiblePassword,
                //   decoration: InputDecoration(
                //     hintText: "Enter Password",
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(20.r),
                //     ),
                //     prefixIcon: Icon(Icons.lock),
                //
                //
                //   ),
                //   autofillHints: [AutofillHints.password],
                //   obscureText: true,
                //   onSaved: (value)=>_password=value ,
                //
                // ),
                SizedBox(height: 20.h,),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(30.w),
                  child: MaterialButton(onPressed: lggin,
                    child: Text("Logg in",style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold,),textAlign:TextAlign.center,
                    ),
                    

                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.r),
                    color: Colors.blue,
                  ),


                ),
                SizedBox(height: 5.h,),
                forget(),


              ],
            )),

          ),
        ),
      ),





    );
  }
}