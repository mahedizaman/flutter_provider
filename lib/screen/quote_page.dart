import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:providers/provider/quote_provider.dart';

class QuotePage extends ConsumerWidget {
  const QuotePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quote = ref.watch(quoteProvider);
    final quoteWord = ref.watch(quoteWordCountProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        foregroundColor: Colors.white,
        title: Center(
          child: Text(
            'Future Provider',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: Center(
        child: quote.when(
          loading: () {
            return const CircularProgressIndicator();
          },
          error: (error, stackTrace) {
            return Text('Error: $error');
          },
          data: (quote) {
            return Column(
              children: [Text(quote), Text('Total Word : $quoteWord')],
            );
          },
        ),
      ),
    );
  }
}
