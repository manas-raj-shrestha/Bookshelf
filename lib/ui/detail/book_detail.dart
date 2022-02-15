import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/screen_titles.dart';
import '../../core/models/book.dart';

class BookDetail extends StatelessWidget {
  final Book book;
  const BookDetail(this.book, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          children: [
            Row(
              children: [
                _buildBookCoverImage(),
                SizedBox(width: 16.w),
                _buildBookInfo(context)
              ],
            ),
            SizedBox(
              height: 16.h,
            ),
            _buildBookDescription()
          ],
        ),
      )),
    );
  }

  Expanded _buildBookDescription() {
    return Expanded(
      child: SingleChildScrollView(child: Text(book.description)),
    );
  }

  Expanded _buildBookInfo(context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(book.title, style: Theme.of(context).textTheme.subtitle1),
          SizedBox(
            height: 8.h,
          ),
          Text(
            "by ${book.author}",
            style: Theme.of(context).textTheme.subtitle2,
          ),
          SizedBox(
            height: 12.h,
          ),
          Text(book.price, style: Theme.of(context).textTheme.headline4),
        ],
      ),
    );
  }

  CachedNetworkImage _buildBookCoverImage() {
    return CachedNetworkImage(
      fit: BoxFit.fitHeight,
      imageUrl: book.imgUrl,
      height: 200.h,
      width: 150.w,
    );
  }
}
