
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class GetTextformtext extends StatefulWidget {
  

   TextEditingController?  controller;
   String? hintname;
   IconData ?icon;
   bool isObscureText;
   TextInputType ? keyboardtype;



  GetTextformtext({Key? key, this.controller,this.hintname,this.keyboardtype,this.icon,this.isObscureText=false}) : super(key: key);

  @override
  State<GetTextformtext> createState() => _GetTextformtextState();
}

class _GetTextformtextState extends State<GetTextformtext> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: ()=> TextFormField(
      obscureText:widget.isObscureText ,
      controller: widget.controller,
      autofocus: false,
      keyboardType:widget.keyboardtype,
      validator: (val){

        if(val==null || val.isEmpty){
          return "Please Enter ${widget.hintname}";
        }

        if(widget.hintname=="Enter Your Email" &&  !EmailValidator.validate(val)){
          return "Please Enter Valid Email";




        }
        return null;


      },
      onSaved: (value)=>widget.controller!.text = value!,

      decoration: InputDecoration(
        labelText: widget.hintname,
        hintText: widget.hintname,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.r),
        ),
        prefixIcon: Icon(widget.icon),

      ),
      // autofillHints: [AutofillHints.email],
      // validator: (email)=>!EmailValidator.validate(email!)
      // ? "Enter Your Valid Email"
      // :null,
      // onSaved: (value)=>_username=value,
    )
    );
  }
}

