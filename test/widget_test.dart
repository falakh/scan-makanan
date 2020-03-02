// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:scanmakan/tools/validator/email_validator.dart';
import 'package:scanmakan/tools/validator/password_validator.dart';

void main() {
  test("Email unit test", () {  
   expect(EmailValidator().isValid("zulfiakr@mail.com") , true) ;
   expect(EmailValidator().isValid("zulfiakr") , false);
});
test("password validator",(){
  expect(PasswordValidator().isValid("1234567"), false);
  expect(PasswordValidator().isValid("12345678"), true);
});
test("get user data",(){

});
}
