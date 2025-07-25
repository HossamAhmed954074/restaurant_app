import 'package:flutter/material.dart';


class TabBarCustomWidget extends StatelessWidget {
  const TabBarCustomWidget({super.key, required this.tabController});

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      indicatorSize: TabBarIndicatorSize.tab,

      indicator: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.redAccent, Colors.blueAccent, Colors.greenAccent],
        ),
      ),
      labelColor: Colors.black,
      unselectedLabelColor: Colors.orange,
      tabs: [
        Tab(text: 'LogIn'),
        Tab(text: 'Register'),
        Tab(text: 'Reset'),
      ],
    );
  }
}