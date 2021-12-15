import 'package:flutter/material.dart';

class SearchAppBar extends StatefulWidget {
  final String title;
  final Function(String) onSearchValueChanged;

  const SearchAppBar({
    Key? key,
    required this.title,
    required this.onSearchValueChanged,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
      actions: [
        if (isSearching)
          IconButton(
              onPressed: () => setState(() => isSearching = false),
              icon: Icon(Icons.cancel_outlined)),
        if (!isSearching)
          IconButton(
              onPressed: () => setState(() => isSearching = true),
              icon: Icon(Icons.search)),
      ],
    );
  }
}
