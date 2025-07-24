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
          colors: [Colors.red, Colors.orange, Colors.yellow],
        ),
      ),
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white70,
      tabs: [
        Tab(text: 'LogIn'),
        Tab(text: 'Register'),
        Tab(text: 'Reset'),
      ],
    );
  }
}