import 'package:flutter/material.dart';
import 'package:newschoolbusapp/widgets/routeItems.dart';

import '../core/models/route.dart';

class RouteList extends StatelessWidget {
  final List<RouteClass> routes;

  const RouteList({Key? key, required this.routes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: routes.length,
      itemBuilder: (context, index) {
        RouteClass route = routes[index];

        return RouteItem(route: route);
      },
    );
  }
}
