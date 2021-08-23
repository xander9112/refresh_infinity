import 'package:flutter/material.dart';

class RefreshScrollBody extends StatelessWidget {
  const RefreshScrollBody({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: viewportConstraints.maxWidth,
              minHeight: viewportConstraints.maxHeight,
            ),
            child: child,
          ),
        );
      },
    );
  }
}
