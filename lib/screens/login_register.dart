import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:donations/helpers/constants.dart';
import '../ui_components/make_text_box.dart';
import 'package:donations/helpers/clip_path.dart';
import 'package:donations/screens/authentication.dart';

class LoginRegisterPage extends StatefulWidget {
  LoginRegisterPage({this.auth, this.onSignedIn});
  final AuthImplementation auth;
  final VoidCallback onSignedIn;

  @override
  _LoginRegisterPageState createState() => _LoginRegisterPageState();
}

enum FormType { login, register }

class _LoginRegisterPageState extends State<LoginRegisterPage> {
  final formKey = new GlobalKey<FormState>();
  FormType _formType = FormType.login;
  String _email = "";
  String _password = "";
  MakeTextBox textBox = MakeTextBox();
  ClipPathClass clip = ClipPathClass();

  List<Widget> createInputs() {
    return [
      TextFormField(
        decoration: InputDecoration(labelText: 'E-mail'),
        validator: (value) {
          return value.isEmpty ? 'E-mail is required' : null;
        },
        onSaved: (value) {
          return _email = value;
        },
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Password'),
        obscureText: true,
        validator: (value) {
          return value.isEmpty ? 'Password is required' : null;
        },
        onSaved: (value) {
          return _password = value;
        },
      ),
      SizedBox(height: 10)
    ];
  }

  List<Widget> createButtons() {
    if (_formType == FormType.login) {
      return [
        RaisedButton(
            onPressed: validateAndSubmit,
            child: Text(
              "Login",
              style: TextStyle(fontSize: 20),
            ),
            textColor: Colors.white,
            color: Colors.pink),
        FlatButton(
          onPressed: moveToRegister,
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Don't have an Account?",
                  style: TextStyle(fontSize: 13),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Create Account",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
          textColor: Colors.red,
        ),
      ];
    } else {
      return [
        RaisedButton(
            onPressed: validateAndSubmit,
            child: Text(
              "Create Account",
              style: TextStyle(fontSize: 20),
            ),
            textColor: Colors.white,
            color: Colors.pink),
        FlatButton(
          onPressed: moveToLogin,
          child: Text(
            "Already have an account? Login",
            style: TextStyle(fontSize: 15),
          ),
          textColor: Colors.red,
        ),
      ];
    }
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if (_formType == FormType.login) {
          String userId = await widget.auth.SignIn(_email, _password);
          print("Login userId= " + userId);
        } else {
          String userId = await widget.auth.SignUp(_email, _password);
          Alert(context: context, title: "Congratulations", desc: "Account Created Successfully").show();
          print("Register userId= " + userId);
        }
        widget.onSignedIn();
      } catch (e) {
        if(e.toString()=="PlatformException(ERROR_INVALID_EMAIL, The email address is badly formatted., null)"){
          Alert(context: context, title: "Error", desc: "Invalid E-mail").show();
        }
        else if(e.toString()=="PlatformException(ERROR_WRONG_PASSWORD, The password is invalid or the user does not have a password., null)"){
          Alert(context: context, title: "Error", desc: "Incorrect Password").show();
        }
        else{
          Alert(context: context, title: "Error", desc: "Invalid E-mail and Password").show();
        }
        print("Error = " + e.toString());
      }
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: gradient,
        child: ListView(
          children: [
            clip.createClipPath(height: deviceHeight / 2.8, width: deviceWidth),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: createInputs() + createButtons(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
