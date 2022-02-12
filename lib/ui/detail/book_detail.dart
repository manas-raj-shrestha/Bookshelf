import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nytbooks/core/constants/screen_titles.dart';
import 'package:nytbooks/core/models/book.dart';

class BookDetail extends StatelessWidget {
  final Books books;
  const BookDetail(this.books, {Key? key}) : super(key: key);

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
                _buildBookInfo()
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
      child: SingleChildScrollView(child: Text(books.description ?? '')),
    );
  }

  Expanded _buildBookInfo() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(books.title ?? '',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
          SizedBox(
            height: 8.h,
          ),
          Text(
            "by ${books.author ?? ''}",
            style: TextStyle(fontSize: 14.sp),
          ),
          SizedBox(
            height: 12.h,
          ),
          Text(
            '${books.price}',
            style: TextStyle(fontSize: 20.sp),
          )
        ],
      ),
    );
  }

  CachedNetworkImage _buildBookCoverImage() {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: books.imgUrl ?? '',
      height: 200.h,
      width: 150.w,
    );
  }
}
