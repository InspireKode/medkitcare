import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medkitcare/styles/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../styles/colors.dart';
import '../widget/snackbar.dart';

class DocSignInPage extends StatefulWidget {
  const DocSignInPage({Key? key}) : super(key: key);

  @override
  State<DocSignInPage> createState() => _DocSignInPageState();
}

class _DocSignInPageState extends State<DocSignInPage> {

  late String title;
  late String email;
  late String password;
  late String fname;
  late String lname;
  bool isProcessing = false;

  final _formKey = GlobalKey<FormState>();
  bool isSelected = false;
  final emailFocusNode = FocusNode();
  final pwdFocusNode = FocusNode();

  void _OnSubmitFormDocSignIn() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    FocusScope.of(context).unfocus();
    if (isValid) {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLoggedIn', true);

        setState(() {
          isProcessing = true;
        });
        MyMessageHandler.showToast(
            Colors.greenAccent, 'successfully logged in', Colors.white);
        _formKey.currentState?.reset();


        Navigator.pushReplacementNamed(context, '/DocHome');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          setState(() {
            isProcessing = false;
          });
          MyMessageHandler.showToast(
              Colors.red, 'User does not exist', Colors.white);
        } else if (e.code == 'wrong-password') {
          setState(() {
            isProcessing = false;
          });
          MyMessageHandler.showToast(
              Colors.red, 'wrong password', Colors.white);
        }
      }
    } else {
      setState(() {
        isProcessing = false;
      });
      MyMessageHandler.showToast(
          Colors.red, 'Please fill all fields', Colors.white);
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
          key: _formKey,
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: TextFormField(
                  onChanged: (value) {
                    email = (value);
                  },
                  focusNode: pwdFocusNode,
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
                    password = (value);
                  },
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
                  child: Text('Sign in'),
                  onPressed: () {
                    _OnSubmitFormDocSignIn();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      child: Text(
                        'Forgot Password?',
                        style: PoppinsStyle,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/pwd_reset');
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          child: Text(
                            'New here? Sign Up',
                            style: PoppinsStyle,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/DocSignUp');
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
