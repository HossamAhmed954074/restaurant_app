import 'package:flutter/material.dart';
import 'package:resturant_app/core/utils/styles/app_text_style.dart';
import 'package:resturant_app/generated/assets.dart';

class MenuHeaderCustomWidget extends StatelessWidget {
  const MenuHeaderCustomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orangeAccent.shade100,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                // Add some space on the left
                SizedBox(
                  width: 60,
                  height: 60,
                  child: Image.asset(
                    Assets.imagesProfileImage,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  width: 90,
                  height: 90,
                  child: Image.asset(
                    Assets.imagesMenuImage,
                    fit: BoxFit.contain,
                  ),
                ),

                Row(
                  children: [
                    IconButton(
                      icon: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.grey, width: 1.5),
                        ),
                        child: const Icon(
                          Icons.search,
                          size: 22,
                          color: Colors.grey,
                        ),
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.grey, width: 1.5),
                        ),
                        child: const Icon(
                          Icons.notifications,
                          size: 22,
                          color: Colors.grey,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Provide The Best Food For You',
            style: AppTextStyle.heading2.copyWith(fontWeight: FontWeight.w300),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
