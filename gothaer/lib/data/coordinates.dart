import 'package:gothaer/widgets/mine_tile_widget.dart';

/// Model that represents the position of a [MineTileWidget].
class Coordinates {
  /// Default constructor.
  const Coordinates(this.x, this.y);

  /// x-axis coordinate.
  final int x;

  /// y-axis coordinate.
  final int y;

  @override
  String toString() => '($x, $y)';
}