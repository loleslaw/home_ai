import 'package:HomeAI/Services/baseAuth.dart';
import 'package:HomeAI/Widgets/bottomMessage.dart';
import 'package:HomeAI/main.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

//import './items/showCircularProgressBar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

enum FormMode { LOGIN, SIGNUP }

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FormMode _formMode = FormMode.LOGIN;
  bool _isLoading = false;
  String _errorMessage = '';
  String _email = '', _password = '';

  final Auth auth = Auth();

  @override
  Widget build(BuildContext context) {
    // _formKey = GlobalKey<FormState>();
    bool _isIos = Theme.of(context).platform == TargetPlatform.iOS;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _showBody(),
          _showCircularProgressBar(),
        ],
      ),
    );
  }

  Widget _showCircularProgressBar() {
    if (this._isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Container(
      height: 0,
      width: 0,
    );
  }

  Widget _showBody() {
    return Container(
      padding: EdgeInsets.all(30),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            _showLogo(),
            _showEmailInput(),
            _showPasswordInput(),
            _showPrimaryButton(),
            _showSecondaryButton(),
            //  _showErrorMessate(),
          ],
        ),
      ),
    );
  }

  Widget _showLogo() {
    return Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 70, 0, 0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 40,
          child: Image.asset('assets/blue-home.png'),
        ),
      ),
    );
  }

  Widget _showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
      child: TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: InputDecoration(
          hintText: 'Email',
          icon: Icon(
            Icons.email,
            color: Colors.grey,
          ),
        ),
        validator: (value) => EmailValidator.validate(value) == false
            ? 'Not a valid email'
            : null,
        onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget _showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: InputDecoration(
            hintText: 'Password',
            icon: Icon(
              Icons.lock,
              color: Colors.grey,
            )),
        validator: (value) {
          if (value.isEmpty) {
            return 'Password can\'t be empty';
          } else if (value.trim().length < 6) {
            return 'Minimum 6 characters';
          } else {
            return null;
          }
        },
        onSaved: (value) => _password = value.trim(),
      ),
    );
  }

  Widget _showPrimaryButton() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 45, 0, 0),
      child: MaterialButton(
        elevation: 5,
        minWidth: 200,
        height: 45,
        color: Colors.blue,
        child: _formMode == FormMode.LOGIN
            ? Text(
                'Login',
                style: TextStyle(fontSize: 20, color: Colors.white),
              )
            : Text(
                'Create account',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
        onPressed: _submitToDB,
      ),
    );
  }

  Widget _showSecondaryButton() {
    return FlatButton(
      child: _formMode == FormMode.LOGIN
          ? Text(
              'Create an account',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
            )
          : Text(
              'Have an account? Sign in',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
            ),
      onPressed: _formMode == FormMode.LOGIN
          ? _changeFormToSignUp
          : _changeFormToLogin,
    );
  }

  Widget _showErrorMessate() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13,
            color: Colors.red,
            height: 1,
            fontWeight: FontWeight.w300),
      );
    } else {
      return Container(
        height: 0,
      );
    }
  }

  void _changeFormToSignUp() {
    if (_formKey == null) {
      return;
    }
    _formKey.currentState.reset();
    _errorMessage = '';
    setState(() {
      _formMode = FormMode.SIGNUP;
    });
  }

  void _changeFormToLogin() {
    if (_formKey == null) {
      return;
    }
    _formKey.currentState.reset();
    _errorMessage = '';
    setState(() {
      _formMode = FormMode.LOGIN;
    });
  }

  bool _validateData() {
    setState(() {
      _errorMessage = '';
    });
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      return true;
    } else {
      return false;
    }
  }

  _submitToDB() async {
    if (_validateData()) {
      setState(() {
        _isLoading = true;
      });
    }
    if (_formMode == FormMode.LOGIN) {
      try {
        fbUser = await auth.signIn(_email, _password);
        appUser = (await auth.getAppUser(fbUser));
        Navigator.pushReplacementNamed(context, '/homePage');
      } catch (e) {
        setState(() {
          _errorMessage = e.code;
          _isLoading = false;
        });
      }
    } else {
      try {
        appUser = await auth.signUp(_email, _password);
        showBottomMessage(
            context: context,
            type: MessageType.OK,
            title: 'New app user',
            message: 'User has been created and logged in.');
      } catch (e) {
        setState(() {
          _errorMessage = e.code;
          _isLoading = false;
        });
      }
    }
    setState(() {
      _isLoading = false;
      if (_errorMessage != '') {
        showBottomMessage(
            context: context,
            type: MessageType.ERROR,
            title: _formMode == FormMode.LOGIN 
              ? 'Login error' 
              : 'Sign in error',
            message: _errorMessage);
      }
    });
  }
}
