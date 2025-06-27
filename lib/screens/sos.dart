import 'package:flutter/material.dart';

class SosScreen extends StatelessWidget {
  const SosScreen({super.key});

  Widget customBackButton(BuildContext context) {
    return IconButton(
      icon: Image.asset(
        'lib/assets/images/icon/back2.png',
        width: 24,
        height: 24,
      ),
      onPressed: () => Navigator.pop(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Emergency Services:"),
        leading: customBackButton(context),
      ),
      body: const Center(child: Text("National Emergency Hotline Number: 999 \n"
                                     "National helpline center for violence against women:10921\n"
                                     "Mental Health & Psychosocial helpline: 01688709965/01688709966")),
    );
  }
}