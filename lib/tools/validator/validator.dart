 abstract class Validator {
 

  RegExp getRegExp();

  bool isValid(String text) {
    return getRegExp().hasMatch(text);
  }
}
