import 'package:flutter/material.dart';
import 'package:medkitcare/styles/colors.dart';
import 'package:medkitcare/styles/styles.dart';

class Slide1 extends StatelessWidget {
  const Slide1({Key? key}) : super(key: key);

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
              'assets/slide1.JPG',
              height: 450.0,
            ),
            SizedBox(height: 25),
            Text(
              'HELLO THERE, WELCOME ON BOARD',
              style: PoppinsStyle,
            ),
            SizedBox(height: 100),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/2');
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
      ),
    );
  }
}
