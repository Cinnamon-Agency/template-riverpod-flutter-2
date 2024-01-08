import 'package:flutter/material.dart';

class ZoomInOutButtons extends StatelessWidget {
  const ZoomInOutButtons({super.key, required this.onZoomIn, required this.onZoomOut});

  final Function() onZoomIn;
  final Function() onZoomOut;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => onZoomIn(),
          child: const Padding(
            padding: EdgeInsets.only(left: 10.0, top: 10, bottom: 5),
            child: ZoomBtn(
              icon: Icons.add,
            ),
          ),
        ),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => onZoomOut(),
          child: const Padding(
            padding: EdgeInsets.only(left: 10.0, top: 5, bottom: 10),
            child: ZoomBtn(icon: Icons.remove),
          ),
        ),
      ],
    );
  }
}

class ZoomBtn extends StatelessWidget {
  const ZoomBtn({
    required this.icon,
  });

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      color: Colors.black,
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}
