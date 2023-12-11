import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:node_flutter_movie/auth/signup.dart';
import 'package:node_flutter_movie/home.dart';

class logInPage extends StatefulWidget {
  const logInPage({super.key});

  @override
  State<logInPage> createState() => _logInPageState();
}

class _logInPageState extends State<logInPage> {
  TextEditingController usernameControler = TextEditingController();
  TextEditingController passwordControler = TextEditingController();
  bool userError = false;
  bool passError = false;

  Future<bool> sendReq(String username, String password) async {
    final response = await http.post(
      Uri.parse('http://192.168.0.100:5000/qwerty123/getuser'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    Map map = jsonDecode(response.body) as Map<String, dynamic>;

    if (map['acknowledged'] == true) {
      return true;
    } else {
      if (map['acknowledged'] == false) {
        print("username error");
        userError = true;
      } else {
        print("pass error");
        passError = true;
      }
      setState(() {});
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 200),
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Log In",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: usernameControler,
                decoration: InputDecoration(
                  errorText: userError ? "username not exist" : null,
                  hintText: 'username',
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: passwordControler,
                decoration: InputDecoration(
                  errorText: passError ? "password error" : null,
                  hintText: 'Password',
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(56),
                    backgroundColor: Colors.deepPurple),
                onPressed: () async {
                  userError = false;
                  passError = false;
                  setState(() {});
                  if (usernameControler.value.text.isNotEmpty &&
                      passwordControler.value.text.isNotEmpty) {
                    if (await sendReq(usernameControler.value.text,
                        passwordControler.value.text)) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const homePage()),
                          (route) => false);
                    }
                  }
                },
                child: const Text(
                  "Login",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(56),
                    backgroundColor: Colors.white),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const signUpPage()),
                  );
                },
                child: const Text(
                  "register",
                  style: TextStyle(fontSize: 18, color: Colors.deepPurple),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const homePage()),
                        (route) => false);
                  },
                  child: const Text(
                    "Enter as a guest",
                    style: TextStyle(color: Colors.deepPurple),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
