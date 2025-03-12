import 'package:flutter/material.dart';

class Generatorpage extends StatefulWidget {
  const Generatorpage({super.key});

  @override
  State<Generatorpage> createState() => _GeneratorpageState();
}

class _GeneratorpageState extends State<Generatorpage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // ...List.generate(3, (index) => _buildListItem())
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
