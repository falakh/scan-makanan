import 'package:scanmakan/tools/validator/validator.dart';

class EmailValidator extends Validator{
  @override
  RegExp getRegExp() {
    return RegExp(r'^[^@]+@[^@]+\.[^@]+');
  }

}