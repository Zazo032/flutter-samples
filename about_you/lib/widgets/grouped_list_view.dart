import 'package:flutter/material.dart';

class GroupedListView extends StatelessWidget {
  const GroupedListView({
    @required this.builder,
    @required this.data,
  });

  final Widget Function(BuildContext context, int index) builder;
  final List<dynamic> data;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        builder,
        childCount: data.length,
      ),
    );
  }
}
