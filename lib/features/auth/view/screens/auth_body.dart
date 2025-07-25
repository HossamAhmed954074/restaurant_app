import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:resturant_app/features/auth/view/widgets/login_body.dart';
import 'package:resturant_app/features/auth/view/widgets/register_body.dart';
import 'package:resturant_app/features/auth/view/widgets/resset_passord_body.dart';
import 'package:resturant_app/features/auth/view/widgets/tab_bar_custom.dart';
import 'package:resturant_app/generated/assets.dart';

class AuthBody extends StatefulWidget {
  const AuthBody({super.key});

  @override
  State<AuthBody> createState() => _AuthBodyState();
}

class _AuthBodyState extends State<AuthBody>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.imagesAuth),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Container(color: Colors.grey.withAlpha(-200)),
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
              child: Container(
                height: 400,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.black12.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.brown.withOpacity(0.6),
                    width: 1,
                  ),
                ),
                child: Column(
                  
                  children: [
                    TabBarCustomWidget(tabController: _tabController),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          LoginBody(),
                          RegisterBody(),
                          RessetPassord(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
