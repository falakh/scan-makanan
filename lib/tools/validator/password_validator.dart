import 'package:scanmakan/tools/validator/validator.dart';

class PasswordValidator extends Validator{
  @override
  RegExp getRegExp() {
    return RegExp(".{8,}");
  }

}