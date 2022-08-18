import 'package:flutter/material.dart';

import '../../../utils/constant.dart';

class PlayGroundWidget extends StatelessWidget {
  const PlayGroundWidget({
    Key? key,
    this.leftSideWidget,
    this.rightSideWidget,
    this.centerWidget,
    this.bottomLeftSideWidget,
    this.bottomRightSideWidget,
    this.bottomCenterWidget,
  }) : super(key: key);

  final Widget? leftSideWidget;
  final Widget? rightSideWidget;
  final Widget? centerWidget;
  final Widget? bottomLeftSideWidget;
  final Widget? bottomRightSideWidget;
  final Widget? bottomCenterWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildSide(child: leftSideWidget),
              Expanded(
                child: Container(
                  child: centerWidget,
                ),
              ),
              _buildSide(child: rightSideWidget)
            ],
          ),
        ),
        Flexible(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSide(
                color: Colors.brown,
                child: bottomLeftSideWidget,
              ),
              Expanded(
                child: Container(
                  color: Colors.blue,
                  child: bottomCenterWidget,
                ),
              ),
              _buildSide(
                color: Colors.brown,
                child: bottomRightSideWidget,
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSide({
    Color? color,
    Widget? child,
  }) {
    return Container(
      width: subjectWidth * 7,
      color: color,
      child: child,
    );
  }
}
