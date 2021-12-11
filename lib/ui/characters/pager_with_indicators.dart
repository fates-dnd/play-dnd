import 'package:flutter/material.dart';

class PagerWithIndicators extends StatelessWidget {
  final Map<String, Widget> namedPages;

  const PagerWithIndicators({Key? key, required this.namedPages})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: namedPages.length,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
              indicatorColor: Colors.red,
              indicatorPadding: EdgeInsets.symmetric(horizontal: 32),
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              isScrollable: true,
              unselectedLabelColor: Colors.white.withOpacity(0.3),
              tabs: namedPages.keys
                  .map((e) => Tab(
                        child: Text(e),
                      ))
                  .toList()),
          Expanded(
            child: TabBarView(
                children: namedPages.values
                    .map((e) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: e,
                        ))
                    .toList()),
          )
        ],
      ),
    );
  }
}
