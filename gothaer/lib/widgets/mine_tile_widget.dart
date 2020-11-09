import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gothaer/data/coordinates.dart';
import 'package:gothaer/data/game.dart';
import 'package:gothaer/data/mine_tile.dart';

/// Widget that represents a tile on the minesweeper game.
class MineTileWidget extends StatelessWidget {
  /// Default constructor.
  const MineTileWidget({
    this.coordinates,
    this.onUpdate,
    this.tile,
  })  : assert(coordinates != null),
        assert(tile != null);

  /// The coordinates of the tile in the board.
  final Coordinates coordinates;

  /// The callback for updating the board.
  final Function onUpdate;

  /// The data of the tile, represented as a [MineTile] instance.
  final MineTile tile;

  double get _iconSize {
    if (MinesweeperGame().size == 10) {
      return 24.0;
    } else if (MinesweeperGame().size == 15) {
      return 18.0;
    } else {
      return 12.0;
    }
  }

  Color get _tileColor {
    if (tile.opened) {
      if (tile.hasBomb) {
        return Colors.redAccent;
      } else {
        return Colors.transparent;
      }
    } else {
      return Colors.black12;
    }
  }

  Widget get _tileIcon {
    if (tile.flagged) {
      return Icon(
        Icons.flag,
        size: _iconSize,
      );
    } else if (tile.opened) {
      if (tile.hasBomb) {
        return Icon(
          Icons.coronavirus,
          size: _iconSize,
        );
      } else if (tile.bombsAround > 0) {
        return Center(
          child: Text('${tile.bombsAround}'),
        );
      }
    }
    return const SizedBox();
  }

  void _handleFlag() {
    if (!tile.opened) {
      HapticFeedback.lightImpact();
      MinesweeperGame().flagTile(coordinates);
      onUpdate();
    }
  }

  void _handlePress() {
    if (!tile.flagged) {
      HapticFeedback.lightImpact();
      MinesweeperGame().pressTile(coordinates);
      onUpdate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: _handleFlag,
      onSecondaryTap: _handleFlag,
      onTap: _handlePress,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black38,
          ),
          color: _tileColor,
        ),
        child: _tileIcon,
      ),
    );
  }
}
