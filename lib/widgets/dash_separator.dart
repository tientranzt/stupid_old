import 'package:flutter/material.dart';

class DashSeparator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, viewportConstraints) {
        final boxWidth = viewportConstraints.constrainWidth();
        final dashCount = (boxWidth / (2 * 5)).floor();
        return Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              height: 1,
              width: 4,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.yellowAccent),
              ),
            );
          }),
        );
      },
    );
  }
}
