import 'package:proto/model/user_model.dart';
import 'package:proto/repository/user.dart';

class UserController {
  createUser(UserModel user) async{
    await User.instance.createUser(user);
  }

  addPhoneUser(String phone) async{
    await User.instance.addPhoneUser(phone);
  }

  Future<bool> getLock() async{
    return await User.instance.getLock();
  }

  setLock() async{
    await User.instance.setLock();
  }

  Future<bool> getPhone() async{
    return await User.instance.getPhone();
  }

  Future<bool> getName() async{
    return await User.instance.getName();
  }

  setRate(double rating, String feedback) async{
    await User.instance.setRate(rating,feedback);
  }
  
  Future<double> getRating() async{
    return await User.instance.getRating();
  }

  Future<String> getFeedback() async{
    return await User.instance.getFeedback();
  }

  setReminder(bool reminder) async{
    await User.instance.setReminder(reminder);
  }
  
}