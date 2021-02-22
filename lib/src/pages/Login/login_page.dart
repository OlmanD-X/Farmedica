import 'package:appfarmedica/src/providers/user_provider.dart';
import 'package:flutter/material.dart';

import 'package:appfarmedica/src/widgets/rounded_button.dart';
import 'package:appfarmedica/src/widgets/check_signin_singout.dart';

class LoginPage extends StatelessWidget {
  final _userProvider = UserProvider();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(top: 100.0),
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 29.0,
              ),
              Text(
                'LOGIN',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                  color: Colors.blue,
                ),
              ),
              SizedBox(
                height: 60.0,
              ),
              Image.asset(
                'assets/images/enfermera.png',
                height: 162.0,
              ),
              SizedBox(
                height: 41.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                padding: EdgeInsets.symmetric(
                  horizontal: 15.0,
                ),
                width: size.width * 0.75,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Color.fromRGBO(190, 231, 252, 1),
                ),
                child: TextField(
                  controller: _controllerUsername,
                  decoration: InputDecoration(
                    labelText: 'Usuario',
                    hintText: 'Nombre de usuario',
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.account_circle,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                padding: EdgeInsets.symmetric(
                  horizontal: 15.0,
                ),
                width: size.width * 0.75,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Color.fromRGBO(190, 231, 252, 1),
                ),
                child: TextField(
                  controller: _controllerPassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.visibility),
                      color: Colors.blue,
                    ),
                    labelText: 'Password',
                    hintText: 'Password',
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.lock,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              RoundedButton(
                f: () async {
                  final response = await _userProvider.login(
                      _controllerUsername.text, _controllerPassword.text);

                  if (response['status'] == null) {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('citas', (route) => false);
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Información Incorrecta'),
                          content: Text(response['message']),
                          actions: [
                            FlatButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text('OK'),
                            )
                          ],
                        );
                      },
                    );
                  }
                },
                text: 'INICIAR SESIÓN',
                textColor: Colors.white,
                color: Colors.blue,
              ),
              SizedBox(
                height: 10.0,
              ),
              CheckSignInSignOut(),
            ],
          ),
        ],
      ),
    );
  }
}
