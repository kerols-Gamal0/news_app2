import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageItemWidget extends StatelessWidget {
  const ImageItemWidget({
    super.key,
    required this.image,
    required this.title,
    this.onTap,
  });
  final String image;
  final String title;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            //! image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: image,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,

                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Container(
                      color: Colors.grey[900],
                      width: double.infinity,
                      height: 200,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: LinearProgressIndicator(
                            value: downloadProgress.progress,
                            backgroundColor: Colors.grey[800],
                            color: const Color(0xff1877F2),
                          ),
                        ),
                      ),
                    ),

                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[800],
                  child: const Icon(
                    Icons.broken_image,
                    color: Colors.grey,
                    size: 40,
                  ),
                ),
              ),
            ),

            //! title
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
