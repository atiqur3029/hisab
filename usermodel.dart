class UserModel {
   String? UserId;
   String? UserName;
   String? Email;
   String? Password;

  UserModel(this.UserId, this.UserName, this.Email, this.Password);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'UserId': UserId,
      'UserName': UserName,
      'Email': Email,
      'Password': Password,
    };
    return map;
  }
  UserModel.fromMap(Map<String,dynamic> map){
   UserId=map['UserId'];
   UserName=map['UserName'];
   Email=map['Email'];
   Password=map['Password'];

  }




}
