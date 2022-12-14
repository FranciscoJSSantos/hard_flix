import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hard_flix/utilities/constants.dart';
import 'package:hard_flix/views/login.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hard_flix/views/moveis_list.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class UserRegister {
  String? id;
  final String? name;
  final String? email;
  final String? password;
  final String? confirmPassword;

  UserRegister(
      {this.id = '',
      required this.name,
      required this.email,
      required this.password,
      required this.confirmPassword});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword
      };
}

class _RegisterScreenState extends State<RegisterScreen> {
  final controllerName = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final controllerConfirmPassword = TextEditingController();

  Future createUser(UserRegister user) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc();

    user.id = docUser.id;

    final json = user.toJson();

    await docUser.set(json);
  }

  Future authCreateUser(String userEmail, String userPassword) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: userEmail, password: userPassword);

      Get.to(() => MoviesList(),
          transition: Transition.leftToRight,
          duration: const Duration(milliseconds: 350));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
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

  @override
  Widget build(BuildContext context) {
    Widget _monkey_image() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/hardflix-logo.png', width: 200.0, height: 200.0),
        ],
      );
    }

    Widget _buildNameTF() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Nome',
            style: kLabelStyle,
          ),
          const SizedBox(height: 10.0),
          Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 60.0,
            child: TextField(
              controller: controllerName,
              keyboardType: TextInputType.name,
              style:
                  const TextStyle(color: Colors.white, fontFamily: 'Poppins'),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                hintText: 'Nome',
                hintStyle: kHintTextStyle,
              ),
            ),
          )
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
              style:
                  const TextStyle(color: Colors.white, fontFamily: 'Poppins'),
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
              style:
                  const TextStyle(color: Colors.white, fontFamily: 'Poppins'),
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

    Widget _buildConfirmPasswordTF() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Confirmar Senha',
            style: kLabelStyle,
          ),
          const SizedBox(height: 10.0),
          Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 60.0,
            child: TextField(
              controller: controllerConfirmPassword,
              obscureText: true,
              style:
                  const TextStyle(color: Colors.white, fontFamily: 'Poppins'),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.black,
                ),
                hintText: 'Confirmar Senha',
                hintStyle: kHintTextStyle,
              ),
            ),
          )
        ],
      );
    }

    Widget _buildBackToLogin() {
      return Container(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: () {
            Get.to(() => LoginScreen(),
                transition: Transition.leftToRight,
                duration: const Duration(milliseconds: 350));
          },
          child: const Text(
            'Voltar ao Login',
            style: kLabelStyle,
          ),
        ),
      );
    }

    Widget _buildRegisterBtn() {
      return Container(
          padding: const EdgeInsets.symmetric(vertical: 25.0),
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              final user = UserRegister(
                  name: controllerName.text,
                  email: controllerEmail.text,
                  password: controllerPassword.text,
                  confirmPassword: controllerConfirmPassword.text);
              if (user.email == "" ||
                  user.password == "" ||
                  user.confirmPassword == "") {
                final dialog =
                    await openDialog("Preencha o formul??rio corretamente");
                if (dialog == null || dialog.isEmpty) return;
              } else if (user.password != user.confirmPassword) {
                final dialog = await openDialog("As senhas n??o est??o iguais");
                if (dialog == null || dialog.isEmpty) return;
              } else if (user.password!.length < 5) {
                final dialog = await openDialog("Senha fraca");
              } else {
                authCreateUser(controllerEmail.text, controllerPassword.text);
                createUser(user);
              }
            },
            style: styledButtonLogin,
            child: const Text(
              'CADASTRAR',
              style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 1.5,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins'),
            ),
          ));
    }

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
                  horizontal: 40.0,
                  vertical: 40.0,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _monkey_image(),
                      Container(
                        alignment: Alignment.center,
                        child: const Text('Crie Sua Conta',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontSize: 30,
                                fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 10.0),
                      // _buildNameTF(),
                      const SizedBox(height: 30.0),
                      _buildNameTF(),
                      const SizedBox(height: 30.0),
                      _buildEmailTF(),
                      const SizedBox(height: 30.0),
                      _buildPasswordTF(),
                      const SizedBox(height: 30.0),
                      _buildConfirmPasswordTF(),
                      _buildBackToLogin(),
                      _buildRegisterBtn()
                    ])),
          ),
        ],
      ),
    ));
  }
}
