import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:miller/common/extension/int_ext.dart';
import 'package:miller/common/widgets/form.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<RegisterPage> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  late String _email, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              30.sizedBoxH,
              // The height of one toolbar from the top
              buildTitle(),
              // Login
              buildTitleLine(),
              // underline under title
              50.sizedBoxH,
              FormTextField(
                topic: "Email Address",
                warningText: "Please enter a correct email address",
                onSaved: (String text) {
                  _email = text;
                },
              ),
              // enter email
              30.sizedBoxH,
              FormTextField(
                isPasswordField: true,
                topic: 'Password',
                onSaved: (String text) {
                  _password = text;
                },
              ),
              30.sizedBoxH,
              FormTextField(
                isPasswordField: true,
                topic: 'Confirm Password',
                onSaved: (String text) {
                  _password = text;
                },
              ),
              // enter password
              50.sizedBoxH,
              buildRegisterButton(context),
              30.sizedBoxH,
              // Log in with other account
              // Other login methods
              buildRegisterText(context),
              // register
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTitle() {
    return const Padding(
        padding: EdgeInsets.all(8),
        child: Text(
          'Register',
          style: TextStyle(fontSize: 42),
        ));
  }

  Widget buildTitleLine() {
    return Padding(
        padding: const EdgeInsets.only(left: 12.0, top: 4.0),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            color: Colors.black,
            width: 40,
            height: 2,
          ),
        ));
  }

  Widget buildRegisterButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 45,
        width: 270,
        child: ElevatedButton(
          style: ButtonStyle(
            // set rounded corners
              shape: WidgetStateProperty.all(const StadiumBorder(
                  side: BorderSide(style: BorderStyle.none)))),
          child: const Text(
            'SIGN UP',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            // Execution will continue only after the form verification passes.
            if ((_formKey.currentState as FormState).validate()) {
              (_formKey.currentState as FormState).save();
              print('email: $_email, password: $_password');
              signUp(_email, _password);
            }
          },
        ),
      ),
    );
  }

  Future signUp(String emailAddress, String password) async {
    // login 注册
    try {
      final credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      Fluttertoast.showToast(
        msg: 'Successful',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
      );
      Get.back();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(
          msg: 'The password provided is too weak.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
        );
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
          msg: 'The account already exists for that email.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
        );
      }
    } catch (e) {
      print(e);
    }
  }




  Widget buildRegisterText(context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Already have an account?'),
            GestureDetector(
              child: const Text('Click to login',
                  style: TextStyle(color: Colors.green)),
              onTap: () {
                Get.back();
              },
            )
          ],
        ),
      ),
    );
  }
}
