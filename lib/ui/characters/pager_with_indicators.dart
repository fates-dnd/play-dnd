import 'package:flutter/material.dart';

class PagerWithIndicators extends StatefulWidget {
  final Map<String, Widget> namedPages;

  const PagerWithIndicators({Key? key, required this.namedPages})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PagerWithIndicatorsState();
  }
}

class PagerWithIndicatorsState extends State<PagerWithIndicators> {
  late PageController _controller;
  late PageController _indicatorController;

  @override
  void initState() {
    super.initState();
    _controller = PageController()
      ..addListener(
        () => setState(() {
          _indicatorController.jumpTo(_controller.offset * 0.3);
        }),
      );

    _indicatorController = PageController(viewportFraction: 0.3);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 100,
          child: PageView(
            controller: _indicatorController,
            padEnds: false,
            children: widget.namedPages.keys
                .map((title) => IndicatorItem(title: title, opacity: 1.0))
                .toList(),
          ),
        ),
        Expanded(
          child: PageView(
            children: widget.namedPages.values
                .map((e) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: e,
                    ))
                .toList(),
            controller: _controller,
          ),
        ),
      ],
    );
  }
}

class IndicatorItem extends StatelessWidget {
  final String title;
  final double opacity;

  const IndicatorItem({
    Key? key,
    required this.title,
    required this.opacity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(color: Color(0xFFE5E1DE)),
    );
  }
}
