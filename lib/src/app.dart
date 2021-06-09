import 'package:app/src/overrides.dart';
import 'package:app/src/styles/theme.dart';
import 'package:app/src/routes.dart';
import 'package:flutter/material.dart';

import 'modules/product/ui/page_1.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Overrides.APP_NAME,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.lightTheme,
      home: Page1(),
      routes: routes,
    );
  }
}
