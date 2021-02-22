import 'package:appfarmedica/src/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50.0,
            ),
            Text(
              'FARMEDICA',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                fontSize: 36.0,
              ),
            ),
            Image.asset(
              'assets/images/welcome.png',
              height: 360.0,
            ),
            RoundedButton(
              f: () => Navigator.pushNamed(context, 'login'),
              color: Colors.blue,
              textColor: Colors.white,
              text: 'INICIAR SESIÓN',
            ),
            SizedBox(
              height: 20.0,
            ),
            RoundedButton(
              f: () => Navigator.pushNamed(context, 'register'),
              color: Color.fromRGBO(190, 231, 252, 1),
              textColor: Colors.black,
              text: 'CREAR CUENTA',
            ),
          ],
        ),
      ),
    );
  }
}
