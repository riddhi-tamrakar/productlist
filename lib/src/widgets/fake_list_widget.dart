import 'package:app/src/widgets/shimmer_loading_widget.dart';
import 'package:flutter/material.dart';

class FakeListWidget extends StatelessWidget {
  final int length;
  final Widget item;
  FakeListWidget(this.length, this.item);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: length,
      itemBuilder: (BuildContext context, i) {
        return ShimmerLoading(child: item, isLoading: true);
      });
  }
}