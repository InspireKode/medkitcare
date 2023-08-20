import 'package:flutter/material.dart';
import 'package:medkitcare/styles/styles.dart';

import '../../styles/colors.dart';

class Slide4 extends StatelessWidget {
  const Slide4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
          ),
          Image.asset(
            'assets/slide4.JPG',
            height: 450.0,
          ),
          SizedBox(height: 25),
          Text('WORKING TOGETHER TO SAVE LIVES', style: PoppinsStyle),
          SizedBox(height: 100),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/options');
                    },
                    child: Text("Finish",
                        style: TextStyle(color: Color(MyColors.primary)))),
              ],
            ),
          )
        ],
      )),
    );
  }
}
