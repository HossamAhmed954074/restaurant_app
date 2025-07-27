import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:resturant_app/core/router/app_router.dart';
import 'package:resturant_app/core/utils/styles/app_text_style.dart';
import 'package:resturant_app/core/utils/widgets/show_circle_indecator.dart';
import 'package:resturant_app/features/home/data/item_data.dart';

class ItemCustomWidgetListView extends StatelessWidget {
  const ItemCustomWidgetListView({super.key, required this.itemdata});
  final Itemdata itemdata;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GoRouter.of(
          context,
        ).push(AppRouter.kMenuDetailsScreen, extra: itemdata);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: const EdgeInsets.all(10),
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
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: CachedNetworkImage(
                imageUrl: itemdata.imageCategory,
                imageBuilder: (context, imageProvider) => Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                placeholder: (context, url) => Center(
                  child: circleIndeactorCustom(context, Colors.redAccent),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        itemdata.title,
                        style: AppTextStyle.menuItemTitle.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      // const Spacer(),
                      // SizedBox(
                      //   width: 35,
                      //   height: 35,
                      //   child: InkWell(
                      //     onTap: () {
                      //       GoRouter.of(context).push(
                      //         AppRouter.kMenuDetailsScreen,
                      //         extra: itemdata,
                      //       );
                      //     },
                      //     child: Container(
                      //       decoration: BoxDecoration(
                      //         color: Colors.orangeAccent,
                      //         borderRadius: BorderRadius.circular(20),
                      //       ),
                      //       child: Center(
                      //         child: Icon(
                      //           Icons.arrow_forward,
                      //           color: Colors.white,
                      //           size: 20,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    itemdata.description,
                    style: AppTextStyle.menuItemDescription.copyWith(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.orange, size: 16),
                          const SizedBox(width: 5),
                          Text('${itemdata.rating}'),
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(width: 10),
                          Text(
                            '\$ ${itemdata.price}',
                            style: AppTextStyle.menuItemPrice.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(width: 10),
                          Icon(Icons.timer, color: Colors.redAccent, size: 16),
                          const SizedBox(width: 5),
                          Text(itemdata.time),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
