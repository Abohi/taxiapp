import 'package:flutter/material.dart';

typedef ResponsiveBuilder = Widget Function(
  BuildContext context,
  Size size,
);

class ResponsiveWidgetBuilder extends StatelessWidget {
  
  const ResponsiveWidgetBuilder({
    @required ResponsiveBuilder builder,
    Key key,
  })  : responsiveBuilder = builder,
        super(key: key);

  final ResponsiveBuilder responsiveBuilder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return responsiveBuilder(
          context,
          constraints.biggest,
        );
      },
    );
  }
}