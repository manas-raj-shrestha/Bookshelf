import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nytbooks/core/enums/view_states.dart';
import 'package:nytbooks/core/models/books_api_response.dart';
import 'package:nytbooks/ui/base_view.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:nytbooks/view_models/home_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookshelf'),
      ),
      body: SafeArea(
        child: BaseView<HomeViewModel>(
            onModelReady: (HomeViewModel homeViewModel) {
          homeViewModel.fetchBestSellingBooks();
        }, builder: (context, homeViewModel, _) {
          switch (homeViewModel.viewState) {
            case ViewState.busy:
              return buildLoadingIndicator();
            case ViewState.idle:
              return buildIdleState(homeViewModel);
          }
        }),
      ),
    );
  }

  Widget buildIdleState(HomeViewModel homeViewModel) {
    return ListView.builder(
        itemCount: homeViewModel.bestSellingBooks.length,
        itemBuilder: (context, position) {
          Books book = homeViewModel.bestSellingBooks[position];
          return Card(
            margin: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                CachedNetworkImage(
                  imageUrl: book.imgUrl ?? '',
                  height: 150.h,
                  fit: BoxFit.cover,
                  width: 100.w,
                ),
                SizedBox(
                  width: 16.w,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            book.title ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            'by ${book.author}',
                            style: TextStyle(fontSize: 14.sp),
                          ),
                          SizedBox(
                            height: 24.w,
                          ),
                          Text(
                            '${book.price}',
                            style: TextStyle(fontSize: 20.sp),
                          )
                        ]),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
