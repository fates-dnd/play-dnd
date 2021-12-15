import 'package:flutter/material.dart';

class SearchAppBar extends StatefulWidget {
  final String title;
  final Function(BuildContext, String) onSearchValueChanged;
  final Function(BuildContext) onSearchCancelled;

  const SearchAppBar({
    Key? key,
    required this.title,
    required this.onSearchValueChanged,
    required this.onSearchCancelled,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: isSearching
          ? TextField(
              autofocus: true,
              style: TextStyle(color: Colors.white),
              onChanged: (value) => widget.onSearchValueChanged(context, value),
            )
          : Text(widget.title),
      actions: [
        if (isSearching)
          IconButton(
              onPressed: () {
                setState(() => isSearching = false);
                widget.onSearchCancelled(context);
              },
              icon: Icon(Icons.cancel_outlined)),
        if (!isSearching)
          IconButton(
              onPressed: () => setState(() => isSearching = true),
              icon: Icon(Icons.search)),
      ],
    );
  }
}
