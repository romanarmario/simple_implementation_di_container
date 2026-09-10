import '../common/controller.dart';
import '../storage/storage_repository.dart';
import 'counter_state.dart';

class CounterController extends SequentialController<CounterState> {
  final StorageRepository storageRepository;
  CounterController({required this.storageRepository}) : super(const CounterStateIdle(0));

  Future<void> readCounter() async {
    await execute(() async {
      try {
        setState(CounterStateProcessing(state.data));

        final newData = await storageRepository.readCounter('counter');

        setState(CounterStateProcessing(newData));
      } on Object catch (error, stackTrace) {
        setState(CounterStateFailed(state.data, error.toString()));
      } finally {
        setState(CounterStateIdle(state.data));
      }
    });
  }

  Future<void> incrementCounter() async {
    await execute(() async {
      try {
        setState(CounterStateProcessing(state.data));

        final newData = state.data + 1;
        await storageRepository.writeCounter('counter', newData);

        setState(CounterStateProcessing(newData));
      } on Object catch (error, stackTrace) {
        setState(CounterStateFailed(state.data, error.toString()));
      } finally {
        setState(CounterStateIdle(state.data));
      }
    });
  }
}
