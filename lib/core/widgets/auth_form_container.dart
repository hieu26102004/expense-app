import 'package:flutter/material.dart';

class AuthFormContainer extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final Widget? bottomWidget;

  const AuthFormContainer({
    super.key,
    required this.title,
    required this.children,
    this.bottomWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ...children,
              if (bottomWidget != null) ...[
                const SizedBox(height: 16),
                bottomWidget!,
              ],
            ],
          ),
        ),
      ),
    );
  }
} 