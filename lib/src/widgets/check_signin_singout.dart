import 'package:flutter/material.dart';

class CheckSignInSignOut extends StatelessWidget {
  final bool login;

  CheckSignInSignOut({this.login = true});
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? '¿No tienes una cuenta?' : '¿Ya tienes una cuenta?',
        ),
        SizedBox(
          width: 5.0,
        ),
        GestureDetector(
          onTap: () =>
              Navigator.pushNamed(context, login ? 'register' : 'login'),
          child: Text(
            login ? 'Regístrate aquí' : 'Iniciar Sesión',
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
