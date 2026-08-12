import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:providers/provider/like_riverpod.dart';

class LikePage extends ConsumerWidget {
  const LikePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final likeCount = ref.watch(likeProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        foregroundColor: Colors.white,
        title: Center(
          child: Text(
            'Like Page',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'Total like : $likeCount',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    ref.read(likeProvider.notifier).like();
                  },
                  label: Icon(Icons.thumb_up),
                ),
                SizedBox(width: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    ref.read(likeProvider.notifier).unlike();
                  },
                  label: Icon(Icons.thumb_down),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
