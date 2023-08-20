import 'package:flutter/material.dart';
import 'package:medkitcare/styles/styles.dart';

import '../../styles/colors.dart';

class Slide2 extends StatelessWidget {
  const Slide2({Key? key}) : super(key: key);

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
            'assets/slide2.WEBP',
            height: 450.0,
          ),
          SizedBox(height: 25),
          Text('CAPABLE HANDS TO DO THE JOB', style: PoppinsStyle),
          SizedBox(height: 100),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/3');
                    },
                    child: Text("Next>",
                        style: TextStyle(color: Color(MyColors.primary)))),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/4');
                    },
                    child: Text("Skip>>",
                        style: TextStyle(color: Color(MyColors.primary)))),
              ],
            ),
          )
        ],
      )),
    );
  }
}
