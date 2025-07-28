
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:resturant_app/core/utils/widgets/show_circle_indecator.dart';
import 'package:resturant_app/features/home/data/item_data.dart';

class HeroImageCustomWidget extends StatelessWidget {
  const HeroImageCustomWidget({
    super.key,
    required this.itemData,
    required this.widgetKey,
  });

  final Itemdata itemData;
  final GlobalKey widgetKey;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: itemData.imageFordetails,
      child: Container(
        key: widgetKey,
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.35,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: CachedNetworkImage(
            imageUrl: itemData.imageFordetails,
            fit: BoxFit.contain,
            placeholder: (context, url) => Container(
              color: Colors.grey[100],
              child: Center(
                child: circleIndeactorCustom(context, Colors.redAccent),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              color: Colors.grey[200],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.image_not_supported,
                    size: 48,
                    color: Colors.grey[500],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Image not available',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}