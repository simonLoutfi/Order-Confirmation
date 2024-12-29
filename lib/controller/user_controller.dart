import 'package:coinbase_commerce/coinbase.dart';
import 'package:coinbase_commerce/enums.dart';
import 'package:coinbase_commerce/returnObjects/chargeObject.dart';
import 'package:proto/model/user_model.dart';
import 'package:proto/repository/user.dart';
import 'package:url_launcher/url_launcher.dart';

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

  Coinbase coinbase = Coinbase('7ccd06c5-a6d5-44f5-9bd0-4e33ee95501a', debug: true);

makeCharge() async {
  try {
    // Create a charge for $1 USD
    ChargeObject charge = await coinbase.createCharge(
      name: 'Payment for Service',
      description: 'Payment of \$1 to your account',
      currency: CurrencyType.usd,
      pricingType: PricingType.fixedPrice,
      amount: 1, // Amount in USD
    );

    // Output the charge details
    print('Charge Created: ${charge.id}');

    // Open the payment link directly
    Uri paymentUrl = Uri.parse(charge.url!);  // Parse the URL into Uri object
    if (await canLaunchUrl(paymentUrl)) {
      await launchUrl(paymentUrl);  // Open the payment URL in the default browser
    } else {
      print('Could not open the payment URL.');
      return false;
    }

    // Check the status of the charge
    ChargeObject chargeStatus = await coinbase.viewCharge(charge.id!);

    // Check if the charge was completed
    if (chargeStatus.timeline != null && chargeStatus.timeline!.isNotEmpty) {
      var latestStatus = chargeStatus.timeline!.last.status;
      if (latestStatus == 'COMPLETED') {
        setLock();
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}
  
}