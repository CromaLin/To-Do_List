import 'package:flutter/material.dart';
// import 'todo.dart';
// import 'calendar.dart';

String email = "";
String senha = "";

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                onChanged: (text) {
                  email = text;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ), //Esse TextFiel é do box do email
              SizedBox(height: 10),
              TextField(
                onChanged: (text) {
                  senha = text;
                },
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Senha',
                ),
              ), //Esse TextFiel é do box da senha
              SizedBox(height: 10),
              ElevatedButton(
                child: Text('Logar'),
                onPressed: () {
                  if (email == 'ma@gmail.com' && senha == '123') {
                    // o .push empilha a tela e o .pushReplacement tira do empilhamento as as paginas anteriores, no caso essa
                    /*Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => CalendarPage()),
                    );*/
                    Navigator.of(context).pushReplacementNamed('/calendar');
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Login incorreto'),
                          content: Text(
                            'Por favor tente novamente com o login e senha corretos',
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(
                                  context,
                                ); //close Dialog (o .pop desempilha as telas)
                              },
                              child: Text('Fechar'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
