import 'package:flutter/material.dart';
import 'package:medkitcare/styles/styles.dart';

import '../styles/colors.dart';

class Loginoption extends StatefulWidget {
  const Loginoption({super.key});

  @override
  State<Loginoption> createState() => _LoginoptionState();
}

class _LoginoptionState extends State<Loginoption> {
  String _catValue = 'Doc';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(MyColors.primary),
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                height: 150,
                width: 150,
                child: Image(
                  image: AssetImage('assets/logo.PNG'),
                ),
              ),
              Text(
                'MedKare',
                style: PoppinsTitle,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Sign in as:",
                style: PoppinsTitleblack,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    style: TextStyle(
                      color: Color(MyColors.primary),
                      fontWeight: FontWeight.w600,
                      fontSize: 19,
                    ),
                    value: _catValue,
                    onChanged: (value) {
                      setState(() {
                        _catValue = value!;
                      });
                    },
                    hint: Text(
                      'Sign in as',
                      style: PoppinsTitle,
                    ),
                    items: const [
                      DropdownMenuItem(
                        child: Text(
                          'Doctor',
                          style: TextStyle(fontSize: 20),
                        ),
                        value: 'Doc',
                      ),
                      DropdownMenuItem(
                        child: Text('Nurse', style: TextStyle(fontSize: 20)),
                        value: 'Nurse',
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/DocSignIn');
                  },
                  child: Text(
                    'Continue',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  color: Color(MyColors.primary),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                "Sign in as a Patient",
                style: PoppinsTitleblack,
              ),
              SizedBox(height: 20),
              Container(
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/.');
                  },
                  child: Text(
                    'Continue',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  color: Color(MyColors.primary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
