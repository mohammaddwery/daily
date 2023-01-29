import 'package:flutter/material.dart';

import '../board_screen/board_srceen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Expanded(child: BoardScreen()),
      ],
    );
  }
}
