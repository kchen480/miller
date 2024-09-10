import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:miller/common/extension/int_ext.dart';
import 'package:miller/common/widgets/form.dart';
import 'package:miller/pages/register.dart';
import 'package:miller/pages/successful.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  late String _email, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
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
              // enter password
              50.sizedBoxH,
              buildLoginButton(context),
              // login button
              30.sizedBoxH,
              buildOtherLoginText(),
              // Log in with other account
              buildOtherMethod(context),
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
          'Login',
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

  Widget buildLoginButton(BuildContext context) {
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
            'Login',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            // Execution will continue only after the form verification passes.
            if ((_formKey.currentState as FormState).validate()) {
              (_formKey.currentState as FormState).save();
              print('email: $_email, password: $_password');
              login(_email, _password);
            }
          },
        ),
      ),
    );
  }

  Future login(String emailAddress, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      if (credential.user != null) {
        Get.to(() => const SuccessfulPage());
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
        msg: e.code,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
      );
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
          msg: 'No user found for that email.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
        );
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
          msg: 'Wrong password provided for that user.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
        );
      } else {
        // Fluttertoast.showToast(
        //   msg: 'Wrong !',
        //   toastLength: Toast.LENGTH_LONG,
        //   gravity: ToastGravity.CENTER,
        // );
      }
    }
  }

  Widget buildOtherLoginText() {
    return const Center(
      child: Text(
        'Log in with other account',
        style: TextStyle(color: Colors.grey, fontSize: 14),
      ),
    );
  }

  final List _loginMethod = [
    {
      "title": "facebook",
      "icon": Icons.facebook,
    },
    {
      "title": "google",
      "icon": Icons.fiber_dvr,
    },
  ];

  Widget buildOtherMethod(context) {
    return OverflowBar(
      alignment: MainAxisAlignment.center,
      children: _loginMethod
          .map((item) => Builder(builder: (context) {
                return IconButton(
                    icon: Icon(item['icon'],
                        color: Theme.of(context).iconTheme.color),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('${item['title']}log in'),
                            action: SnackBarAction(
                              label: 'cancel',
                              onPressed: () {},
                            )),
                      );
                    });
              }))
          .toList(),
    );
  }

  Widget buildRegisterText(context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Don’t have an account?'),
            GestureDetector(
              child: const Text('Click to register',
                  style: TextStyle(color: Colors.green)),
              onTap: () {
                Get.to(() => const RegisterPage());
              },
            )
          ],
        ),
      ),
    );
  }
}
