
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resturant_app/core/router/app_router.dart';
import 'package:resturant_app/core/utils/styles/app_text_style.dart';
import 'package:resturant_app/core/utils/widgets/show_circle_indecator.dart';
import 'package:resturant_app/features/home/data/item_data.dart';

class ItemCustomWidgetGridView extends StatelessWidget {
  const ItemCustomWidgetGridView({super.key, required this.itemData});
  final Itemdata itemData;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GoRouter.of(context).push(
          AppRouter.kMenuDetailsScreen,
          extra: itemData,
        );
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: CachedNetworkImage(
                imageUrl: itemData.imageCategory,
                imageBuilder: (context, imageProvider) => Container(
                  height: 150,
                  decoration: BoxDecoration(
                   // borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                placeholder: (context, url) => Center(
                  child: circleIndeactorCustom(context, Colors.redAccent)
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              itemData.title,
              style: AppTextStyle.menuItemTitle.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.star, color: Colors.orange, size: 16),
                const SizedBox(width: 5),
                Text(
                  itemData.rating.toString(),
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                Spacer(),
                Icon(Icons.timer, color: Colors.redAccent, size: 16),
                const SizedBox(width: 5),
                Text(
                  itemData.time,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${itemData.price}',
                  style: AppTextStyle.menuItemPrice.copyWith(color: Colors.green),
                ),
                SizedBox(
                  width: 35,
                  height: 35,
                  child: InkWell(
                    onTap: () {
                      GoRouter.of(context).push(
                        AppRouter.kMenuDetailsScreen,
                        extra: itemData,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
