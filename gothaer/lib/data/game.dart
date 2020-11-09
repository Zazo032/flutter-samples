import 'dart:math';

import 'package:gothaer/data/coordinates.dart';
import 'package:gothaer/data/mine_tile.dart';

/// A singleton with the instance of the Minesweeper game.
class MinesweeperGame {
  /// The singleton instance builder.
  factory MinesweeperGame() => _instance;

  MinesweeperGame._internal();

  static final MinesweeperGame _instance = MinesweeperGame._internal();

  /// The size of the game.
  int size;

  /// The matrix of [MineTile] that represent the state of the game.
  List<List<MineTile>> tiles;

  /// The amount of bombs.
  int bombCount;

  /// If the game is lost.
  bool lost = false;

  /// If the game is won.
  bool won = false;

  /// Returns the [MineTile] for a given coordinate [c].
  MineTile getTile(Coordinates c) => tiles[c.x][c.y];

  /// Starts a new game of [size] tiles.
  void start(int size) {
    this.size = size;
    lost = false;
    won = false;
    // Generate the game
    tiles = List<List<MineTile>>.generate(size, (int i) {
      return List<MineTile>.generate(size, (int j) {
        return MineTile();
      });
    });
    _initBombs();
    _checkBombsAround();
  }

  void _initBombs() {
    final Random _random = Random();
    bombCount = size + _random.nextInt(size);
    int _bombCount = bombCount;
    while (_bombCount != 0) {
      final int _randomX = _random.nextInt(size);
      final int _randomY = _random.nextInt(size);
      final Coordinates _c = Coordinates(_randomX, _randomY);
      if (getTile(_c).hasBomb) {
        continue;
      } else {
        getTile(_c).hasBomb = true;
        _bombCount--;
      }
    }
  }

  void _checkBombsAround() {
    for (int x = 0; x < size; x++) {
      for (int y = 0; y < size; y++) {
        // 1 2 3
        // x o x
        // x x x
        if (x > 0 && y > 0) {
          if (getTile(Coordinates(x - 1, y - 1)).hasBomb) {
            getTile(Coordinates(x, y)).bombsAround++;
          }
        }

        if (x > 0) {
          if (getTile(Coordinates(x - 1, y)).hasBomb) {
            getTile(Coordinates(x, y)).bombsAround++;
          }
        }

        if (x > 0 && y < size - 1) {
          if (getTile(Coordinates(x - 1, y + 1)).hasBomb) {
            getTile(Coordinates(x, y)).bombsAround++;
          }
        }

        if (y > 0) {
          if (getTile(Coordinates(x, y - 1)).hasBomb) {
            getTile(Coordinates(x, y)).bombsAround++;
          }
        }

        if (y < size - 1) {
          if (getTile(Coordinates(x, y + 1)).hasBomb) {
            getTile(Coordinates(x, y)).bombsAround++;
          }
        }

        if (x < size - 1 && y > 0) {
          if (getTile(Coordinates(x + 1, y - 1)).hasBomb) {
            getTile(Coordinates(x, y)).bombsAround++;
          }
        }

        if (x < size - 1) {
          if (getTile(Coordinates(x + 1, y)).hasBomb) {
            getTile(Coordinates(x, y)).bombsAround++;
          }
        }

        if (x < size - 1 && y < size - 1) {
          if (getTile(Coordinates(x + 1, y + 1)).hasBomb) {
            getTile(Coordinates(x, y)).bombsAround++;
          }
        }
      }
    }
  }

  /// Presses the tile at [c].
  void pressTile(Coordinates c, {bool adjacent = false}) {
    print('pressed $c');
    final MineTile _tile = getTile(c);
    print('bombs around: ${_tile.bombsAround}');
    if (_tile.flagged || _tile.opened) {
      return;
    }
    _tile.opened = true;
    if (_tile.hasBomb) {
      _gameLost();
    } else {
      if (_tile.bombsAround == 0) {
        _pressAdjacentTiles(c);
      }
      if (!_checkMissingOpen()) {
        _gameWon();
      }
    }
  }

  bool _checkMissingOpen() {
    for (int x = 0; x < size; x++) {
      for (int y = 0; y < size; y++) {
        final MineTile _tile = getTile(Coordinates(x, y));
        if (!_tile.opened && !_tile.hasBomb) {
          return true;
        }
      }
    }
    return false;
  }

  void _pressAdjacentTiles(Coordinates c) {
    print('pressAdjacentTiles $c');
    final int x = c.x;
    final int y = c.y;

    // 1 2 3
    // x o x
    // x x x
    if (x > 0 && y > 0) {
      final Coordinates _c = Coordinates(x - 1, y - 1);
      if (!getTile(_c).hasBomb) {
        pressTile(_c, adjacent: true);
      }
    }

    if (x > 0) {
      final Coordinates _c = Coordinates(x - 1, y);
      if (!getTile(_c).hasBomb) {
        pressTile(_c, adjacent: true);
      }
    }

    if (x > 0 && y < size - 1) {
      final Coordinates _c = Coordinates(x - 1, y + 1);
      if (!getTile(_c).hasBomb) {
        pressTile(_c, adjacent: true);
      }
    }

    if (c.y > 0) {
      final Coordinates _c = Coordinates(x, y - 1);
      if (!getTile(_c).hasBomb) {
        pressTile(_c, adjacent: true);
      }
    }

    if (c.y < size - 1) {
      final Coordinates _c = Coordinates(x, y + 1);
      if (!getTile(_c).hasBomb) {
        pressTile(_c, adjacent: true);
      }
    }

    if (c.x < size - 1 && c.y > 0) {
      final Coordinates _c = Coordinates(x + 1, y - 1);
      if (!getTile(_c).hasBomb) {
        pressTile(_c, adjacent: true);
      }
    }

    if (c.x < size - 1) {
      final Coordinates _c = Coordinates(x + 1, y);
      if (!getTile(_c).hasBomb) {
        pressTile(_c, adjacent: true);
      }
    }

    if (c.x < size - 1 && c.y < size - 1) {
      final Coordinates _c = Coordinates(x + 1, y + 1);
      if (!getTile(_c).hasBomb) {
        pressTile(_c, adjacent: true);
      }
    }
  }

  /// Flags the tile at [c].
  void flagTile(Coordinates c) {
    if (!getTile(c).opened) {
      getTile(c).flagged = !getTile(c).flagged;
    }
    if (!_checkMissingBombs()) {
      _gameWon();
    }
  }

  bool _checkMissingBombs() {
    for (int x = 0; x < size; x++) {
      for (int y = 0; y < size; y++) {
        final MineTile _tile = getTile(Coordinates(x, y));
        if ((_tile.hasBomb && !_tile.flagged) || (!_tile.hasBomb && _tile.flagged)) {
          return true;
        }
      }
    }
    return false;
  }

  void _gameLost() => lost = true;

  void _gameWon() => won = true;

  /// Prints the board.
  void debugPrint() {
    String _board = '';
    for (int x = 0; x < size; x++) {
      for (int y = 0; y < size; y++) {
        if (getTile(Coordinates(x, y)).hasBomb) {
          if (getTile(Coordinates(x, y)).flagged) {
            _board += 'x ';
          } else {
            _board += 'X ';
          }
        } else {
          if (getTile(Coordinates(x, y)).opened) {
            _board += '- ';
          } else {
            _board += '+ ';
          }
        }
      }
      _board += '\n';
    }
    _board += '\n';
    print(_board);
  }
}
