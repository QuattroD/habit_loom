import 'package:flutter/material.dart';
import 'package:habit_loom/DB/model.dart';
import 'package:habit_loom/DB/service.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

TextEditingController login = TextEditingController();
TextEditingController password = TextEditingController();

DbConnection dbconnection = DbConnection();

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool sign = false;
    return Stack(
      children: [
        Scaffold(
            body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/bg.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
                child: Container(
              padding: const EdgeInsets.only(top: 40),
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.45,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.7),
                      spreadRadius: 3,
                      blurRadius: 7,
                    ),
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  border: Border.all(color: Colors.white, width: 1.0)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedTextKit(
                        animatedTexts: [
                          WavyAnimatedText('HabitLoom', textStyle: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),                      
                        ],
                        isRepeatingAnimation: false,                    
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      controller: login,
                      style: const TextStyle(color: Colors.white),
                      cursorColor: const Color.fromARGB(255, 233, 241, 243),
                      decoration: InputDecoration(
                        hintText: "Enter login",
                        hintStyle: const TextStyle(color: Colors.white),
                        label: const Text(
                          "Login",
                        ),
                        labelStyle: const TextStyle(
                            color: Color.fromARGB(255, 233, 241, 243)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 233, 241, 243))),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 233, 241, 243))),
                        prefixIcon: const Icon(
                          Icons.login,
                          color: Color.fromARGB(255, 233, 241, 243),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      controller: password,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 233, 241, 243)),
                      obscureText: true,
                      cursorColor: const Color.fromARGB(255, 233, 241, 243),
                      decoration: InputDecoration(
                        hintText: "Enter password",
                        hintStyle: const TextStyle(color: Colors.white),
                        label: const Text(
                          "Password",
                        ),
                        labelStyle: const TextStyle(
                            color: Color.fromARGB(255, 233, 241, 243)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 233, 241, 243))),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 233, 241, 243))),
                        prefixIcon: const Icon(
                          Icons.password,
                          color: Color.fromARGB(255, 233, 241, 243),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: ElevatedButton(
                      style: const ButtonStyle(
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.transparent),
                      ),
                      onPressed: () async {
                        UserModel? user = await dbconnection.signIn(
                            login.text, password.text);
                        if (user != null) {
                        } else {
                          // ignore: use_build_context_synchronously
                          showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor:
                                     Colors.black,
                                title: const Text('Error',
                                    style: TextStyle(
                                        color: Color.fromARGB(
                                            255, 233, 241, 243))),
                                content: const Text(
                                    'Invalid E-mail or Password',
                                    style: TextStyle(
                                        color: Color.fromARGB(
                                            255, 233, 241, 243))),
                                actions: <Widget>[
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                    ),
                                    child: const Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                          return;
                        }
                        Navigator.pushNamed(context, '/home');
                      },
                      child: sign == false
                          ? const Text(
                              "Sign In",
                              style: TextStyle(fontSize: 20),
                            )
                          : const Text(
                              "Sign Up",
                              style: TextStyle(fontSize: 20),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  InkWell(
                    child: const Text(
                      "Sign Up?",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/reg');
                    },
                  ),
                ],
              ),
            )),
          ),
        ))
      ],
    );
  }
}
