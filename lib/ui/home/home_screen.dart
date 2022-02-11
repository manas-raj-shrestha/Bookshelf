import 'package:flutter/material.dart';

import '../../core/enums/view_states.dart';
import '../../core/models/books_api_response.dart';
import '../../view_models/home_view_model.dart';
import '../base_view.dart';
import 'widgets/book_list_tile.dart';

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
            case ViewState.error:
              return buildErrorState();
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
          return BookListTile(book);
        });
  }

  Widget buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorState() {
    return const Center(child: Text('Something went wrong. Please try again.'));
  }
}
