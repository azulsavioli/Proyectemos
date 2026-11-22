import 'package:flutter/material.dart';

import '../../../commons/styles.dart';

class FeedStatusView extends StatelessWidget {
  final String message;
  final VoidCallback onReload;

  const FeedStatusView({
    super.key,
    required this.message,
    required this.onReload,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: ThemeText.paragraph14Gray,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: onReload,
                      child: const Text('Reintentar'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
