import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hard_flix/provider/google_sign_in.dart';
import 'package:hard_flix/utilities/constants.dart';
import 'package:hard_flix/views/moveis_list.dart';
import 'package:hard_flix/views/register.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();

  final docUser = FirebaseFirestore.instance.collection('users');

  Future checkUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: controllerEmail.text, password: controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Widget _monkey_image() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset('assets/hardflix-logo.png', width: 250.0, height: 250.0),
      ],
    );
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Email',
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: controllerEmail,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(color: Colors.black, fontFamily: 'Poppins'),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.black,
              ),
              hintText: 'Email',
              hintStyle: kHintTextStyle,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Senha',
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: controllerPassword,
            obscureText: true,
            style: const TextStyle(color: Colors.black, fontFamily: 'Poppins'),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.black,
              ),
              hintText: 'Senha',
              hintStyle: kHintTextStyle,
            ),
          ),
        )
      ],
    );
  }

  Future openDialog(String descricao) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            title: Text(descricao, textAlign: TextAlign.center),
            actions: [
              TextButton(
                onPressed: submit,
                child: const Text('Voltar'),
              )
            ],
          ));

  void submit() {
    Navigator.of(context).pop();
  }

  Widget _buildLoginBtn() {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 25.0),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            if (controllerEmail.text != "" || controllerPassword.text != "") {
              checkUser();

              Get.to(() => MoviesList(),
                  transition: Transition.rightToLeft,
                  duration: const Duration(milliseconds: 350));
            } else {
              openDialog("Preencha os dados corretamente");
            }
          },
          style: styledButtonLogin,
          child: const Text(
            'LOGIN',
            style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins'),
          ),
        ));
  }

  Widget _buildSignInWithText() {
    return Column(
      children: const <Widget>[
        Text(
          '- OU -',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
        ),
        SizedBox(height: 20.0)
      ],
    );
  }

  Widget _buildSocialBtn() {
    return IconButton(
      onPressed: () {
        final provider =
            Provider.of<GoogleSignInProvider>(context, listen: false);
        provider.googleLogin();
      },
      iconSize: 50,
      icon: Image.asset('assets/google.png'),
    );
  }

  Widget _buildSignUpBtn() {
    return GestureDetector(
      onTap: () {
        Get.to(() => RegisterScreen(),
            transition: Transition.rightToLeft,
            duration: const Duration(milliseconds: 350));
      },
      child: RichText(
          text: const TextSpan(
        children: [
          TextSpan(
            text: 'Não possui uma conta? ',
            style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w400),
          ),
          TextSpan(
            text: 'Inscreva-se',
            style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
        ],
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white,
          ),
          SizedBox(
            height: double.infinity,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 40.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _monkey_image(),

                  _buildEmailTF(),
                  const SizedBox(height: 20.0),
                  _buildPasswordTF(),
                  _buildLoginBtn(),
                  _buildSignInWithText(),
                  _buildSocialBtn(),
                  const SizedBox(height: 20.0),
                  // _buildSocialBtnRow(),
                  _buildSignUpBtn(),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
