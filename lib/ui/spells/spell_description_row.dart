import 'package:flutter/widgets.dart';

class SpellDescriptionRow extends StatelessWidget {
  final String name;
  final String value;

  const SpellDescriptionRow({Key? key, required this.name, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(
      children: [
        TextSpan(
            text: name + ": ",
            style: TextStyle(color: Color(0xAADCDAD9), fontSize: 12)),
        TextSpan(
            text: value,
            style: TextStyle(color: Color(0xFFDCDAD9), fontSize: 12)),
      ],
    ));
  }
}
