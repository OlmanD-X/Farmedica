import 'package:appfarmedica/src/providers/user_provider.dart';
import 'package:appfarmedica/src/widgets/check_signin_singout.dart';
import 'package:appfarmedica/src/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final _userProvider = UserProvider();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dniController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _namesController = TextEditingController();
  final TextEditingController _lastNamesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 40.0,
              ),
              Text(
                'REGISTRARSE',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                ),
              ),
              SizedBox(
                height: 60.0,
              ),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.person,
                    color: Colors.blue,
                    size: 30.0,
                  ),
                  labelText: 'Usuario',
                  hintText: 'Nombre de usuario',
                ),
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.lock,
                    color: Colors.blue,
                    size: 30.0,
                  ),
                  labelText: 'Clave',
                  hintText: 'Clave',
                  suffixIcon: Icon(
                    Icons.visibility,
                    color: Colors.blue,
                  ),
                ),
              ),
              TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.lock,
                    color: Colors.blue,
                    size: 30.0,
                  ),
                  labelText: 'Confirmar Clave',
                  hintText: 'Clave',
                  suffixIcon: Icon(
                    Icons.visibility,
                    color: Colors.blue,
                  ),
                ),
              ),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.email,
                    color: Colors.blue,
                    size: 30.0,
                  ),
                  labelText: 'Email',
                  hintText: 'Email',
                ),
              ),
              TextField(
                controller: _dniController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.card_membership,
                    color: Colors.blue,
                    size: 30.0,
                  ),
                  labelText: 'DNI',
                  hintText: 'DNI',
                ),
              ),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.smartphone,
                    color: Colors.blue,
                    size: 30.0,
                  ),
                  labelText: 'Celular',
                  hintText: 'Celular',
                ),
              ),
              TextField(
                controller: _namesController,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.person,
                    color: Colors.blue,
                    size: 30.0,
                  ),
                  labelText: 'Nombres',
                  hintText: 'Nombres',
                ),
              ),
              TextField(
                controller: _lastNamesController,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.person,
                    color: Colors.blue,
                    size: 30.0,
                  ),
                  labelText: 'Apelllidos',
                  hintText: 'Apellidos',
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              RoundedButton(
                f: () async {
                  final response = await _userProvider.register(
                    username: _usernameController.text,
                    password: _passwordController.text,
                    confirmPassword: _confirmPasswordController.text,
                    dni: _dniController.text,
                    email: _emailController.text,
                    phone: _phoneController.text,
                    name: _namesController.text,
                    lastName: _lastNamesController.text,
                  );
                  if (response['status'] == 'Exito') {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Exito'),
                          content: Text(
                              'Te has registrado exitosamente. Ahora ya puedes iniciar sesión.'),
                          actions: [
                            FlatButton(
                              onPressed: () => Navigator.of(context)
                                  .pushNamedAndRemoveUntil(
                                      'login', ModalRoute.withName('home')),
                              child: Text('OK'),
                            )
                          ],
                        );
                      },
                    );
                  } else {
                    String errorMessage = response['message'] ?? "Error";
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Error'),
                          content: Text(errorMessage),
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
                text: 'REGISTRAR',
                textColor: Colors.white,
                color: Colors.blue,
              ),
              SizedBox(
                height: 10.0,
              ),
              CheckSignInSignOut(
                login: false,
              ),
            ],
          )
        ],
      ),
    );
  }
}
