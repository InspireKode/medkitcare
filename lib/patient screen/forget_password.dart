import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:medkitcare/styles/styles.dart';

import '../styles/colors.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formkey = GlobalKey<FormState>();
  bool isSelected = false;
  final emailCTR = TextEditingController();
  final emailFocusNode = FocusNode();
  void ResetPassword() {
    final isValid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(MyColors.primary),
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Form(
          key: _formkey,
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  height: 150,
                  width: 150,
                  child: Image(
                    image: AssetImage('assets/logo.PNG'),
                  ),
                ),
              ),
              Text(
                'MedKare',
                style: PoppinsTitle,
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: TextFormField(
                  controller: emailCTR,
                  focusNode: emailFocusNode,
                  validator: (value) {
                    if (value!.isEmpty || value.contains('@')) {
                      return "Invalid Email";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      hintText: 'Input Email',
                      suffixIcon: Icon(Icons.mail),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .9,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color(MyColors.primary),
                    ),
                  ),
                  child: Text('Reset Password'),
                  onPressed: () {
                    ResetPassword();
                  },
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
