
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hisab/Model/usermodel.dart';

import 'package:hisab/income_expenses/income_expenses.dart';


import '../controlar/dbhelper_Register.dart';
import 'getTextFormfiled.dart';
import 'gotosigninpage.dart';

class Registered extends StatefulWidget {
  const Registered({Key? key}) : super(key: key);

  @override
  _RegisteredState createState() => _RegisteredState();
}

class _RegisteredState extends State<Registered> {

  final formkey=GlobalKey<FormState>();


  final _userIdcontrolar=TextEditingController();
  final _Userpasswordcontrolar=TextEditingController();
  final _Usernamecontrolar=TextEditingController();
  final _Emailcontrolar=TextEditingController();
  final _ConfirmPasswordcontolar=TextEditingController();
  var dbhelper;

  SignUp() {
    String uid = _userIdcontrolar.text;
    String uname = _Usernamecontrolar.text;
    String uemail = _Emailcontrolar.text;
    String upass = _Userpasswordcontrolar.text;
    String uconfirmPassword = _ConfirmPasswordcontolar.text;
    if(formkey.currentState!.validate()){
      if(upass!=uconfirmPassword){
        return "password Mismatch";
      }else{

        formkey.currentState?.save();
        UserModel userModel = UserModel(uid, uname, uemail, upass);
        dbhelper.Savedata(userModel).then((Userdata){



          _userIdcontrolar.clear();
          _Userpasswordcontrolar.clear();
          _Usernamecontrolar.clear();
          _Emailcontrolar.clear();
          _ConfirmPasswordcontolar.clear();
          Navigator.push(context, MaterialPageRoute(builder: (_)=>Incomeexpenses()));
          return "Successfully Save";


        }).catchError((error){
          return "Error:Data Save Fail";
        });

      }

    }

  }


  @override
  void initState() {

    super.initState();
     dbhelper=Dbhelper();

  }
  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
        builder: () => Scaffold(
              appBar: AppBar(
                title: Text("Registration"),
              ),
              body: SingleChildScrollView(
                child: Form(
                  key: formkey,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "User Id",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 12.h,),

                              GetTextformtext(controller: _userIdcontrolar,icon: Icons.person,hintname:"Enter Your User Id",isObscureText: false,keyboardtype:TextInputType.text,),




                              SizedBox(
                                height: 12.h,
                              ),
                              Text(
                                "User Name",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              GetTextformtext(controller:_Usernamecontrolar,icon: Icons.lock,hintname:"Enter Your User Name",isObscureText: false,keyboardtype:TextInputType.name,),

                          SizedBox(
                            height: 12.h,
                          ),
                              Text(
                                "User Email",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height:12.h),

                              GetTextformtext(controller: _Emailcontrolar,icon: Icons.email,hintname:"Enter Your Email",isObscureText: false,keyboardtype:TextInputType.emailAddress,),
                              SizedBox(
                                height: 15.h,
                              ),
                              Text(
                                "User Password",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 12.h,
                              ),

                              GetTextformtext(controller:_Userpasswordcontrolar,icon: Icons.lock,hintname:"Enter Your Password",isObscureText: true,keyboardtype:TextInputType.visiblePassword,),
                              SizedBox(
                                height: 15.h,
                              ),


                              Text(
                                "Confirm Password",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height:12.h,
                              ),
                              GetTextformtext(controller:_ConfirmPasswordcontolar,icon: Icons.lock,hintname:"Please Ensure Password again",isObscureText: true,keyboardtype:TextInputType.visiblePassword,),
                              // TextFormField(
                              //   autofocus: false,
                              //   keyboardType: TextInputType.visiblePassword,
                              //   decoration: InputDecoration(
                              //     hintText: "Enter Password",
                              //     border: OutlineInputBorder(
                              //       borderRadius: BorderRadius.circular(20.r),
                              //     ),
                              //     prefixIcon: Icon(Icons.lock),
                              //   ),
                              //   autofillHints: [AutofillHints.password],
                              //   obscureText: true,
                              //   onSaved: (value) => _password = value!,
                              // ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.all(30.w),
                                child: MaterialButton(onPressed: SignUp,
                                  child: Text("Save",style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold,),textAlign:TextAlign.center,
                                  ),


                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.r),
                                  color: Colors.blue,
                                ),


                              ),

                              GotoSigninpage(),
                            ],
                          ),
                        ),
                      ),
                    )),
              ),
            ));
  }
}
