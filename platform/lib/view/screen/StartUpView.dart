import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StartUpView extends StatefulWidget {
  const StartUpView({Key? key}) : super(key: key);

  @override
  State<StartUpView> createState() => _StartUpViewState();
}

class _StartUpViewState extends State<StartUpView> {
  Timer? _timer;
  int _count = 3;
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _count--;
      });
      if (_count <= 0) {
        goToLoginView();
      }
    });
  }

  void goToLoginView() {
    _timer?.cancel();
    Get.offAndToNamed("/login");
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/login_bg.jpg",
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top + 10,
          right: 10,
          child: _clipButtom(),
        ),
      ],
    );
  }

  Widget _clipButtom() {
    return GestureDetector(
      onTap: () {
        goToLoginView();
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Container(
          width: 50,
          height: 50,
          color: Colors.black.withOpacity(0.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "跳过",
                style: TextStyle(
                    fontSize: 12, color: Colors.white, decoration: null),
              ),
              Text(
                "${_count}s",
                style: TextStyle(
                    fontSize: 12, color: Colors.white, decoration: null),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
