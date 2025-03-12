import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'HomePage.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isObsecured = true;
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  _registerUser() async {
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    if (password.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter both password fields.")),
      );
    } else if (password.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Password must be at least 8 characters long.")),
      );
    } else if (!RegExp(r'(?=.*?[#?!@$%^&*-])').hasMatch(password)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text("Password must contain at least one special character.")),
      );
    } else if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match.")),
      );
    } else {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('password', password);
        await prefs.setInt('onBoard', 0);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Homepage()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error saving data: $e")),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Password Manager',
            style: TextStyle(
                fontSize: 25.0,
                color: Colors.white70,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.indigoAccent,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text("")
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Center(
                    child: Container(
                      width: 110.0,
                      height: 110.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.blueGrey),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Image(image: AssetImage('assets/logo.png')),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.width * 0.07,
                ),
                Text(
                  'Register a New Master Password',
                  style: TextStyle(fontSize: 18.0, color: Colors.grey.shade600),
                ),
                SizedBox(
                  height: size.width * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    obscureText: isObsecured,
                    controller: _passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      filled: true,
                      border: const OutlineInputBorder(),
                      suffix: InkWell(
                        child: Icon(
                          isObsecured ? Icons.visibility : Icons.visibility_off,
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
                SizedBox(
                  height: 1,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    obscureText: isObsecured,
                    controller: _confirmPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      filled: true,
                      border: const OutlineInputBorder(),
                      suffix: InkWell(
                        child: Icon(
                          isObsecured ? Icons.visibility : Icons.visibility_off,
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
                SizedBox(
                  height: size.width * 0.03,
                ),
                ElevatedButton(
                    onPressed: _registerUser,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      backgroundColor: Colors.indigoAccent,
                    ),
                    child: const Text(
                      'Register',
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  height: size.width * 0.14,
                ),
                const Text(
                  'Note that if the master password is lost,the stored '
                  'data cannot be recovered because of the missing '
                  'sync option. it is strongly recommended that you '
                  'remember your Master Password',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
