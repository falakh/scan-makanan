import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:scanmakan/Bloc/register_state/bloc/bloc.dart';
import 'package:scanmakan/Page/profile_page.dart';
import 'package:scanmakan/tools/validator/email_validator.dart';

import 'login_page.dart';
// import 'package:scanmakan/Widget/FormTextField.dart';

class RegisterPage extends StatelessWidget {
  RegisterBloc registerBloc = new RegisterBloc();
  TextEditingController namaController = new TextEditingController(),
      usiaController = new TextEditingController(),
      beratBadanController = new TextEditingController(),
      emailController = new TextEditingController(),
      passwordController = new TextEditingController();

final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(
        message: "Loading", progressWidget: CircularProgressIndicator());
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: new Text("Registrasi"),
        ),
        body: BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(),
          child: BlocBuilder<RegisterBloc, RegisterState>(
            builder: (context, registerState) {
              if (registerState.isSubmitting) {
                Future.delayed(Duration.zero, () {
                  dialog.show();
                });
              }
              if (registerState.isSuccess) {
                Future.delayed(Duration.zero, () {
                  dialog.dismiss();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return new ProfillePage();
                  }));
                });
              }
              if (registerState.isFailure) {
                Future.delayed(Duration.zero, () {
                  dialog.dismiss();
                  this.scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          content: Text('Register Gagal'),
                          backgroundColor: Colors.red,
                        ),
                      );
                });
              }

              return RegisterForm(
                  emailController: emailController,
                  passwordController: passwordController);
            },
          ),
        ));
  }
}

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    Key key,
    @required this.emailController,
    @required this.passwordController,
  }) : super(key: key);

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 120,
          width: 100,
          child: Container(
              child: Center(child: new Image.asset("assets/kucing.jpg"))),
        ),
        Center(
          child: Card(
            elevation: 10,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 20),
              shrinkWrap: true,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: emailFormFeild(
                    "Email",
                    emailController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormFieldWithPasswordViewer(
                    passwordCOntroller: passwordController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: MaterialButton(
                      color: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      onPressed: () => BlocProvider.of<RegisterBloc>(context)
                          .add(Submitted(
                              email: emailController.text,
                              password: passwordController.text)),
                      child: Text("Register"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

emailFormFeild(String labelText, TextEditingController controller) {
  return (TextFormField(
    validator: (value) {
      if (!EmailValidator().isValid(value)) {
        return "Masukan Email Dengan Benar";
      }
      return null;
    },
    controller: controller,
    decoration: InputDecoration(
        hintText: "email@mail.com",
        border: OutlineInputBorder(),
        icon: new Icon(Icons.mail),
        labelText: "Email"),
  ));
}

numberFormFieldWithBorder(String labelText,
    {TextEditingController controller}) {
  return Container(
    child: TextField(
      controller: controller,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: labelText,
      ),
    ),
  );
}

textFormFieldWithBorder(String labelText, {TextEditingController controller}) {
  return Container(
    child: TextField(
      controller: controller,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: labelText,
      ),
    ),
  );
}
