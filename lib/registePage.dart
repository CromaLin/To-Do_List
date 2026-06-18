import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String nome = '';
  String email = '';
  String senha = '';
  String confirmarSenha = '';

  void _realizarCadastro() {
    if (nome.isEmpty ||
        email.isEmpty ||
        senha.isEmpty ||
        confirmarSenha.isEmpty) {
      _mostrarMensagem('Campos obrigatórios', 'Preencha todos os campos.');
      return;
    }

    if (senha != confirmarSenha) {
      _mostrarMensagem(
        'Senhas diferentes',
        'A confirmação de senha não corresponde.',
      );
      return;
    }

    _mostrarMensagem('Cadastro realizado', 'Usuário cadastrado com sucesso!');
  }

  void _mostrarMensagem(String titulo, String mensagem) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(mensagem),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro'), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Icon(Icons.person_add, size: 80),

              const SizedBox(height: 24),

              TextField(
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                onChanged: (value) {
                  nome = value;
                },
              ),

              const SizedBox(height: 16),

              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                onChanged: (value) {
                  email = value;
                },
              ),

              const SizedBox(height: 16),

              TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                onChanged: (value) {
                  senha = value;
                },
              ),

              const SizedBox(height: 16),

              TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirmar Senha',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock_outline),
                ),
                onChanged: (value) {
                  confirmarSenha = value;
                },
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _realizarCadastro,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text('Cadastrar'),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Já possui uma conta? Fazer login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
