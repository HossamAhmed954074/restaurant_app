import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:resturant_app/core/services/auth_services.dart';

class InfoSection extends StatelessWidget {
  const InfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 60,
          backgroundColor: Colors.grey[300],
          child: CachedNetworkImage(
            imageUrl: AuthServicess().userInfo.photoURL ?? '',
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.face, size: 60, color: Colors.grey[700]),
          ),
        ),
        SizedBox(height: 10),
        Text(
          AuthServicess().currentUser?.displayName ?? 'No Name',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Text(
          AuthServicess().currentUser?.email ?? 'No Email',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }
}
