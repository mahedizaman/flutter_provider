import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<String> fetchQuote() async {
  await Future.delayed(Duration(seconds: 1));
  final quotes = [
    'Believe in yourself',
    'Never give up',
    'Success takes patience',
    'Keep learning every day',
  ];

  final random = Random();

  return quotes[random.nextInt(quotes.length)];
}

final quoteProvider = FutureProvider<String>((ref) async {
  return fetchQuote();
});

final quoteWordCountProvider = Provider<int>((ref) {
  final quote = ref.watch(quoteProvider);

  return quote.value?.trim().split(RegExp(r'\s+')).length ?? 0;
});
