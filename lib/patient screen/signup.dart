import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medkitcare/styles/styles.dart';

import '../styles/colors.dart';
import '../widget/snackbar.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  CollectionReference patients =
      FirebaseFirestore.instance.collection('patients');
  late String _uid;
  late String email;
  late String password;
  late String fname;
  late String lname;
  late String address;
  bool isProcessing = false;
  final _formkey = GlobalKey<FormState>();
  bool isSelected = false;

  final _lastNameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final pwdFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  void _onSubmitSignUp() async {
    final isValid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        _uid = FirebaseAuth.instance.currentUser!.uid;

        await patients.doc(_uid).set({
          'fname': fname,
          'lname': lname,
          'email': email,
          'address': '',
          'patientid': _uid,
        });
        MyMessageHandler.showToast(
            Colors.greenAccent, 'successful.', Colors.white);
        _formKey.currentState!.reset();
        Navigator.pushNamed(context, "/.");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          setState(() {
            isProcessing = false;
          });
          MyMessageHandler.showToast(
              Colors.black, 'The password provided is too weak.', Colors.white);
        } else if (e.code == 'email-already-in-use') {
          setState(() {
            isProcessing = false;
          });
          MyMessageHandler.showToast(Colors.black,
              'The account already exists for that email.', Colors.white);
        }
      }
    } else {
      setState(() {
        isProcessing = false;
      });
      MyMessageHandler.showToast(
          Colors.black, 'please fill all fields', Colors.white);
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
      body: SafeArea(
          child: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  onChanged: (value) {
                    fname = (value);
                  },
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () =>
                      FocusScope.of(context).requestFocus(_lastNameFocusNode),
                  validator: (value) {
                    if (value!.isEmpty || value.length <= 3) {
                      return "Invalid input";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      hintText: 'First name',
                      suffixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: TextFormField(
                  onChanged: (value) {
                    lname = (value);
                  },
                  focusNode: _lastNameFocusNode,
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () =>
                      FocusScope.of(context).requestFocus(emailFocusNode),
                  validator: (value) {
                    if (value!.isEmpty || value.length <= 3) {
                      return "Invalid input";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      hintText: 'Last name',
                      suffixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: TextFormField(
                  onChanged: (value) {
                    email = (value);
                  },
                  focusNode: emailFocusNode,
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () =>
                      FocusScope.of(context).requestFocus(_addressFocusNode),
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return "Invalid Email";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      hintText: 'Email',
                      suffixIcon: Icon(Icons.mail),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: TextFormField(
                  onChanged: (value) {
                    address = (value);
                  },
                  focusNode: _addressFocusNode,
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () =>
                      FocusScope.of(context).requestFocus(pwdFocusNode),
                  validator: (value) {
                    if (value!.isEmpty || value.length <= 3) {
                      return "Invalid Address";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      hintText: 'Address',
                      suffixIcon: Icon(Icons.home),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: TextFormField(
                  onChanged: (value) {
                    password = (value);
                  },
                  focusNode: pwdFocusNode,
                  textInputAction: TextInputAction.done,
                  onEditingComplete: _onSubmitSignUp,
                  validator: (value) {
                    if (value!.length < 5) {
                      return "Password too weak ";
                    } else if (value.isEmpty) {
                      return "Password can not be empty";
                    }
                    return null;
                  },
                  obscureText: isSelected,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isSelected = !isSelected;
                            });
                          },
                          icon: isSelected
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility)),
                      hintText: 'Password',
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
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                          fontFamily: GoogleFonts.poppins().fontFamily),
                    ),
                    onPressed: () {
                      _onSubmitSignUp();
                    }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: Text(
                        'Already have an account? Sign In',
                        style: PoppinsStyle,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/.');
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
