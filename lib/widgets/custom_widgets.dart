import 'package:flutter/material.dart';

PreferredSizeWidget CustomAppBar(BuildContext context) {
  return AppBar(
    title: Text('Green Thumb'),
    centerTitle: true,
    backgroundColor: Theme.of(context).colorScheme.inversePrimary,
  );
}
