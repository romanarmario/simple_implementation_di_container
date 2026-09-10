import 'package:flutter/material.dart';

import 'counter_controller.dart';
import 'counter_state.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  @override
  void initState() {
    super.initState();
    CounterController.instance.addListener(_onChangeCounter);
    CounterController.instance.readCounter();
  }

  @override
  void dispose() {
    CounterController.instance.removeListener(_onChangeCounter);
    super.dispose();
  }

  void _onChangeCounter() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final state = CounterController.instance.state;
    return Scaffold(
      body: Center(
        child: Column(
          spacing: 16,
          mainAxisAlignment: .center,
          children: [
            switch (state) {
              CounterStateIdle() => Text('${state.data}'),
              CounterStateProcessing() => const CircularProgressIndicator(),
              CounterStateFailed() => Text(state.errorMessage),
            },
            FilledButton(
              onPressed: () => CounterController.instance.incrementCounter(),
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
