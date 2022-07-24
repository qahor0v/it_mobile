import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:video_urok/pages/intro/sign_up.dart';

class MyNamePage extends StatefulWidget {
  static const String id = 'signup';

  const MyNamePage({Key? key}) : super(key: key);

  @override
  State<MyNamePage> createState() => _MyNamePageState();
}

class _MyNamePageState extends State<MyNamePage> {
  TextEditingController name = TextEditingController();
  TextEditingController soha = TextEditingController();

  final myBox = Hive.box('listBox');

  void next() {
    String _name = name.text.trim();
    String _soha = soha.text.trim();
    if (_name.length > 3 && _soha.isNotEmpty) {
      myBox.put("name", _name);
      myBox.put("soha", _soha);
      Navigator.push(context, MaterialPageRoute(builder: (_)=>SignUp()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Xatolik! Ismingiz va sohangizni to'g'ri kiriting!"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.white,
            spreadRadius: 3,
            blurRadius: 7,
            blurStyle: BlurStyle.normal,
          )
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.indigo,
            Colors.blue.shade400,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              const Text(
                "Assalomu Alaykum",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Xush Kelibsiz!",
                style: TextStyle(
                  color: Colors.yellow,
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 35,
                  right: 35,
                ),
                child: Column(
                  children: [
                    TextFormField(
                      controller: name,
                      decoration: const InputDecoration(
                        hintText: "ISMINGIZNI KIRITING",
                        hintStyle:
                            TextStyle(color: Colors.white70, fontSize: 12),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      // obscureText: isShow,
                      controller: soha,
                      decoration:const InputDecoration(
                        hintText: "SOHANGIZNI KIRITING (MASALAN: FRONTEND)",
                        hintStyle:  TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                        enabledBorder:  UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  bottom: 20,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    next();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                    ),
                  ),
                  child: const Text(
                    "DAVOM ETISH",
                    style: TextStyle(
                      color: Colors.indigo,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
