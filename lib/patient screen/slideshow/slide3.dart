import 'package:flutter/material.dart';
import 'package:medkitcare/styles/styles.dart';

import '../../styles/colors.dart';

class Slide3 extends StatelessWidget {
  const Slide3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Image.asset(
              'assets/slide3.JPG',
              height: 450.0,
            ),
            SizedBox(height: 15),
            Text('STRESS FREE BOOKING PROCESS', style: PoppinsStyle),
            SizedBox(height: 100),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/4');
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
        ),
      )),
    );
  }
}
