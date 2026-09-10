sealed class CounterState {
  final int data;

  const CounterState(this.data);
}

final class CounterStateIdle extends CounterState {
  const CounterStateIdle(super.data);
}

final class CounterStateProcessing extends CounterState {
  const CounterStateProcessing(super.data);
}

final class CounterStateFailed extends CounterState {
  final String errorMessage;

  const CounterStateFailed(super.data, this.errorMessage);
}
