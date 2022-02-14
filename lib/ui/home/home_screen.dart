import 'package:flutter/material.dart';
import 'package:nytbooks/core/constants/screen_titles.dart';
import 'package:nytbooks/core/models/book.dart';
import 'package:nytbooks/ui/commons/error_widget.dart';
import 'package:nytbooks/ui/home/widgets/book_search_delegate.dart';

import '../../core/enums/view_states.dart';

import '../../view_models/home_view_model.dart';
import '../base_view.dart';
import 'widgets/book_list_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(onModelReady: (HomeViewModel homeViewModel) {
      homeViewModel.fetchBooks();
    }, builder: (context, homeViewModel, _) {
      return Scaffold(
        appBar: AppBar(
            title: const Text(appTitle),
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
        return buildErrorState(homeViewModel);
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

  Widget buildErrorState(HomeViewModel homeViewModel) {
    return ErrorMessage(
        message: 'There was some problem while loading books.',
        buttonTitle: 'Retry',
        onTap: () {
          homeViewModel.fetchBooks();
        });
  }
}

_getAppBarActions(BuildContext context, HomeViewModel homeViewModel) {
  return [
    homeViewModel.books.isNotEmpty
        ? IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: BookSearchDelegate());
            })
        : Container()
  ];
}
