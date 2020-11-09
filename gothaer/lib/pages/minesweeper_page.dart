import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gothaer/data/coordinates.dart';
import 'package:gothaer/data/game.dart';
import 'package:gothaer/widgets/mine_tile_widget.dart';

/// The page that displays the minesweeper game.
class MinesweeperPage extends StatefulWidget {
  /// Default constructor.
  const MinesweeperPage();

  @override
  _MinesweeperPageState createState() => _MinesweeperPageState();
}

class _MinesweeperPageState extends State<MinesweeperPage> {
  /// Size of the game.
  int size;

  @override
  void initState() {
    super.initState();
    size = 10;
    _startGame();
  }

  void _startGame() {
    MinesweeperGame().start(size);
    setState(() {});
  }

  void _notifyEvent() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MinesweeperGame().lost
            ? Colors.red
            : MinesweeperGame().won
                ? Colors.green
                : Colors.blue,
        title: Text(
          MinesweeperGame().lost
              ? 'Game over'
              : MinesweeperGame().won
                  ? 'You won!'
                  : '${MinesweeperGame().bombCount} bombs',
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.sync),
            onPressed: _startGame,
            tooltip: 'Restart',
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 16.0),
              CupertinoSlidingSegmentedControl<int>(
                groupValue: size,
                children: const <int, Widget>{
                  10: Text('10x10'),
                  15: Text('15x15'),
                  20: Text('20x20'),
                },
                onValueChanged: (int value) {
                  size = value;
                  _startGame();
                },
              ),
              const SizedBox(height: 16.0),
              AbsorbPointer(
                absorbing: MinesweeperGame().lost || MinesweeperGame().won,
                child: GridView.count(
                  crossAxisCount: size,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: <Widget>[
                    for (int x = 0; x < size; x++)
                      for (int y = 0; y < size; y++)
                        MineTileWidget(
                          coordinates: Coordinates(x, y),
                          onUpdate: _notifyEvent,
                          tile: MinesweeperGame().getTile(Coordinates(x, y)),
                        ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
