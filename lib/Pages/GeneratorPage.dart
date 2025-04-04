import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

class Generatorpage extends StatefulWidget {
  const Generatorpage({super.key});

  @override
  State<Generatorpage> createState() => _GeneratorpageState();
}

class _GeneratorpageState extends State<Generatorpage> {
  final TextEditingController _passwordController = TextEditingController();
  double _passwordStrength = 0.0;
  Color _strengthColor = Colors.red;

  double _lowercaseCount = 4;
  double _uppercaseCount = 2;
  double _numberCount = 2;
  double _specialCount = 2;
  String _generatedPassword = '';

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _checkPasswordStrength(String password) {
    double strength = 0;

    if (password.isEmpty) {
      strength = 0;
    } else {
      if (password.length >= 8) strength += 0.3;

      if (password.contains(RegExp(r'[0-9]'))) strength += 0.2;

      if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) strength += 0.2;

      if (password.contains(RegExp(r'[A-Z]'))) strength += 0.15;

      if (password.contains(RegExp(r'[a-z]'))) strength += 0.15;
    }

    setState(() {
      _passwordStrength = strength;

      if (strength < 0.3) {
        _strengthColor = Colors.red[300]!;
      } else if (strength < 0.7) {
        _strengthColor = Colors.yellow;
      } else {
        _strengthColor = Colors.green[300]!;
      }
    });
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: _passwordController.text)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password copied to clipboard'),
          duration: Duration(seconds: 2),
        ),
      );
    });
  }

  void _generatePassword() {
    const lowercase = 'abcdefghijklmnopqrstuvwxyz';
    const uppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const numbers = '0123456789';
    const special = '!@#\$%^&*(),.?":{}|<>';

    String password = '';

    for (int i = 0; i < _lowercaseCount; i++) {
      password += lowercase[Random().nextInt(lowercase.length)];
    }

    for (int i = 0; i < _uppercaseCount; i++) {
      password += uppercase[Random().nextInt(uppercase.length)];
    }

    for (int i = 0; i < _numberCount; i++) {
      password += numbers[Random().nextInt(numbers.length)];
    }

    for (int i = 0; i < _specialCount; i++) {
      password += special[Random().nextInt(special.length)];
    }

    final shuffledPassword = password.split('')..shuffle();
    _generatedPassword = shuffledPassword.join();

    setState(() {
      _passwordController.text = _generatedPassword;
      _checkPasswordStrength(_generatedPassword);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text(
            'Generate Password',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 700,
                  width: 400,
                  margin: const EdgeInsets.fromLTRB(10, 12, 10, 10),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextField(
                          controller: _passwordController,
                          onChanged: _checkPasswordStrength,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.copy),
                              onPressed: _copyToClipboard,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Password Strength Meter
                        Container(
                          width: double.infinity,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: _passwordStrength,
                            child: Container(
                              decoration: BoxDecoration(
                                color: _strengthColor,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _passwordStrength < 0.3
                              ? 'Weak Password'
                              : _passwordStrength < 0.7
                                  ? 'Medium Password'
                                  : 'Strong Password',
                          style: TextStyle(
                            color: _strengthColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Lowercase Letters Slider
                        Text(
                          'Lowercase Letters (${_lowercaseCount.toInt()})',
                          style: const TextStyle(fontSize: 16),
                        ),
                        Slider(
                          value: _lowercaseCount,
                          min: 0,
                          max: 10,
                          divisions: 10,
                          onChanged: (value) {
                            setState(() {
                              _lowercaseCount = value;
                              _generatePassword();
                            });
                          },
                        ),
                        // Uppercase Letters Slider
                        Text(
                          'Uppercase Letters (${_uppercaseCount.toInt()})',
                          style: const TextStyle(fontSize: 16),
                        ),
                        Slider(
                          value: _uppercaseCount,
                          min: 0,
                          max: 10,
                          divisions: 10,
                          onChanged: (value) {
                            setState(() {
                              _uppercaseCount = value;
                              _generatePassword();
                            });
                          },
                        ),
                        // Numbers Slider
                        Text(
                          'Numbers (${_numberCount.toInt()})',
                          style: const TextStyle(fontSize: 16),
                        ),
                        Slider(
                          value: _numberCount,
                          min: 0,
                          max: 10,
                          divisions: 10,
                          onChanged: (value) {
                            setState(() {
                              _numberCount = value;
                              _generatePassword();
                            });
                          },
                        ),
                        // Special Characters Slider
                        Text(
                          'Special Characters (${_specialCount.toInt()})',
                          style: const TextStyle(fontSize: 16),
                        ),
                        Slider(
                          value: _specialCount,
                          min: 0,
                          max: 10,
                          divisions: 10,
                          onChanged: (value) {
                            setState(() {
                              _specialCount = value;
                              _generatePassword();
                            });
                          },
                        ),
                        const SizedBox(height: 24),
                        // Generate Button
                        ElevatedButton(
                          onPressed: _generatePassword,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                          ),
                          child: const Text(
                            'Generate New Password',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
