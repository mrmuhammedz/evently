import 'package:flutter/material.dart';

class EventlyScaffold extends StatelessWidget {
  final Widget child;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;

  const EventlyScaffold({super.key, required this.child, this.bottomNavigationBar, this.floatingActionButton});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: child,
        ),
      ),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
