import 'package:flutter/material.dart';

void navigateTo(BuildContext context, Widget screen) =>
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );

void navigateAndReplace(BuildContext context, Widget screen) =>
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
