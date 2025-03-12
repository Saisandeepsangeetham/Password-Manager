import 'package:flutter/material.dart';
import '../Models/getMasterPassword.dart';
import 'HomePage.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isObsecured = true;
  final _passwordController = TextEditingController();

  _loginUser() async {
    String password = _passwordController.text.trim();

    if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter password field")),
      );
      return;
    }
    try {
      String? masterPassword = await SharedPreferencesUtils.getMasterPassword();
      if (masterPassword == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("No password found. Please register first.")),
        );
        return;
      }
      if (masterPassword == password) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Homepage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Incorrect password. Try again.")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(
              fontSize: 25.0, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.indigoAccent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
            child: Form(
              child: Column(
                children: [
                  SizedBox(height: size.width * 0.07),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Center(
                      child: Container(
                        width: 150.0,
                        height: 150.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Colors.blueGrey),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Image(image: AssetImage('assets/login.jpg')),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.width * 0.02),
                  Text(
                    "Enter your Master Password",
                    style:
                        TextStyle(fontSize: 18.0, color: Colors.grey.shade600),
                  ),
                  SizedBox(height: size.width * 0.04),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      obscureText: isObsecured,
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        labelText: "Password",
                        filled: true,
                        border: const OutlineInputBorder(),
                        suffix: InkWell(
                          child: Icon(
                            isObsecured
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onTap: () {
                            setState(() {
                              isObsecured = !isObsecured;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.width * 0.04),
                  ElevatedButton(
                    onPressed: _loginUser,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      backgroundColor: Colors.indigoAccent,
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 18.0, color: Colors.white70),
                    ),
                  ),
                  SizedBox(height: size.width * 0.10),
                  const Text(
                    '\nOnce you save a password, you\'ll '
                    'always have it when you need it. logging in is fast '
                    'and easy. And the password is securely stored!',
                    style: TextStyle(
                        fontSize: 13.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
