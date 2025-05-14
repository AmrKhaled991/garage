import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import 'my_scaffold.dart';

class GallerySliderPage extends StatelessWidget {
  List<String>? urls;

  GallerySliderPage(this.urls);

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: Container(
        color: Colors.white,
        child: PhotoViewGallery.builder(
          backgroundDecoration: BoxDecoration(color: Colors.white),
          scrollPhysics: const BouncingScrollPhysics(),
          builder: (BuildContext context, int index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: CachedNetworkImageProvider(urls?.elementAt(index)??""),
              initialScale: PhotoViewComputedScale.contained * 1,
              // heroAttributes: PhotoViewHeroAttributes(tag: galleryItems[index].id),
            );
          },
          itemCount: urls?.length??0,
          loadingBuilder: (context, event) => Center(
            child: Container(
              width: 20.0,
              height: 20.0,
              color: Colors.white,
              child: CircularProgressIndicator(
                value: event == null
                    ? 0
                    : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
              ),
            ),
          ),
          // backgroundDecoration: widget.backgroundDecoration,
          // pageController: widget.pageController,
          // onPageChanged: onPageChanged,
        ),
      )
    );
  }
}
