import 'package:flutter/material.dart';

import 'refresh_loader.dart';
import 'refresh_scroll_body.dart';

class RefreshWidget extends StatelessWidget {
  const RefreshWidget({
    Key? key,
    required this.onRefresh,
    required this.refreshIndicatorKey,
    required this.isError,
    required this.isEmptyData,
    required this.isLoading,
    required this.showAdditionalLoader,
    // required this.dataHasLoaded,
    this.errorWidget,
    this.emptyDataWidget,
    this.child,
  }) : super(key: key);

  final RefreshCallback onRefresh;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;

  final bool isError;
  final Widget? errorWidget;

  final bool isEmptyData;
  final Widget? emptyDataWidget;

  final bool isLoading;

  final bool showAdditionalLoader;
  // final bool dataHasLoaded;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    if (isLoading && isEmptyData) {
      return const RefreshLoader();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (showAdditionalLoader)
          Opacity(
            opacity: isLoading ? 1 : 0,
            child: const LinearProgressIndicator(),
          ),
        Expanded(
          child: RefreshIndicator(
              key: refreshIndicatorKey,
              onRefresh: onRefresh,
              child: Builder(
                builder: (BuildContext context) {
                  if (isEmptyData) {
                    if (!isError) {
                      return RefreshScrollBody(
                        child: Builder(
                          builder: (BuildContext context) {
                            if (emptyDataWidget == null) {
                              return const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Text('Data is empty'),
                                ),
                              );
                            }

                            return emptyDataWidget!;
                          },
                        ),
                      );
                    }

                    if (isError) {
                      return RefreshScrollBody(
                        child: Builder(
                          builder: (BuildContext context) {
                            if (errorWidget == null) {
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    'Error while fetching data',
                                    style: TextStyle(
                                        color: Theme.of(context).errorColor),
                                  ),
                                ),
                              );
                            }

                            return errorWidget!;
                          },
                        ),
                      );
                    }
                  }

                  if (child != null) {
                    return child!;
                  }

                  return Container();
                },
              )),
        ),
      ],
    );
  }
}
