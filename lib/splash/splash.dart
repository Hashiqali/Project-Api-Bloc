import 'package:flutter/material.dart';
import 'package:project_patch/api%20service/functions.dart';
import 'package:project_patch/homescreen/homecreen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    splashtime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircleAvatar(
          backgroundColor: Colors.teal,
          radius: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.content_paste_outlined,
                size: 70,
                color: Colors.white,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  'Welcome To NotePad',
                  style: TextStyle(
                      fontFamily: 'Hashi',
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  splashtime() async {
    allItems = await getallnotes();
    await Future.delayed(const Duration(seconds: 2));
    // ignore: use_build_context_synchronously
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => Homescreen()));
  }
}
