/// A class that represents a tile on the [MinesweeperGame]
class MineTile {
  /// Default constructor.
  MineTile({
    this.bombsAround = 0,
    this.flagged = false,
    this.hasBomb = false,
    this.opened = false,
  });

  /// The amount of bombs around the tile.
  int bombsAround;

  /// If the tile has a bomb inside.
  bool hasBomb;

  /// If the tile has been flagged.
  bool flagged;

  /// If the tile has been opened.
  bool opened;
}
