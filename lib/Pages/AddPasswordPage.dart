import 'package:flutter/material.dart';
import 'package:password_manager/Database/database_helper.dart';
import 'package:password_manager/Models/password_model.dart';

class AddPasswordPage extends StatefulWidget {
  const AddPasswordPage({super.key});

  @override
  State<AddPasswordPage> createState() => _AddPasswordPageState();
}

class _AddPasswordPageState extends State<AddPasswordPage> {
  final TextEditingController _siteController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _savePassword(BuildContext context) async {
    final newPassword = PasswordModel(
      domain: _siteController.text,
      username: _usernameController.text,
      password: _passwordController.text,
      iconUrl: await PasswordModel.fetchIconUrl(_siteController.text),
    );

    await DatabaseHelper().addPassword(newPassword);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Add Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _siteController,
              decoration: const InputDecoration(
                labelText: 'Site',
                hintText: "Eg. instagram.com...",
              ),
            ),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _savePassword(context),
              child: const Text('Save Password'),
            ),
          ],
        ),
      ),
    );
  }
}
