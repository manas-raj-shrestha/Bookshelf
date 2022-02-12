import 'package:flutter/material.dart';
import 'package:nytbooks/ui/home/widgets/search_delegare.dart';

import '../../core/enums/view_states.dart';
import '../../core/models/books_api_response.dart';
import '../../view_models/home_view_model.dart';
import '../base_view.dart';
import 'widgets/book_list_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(onModelReady: (HomeViewModel homeViewModel) {
      homeViewModel.fetchBestSellingBooks();
    }, builder: (context, homeViewModel, _) {
      return Scaffold(
        appBar: AppBar(
            title: const Text('Bookshelf'),
            actions: _getAppBarActions(context, homeViewModel)),
        body: SafeArea(
          child: _buildHomeBody(homeViewModel),
        ),
      );
    });
  }

  Widget _buildHomeBody(HomeViewModel homeViewModel) {
    switch (homeViewModel.viewState) {
      case ViewState.busy:
        return buildLoadingIndicator();
      case ViewState.idle:
        return buildIdleState(homeViewModel);
      case ViewState.error:
        return buildErrorState();
    }
  }

  Widget buildIdleState(HomeViewModel homeViewModel) {
    return ListView.builder(
        itemCount: homeViewModel.books.length,
        itemBuilder: (context, position) {
          Books book = homeViewModel.books[position];
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

_getAppBarActions(BuildContext context, HomeViewModel homeViewModel) {
  return [
    homeViewModel.books.isNotEmpty
        ? IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: BookSearchDelegate(homeViewModel.books));
            })
        : Container()
  ];
}
