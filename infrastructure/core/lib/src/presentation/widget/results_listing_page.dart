import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../../../core.dart';

class ResultsListingPage<T> extends StatelessWidget {
  final ValueStream<UiState<List<T>>?> resultsStream;
  final Function(BuildContext context, int index, T item) listItemBuilder;
  final Widget noResultsWidget;
  final Widget Function(String message) errorPlaceholderBuilder;
  final Widget loadingWidget;
  final ScrollPhysics? physics;
  final Axis scrollDirection;
  const ResultsListingPage({
    super.key,
    required this.resultsStream,
    required this.listItemBuilder,
    this.noResultsWidget=const SizedBox(),
    required this.errorPlaceholderBuilder,
    required this.loadingWidget,
    this.physics,
    this.scrollDirection=Axis.vertical,
  });

  @override
  Widget build(BuildContext context) {
    return buildResult();
  }

  Widget buildResult() {
    return StreamBuilder<UiState<List<T>>?>(
        stream: resultsStream,
        builder: (context, resultsSnapshot) {
          switch (resultsSnapshot.data?.status) {
            case UiStateStatus.loading:
              return loadingWidget;
            case UiStateStatus.success:
              return buildList(resultsSnapshot.data!.data!);
            case UiStateStatus.noResults:
              return noResultsWidget;
            case UiStateStatus.failure:
              return errorPlaceholderBuilder(resultsSnapshot.data!.message!,);

            default:
              return const SizedBox();
          }
        });
  }

  Widget buildList(List<T> item) {
    return ListView.builder(
      itemCount: item.length,
      physics: physics,
      scrollDirection: scrollDirection,
      padding: const EdgeInsets.symmetric(horizontal: 0),
      itemBuilder: (context, index) => listItemBuilder(context, index, item[index],),
    );
  }
}
