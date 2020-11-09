import 'package:flutter/material.dart';
import 'package:gothaer/pages/minesweeper_page.dart';

void main() => runApp(MinesweeperApp());

/// The root app.
class MinesweeperApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Gothaer Minesweeper',
      home: MinesweeperPage(),
    );
  }
}
