library refresh_infinity;

import 'package:flutter/material.dart';
import 'refresh_loader.dart';
import 'refresh_widget.dart';

class RefreshInfinity extends StatelessWidget {
  const RefreshInfinity({
    Key? key,
    this.onRefresh,
    this.refreshIndicatorKey,
    this.isError = false,
    this.errorWidget,
    this.isEmptyData = true,
    this.emptyDataWidget,
    this.isLoading = true,
    this.showAdditionalLoader = true,
    // this.dataHasLoaded = false,
    this.child,
  }) : super(key: key);

  final RefreshCallback? onRefresh;
  final GlobalKey<RefreshIndicatorState>? refreshIndicatorKey;

  final bool? isError;
  final Widget? errorWidget;

  final bool? isEmptyData;
  final Widget? emptyDataWidget;

  final bool? isLoading;

  final bool? showAdditionalLoader;
  // final bool? dataHasLoaded;

  final Widget? child;

  /// Состояние загрузки без данных isLoadingWithData
  /// Состояние загрузки с данными isLoadingWithoutData
  /// Отображение данных showData
  /// Отображение пустых данных showEmptyData
  /// Отображение ошибки showError

  bool get showRefreshWidget =>
      onRefresh != null && refreshIndicatorKey != null;

  bool get isLoadingWithoutData => isLoading! && isEmptyData!;

  bool get hasChild => child != null;

  @override
  Widget build(BuildContext context) {
    if (showRefreshWidget) {
      return RefreshWidget(
        refreshIndicatorKey: refreshIndicatorKey!,
        isLoading: isLoading ?? true,
        onRefresh: onRefresh!,
        showAdditionalLoader: showAdditionalLoader ?? true,
        // dataHasLoaded: dataHasLoaded ?? false,
        isEmptyData: isEmptyData ?? true,
        emptyDataWidget: emptyDataWidget,
        isError: isError ?? false,
        errorWidget: errorWidget,
        child: child,
      );
    }

    if (isLoading ?? false) {
      return const RefreshLoader();
    }

    if (isError!) {
      if (errorWidget != null) {
        return errorWidget!;
      }

      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Error while fetching data',
            style: TextStyle(color: Theme.of(context).errorColor),
          ),
        ),
      );
    }

    if (hasChild) {
      return child!;
    }

    return Container();
  }
}
