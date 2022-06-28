import 'package:flutter/cupertino.dart';

import '../db/db_helper.dart';
import '../model/user_model.dart';

class UserProvider extends ChangeNotifier{

  Future<void> addUser(UserModel userModel){
    return DbHelper.addNewUser(userModel);
  }

}