import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:scanmakan/Bloc/login/bloc/bloc.dart';
import 'package:scanmakan/Page/home_page.dart';
import 'package:scanmakan/Page/register_page.dart';

class LoginPage extends StatelessWidget {
  ProgressDialog pr;
  final emailTextField = EmailTextFormFieldEditor(
      emailTextEditController: emailTextEditController);

  get loginBloc => new LoginBloc();
  final passwordTextField = TextFormFieldWithPasswordViewer(
      passwordCOntroller: passwordTextEditController);
  final scaffoldKey = GlobalKey<ScaffoldState>();
  static var emailTextEditController = new TextEditingController(),
      passwordTextEditController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    const loginComponentPadding = const EdgeInsets.all(8.0);

    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(),
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          var loginProgressBar = ProgressDialog(context);
          loginProgressBar.style(progressWidget: CircularProgressIndicator());
          if (state is LoginFail) {
            Future.delayed(Duration.zero, () {
              loginProgressBar.dismiss();
              showFailedDialog(context);
            });
          }
          if (state is LoginLoading) {
            //  print("Loading");

            Future.delayed(Duration.zero, () {
              loginProgressBar.show();
            });
          }

          if (state is LoginSucces) {
            loginProgressBar.dismiss();
            Future.delayed(Duration.zero, () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (BuildContext context) {
                return HomePage();
              }));
            });
          }
          return Scaffold(
            key: scaffoldKey,
            body: Container(
              color: (Colors.green[50]),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: Card(
                  elevation: 15.0,
                  child: ListView(
                    padding: EdgeInsets.all(20.0),
                    shrinkWrap: true,
                    children: <Widget>[
                      Padding(
                        padding: loginComponentPadding,
                        child: emailTextField,
                      ),
                      Padding(
                        padding: loginComponentPadding,
                        child: passwordTextField,
                      ),
                      Padding(
                        padding: loginComponentPadding,
                        child: loginButton(context),
                      ),
                      registerGestureDetector(context),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget registerGestureDetector(BuildContext context) {
    return MaterialButton(
      child: Text("Register"),
      onPressed: () => Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => RegisterPage())),
      // onTap: () => Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => RegisterPage())),
    );
  }

  Widget loginButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: MaterialButton(
          child: new Text("Login"),
          elevation: 5,
          color: Theme.of(context).primaryColor,
          onPressed: () => BlocProvider.of<LoginBloc>(context).add(
              LoginButtonPress(
                  username: emailTextEditController.text,
                  password: passwordTextEditController.text))
          // context, MaterialPageRoute(builder: (context) => HomePage())),
          ),
    );
  }

  showProgressBar(BuildContext context) {
    pr.show();
  }

  showFailedDialog(BuildContext context) {
    return this.scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text('Login Gagal'),
            backgroundColor: Colors.red,
          ),
        );
  }
}

class EmailTextFormFieldEditor extends StatelessWidget {
  const EmailTextFormFieldEditor({
    Key key,
    @required this.emailTextEditController,
  }) : super(key: key);

  final TextEditingController emailTextEditController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: emailTextEditController,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Email",
          icon: new Icon(Icons.email)),
    );
  }
}

class TextFormFieldWithPasswordViewer extends StatefulWidget {
  final TextEditingController passwordCOntroller;

  const TextFormFieldWithPasswordViewer({
    Key key,
    this.passwordCOntroller,
  }) : super(key: key);

  @override
  _TextFormFieldWithPasswordViewerState createState() =>
      _TextFormFieldWithPasswordViewerState(this.passwordCOntroller);
}

class _TextFormFieldWithPasswordViewerState
    extends State<TextFormFieldWithPasswordViewer> {
  bool isSeen = false;
  TextEditingController passwordCOntroller;

  _TextFormFieldWithPasswordViewerState(this.passwordCOntroller);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: !isSeen,
      keyboardType: TextInputType.visiblePassword,
      controller: passwordCOntroller,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Password",
          icon: new Icon(Icons.vpn_key),
          suffixIcon: IconButton(
            enableFeedback: true,
            icon: Icon(Icons.remove_red_eye),
            onPressed: () => this.setState(() => isSeen = !isSeen),
          )),
    );
  }
}
