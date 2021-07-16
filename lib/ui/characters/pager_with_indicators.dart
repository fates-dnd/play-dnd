import 'package:flutter/material.dart';

class PagerWithIndicators extends StatefulWidget {

  final List<Widget> children;

  const PagerWithIndicators({Key? key, required this.children}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PagerWithIndicatorsState();
  }
}

class PagerWithIndicatorsState extends State<PagerWithIndicators> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Indicators(size: widget.children.length, selectedItem: currentPage),
        SizedBox(height: 24),
        Expanded(
          child: PageView(
            children: widget.children,
            onPageChanged: (newPage) => setState(() {
              currentPage = newPage;
            }),
          ),
        ),
      ],
    );
  }
}

class Indicators extends StatelessWidget {
  final int size;
  final int selectedItem;

  const Indicators({Key? key, required this.size, required this.selectedItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < size; ++i)
          Indicator(
            active: i == selectedItem,
          )
      ],
    );
  }
}

class Indicator extends StatelessWidget {
  final bool active;

  const Indicator({Key? key, required this.active}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: active ? Color(0xFF1A1E21) : Color(0xFF9F9E9D)),
      ),
    );
  }
}
