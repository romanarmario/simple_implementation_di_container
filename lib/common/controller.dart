import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:mutex/mutex.dart';

abstract class ControllerBase<T> with ChangeNotifier {
  ControllerBase(this._state);

  T _state;
  T get state => _state;

  void setState(T newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> execute(FutureOr<void> Function() handler);
}

class ConcurrentController<T> extends ControllerBase<T> {
  ConcurrentController(super.state);

  @override
  Future<void> execute(FutureOr<void> Function() handler) async {
    await handler.call();
  }
}

class SequentialController<T> extends ControllerBase<T> {
  SequentialController(super.state);

  final _mutex = Mutex();

  @override
  Future<void> execute(FutureOr<void> Function() handler) async {
    _mutex.protect(() async => await handler.call());
  }
}

class DroppableController<T> extends ControllerBase<T> {
  DroppableController(super.state);

  bool inProcessing = false;

  @override
  Future<void> execute(FutureOr<void> Function() handler) async {
    if (inProcessing) return;

    try {
      inProcessing = true;

      await handler.call();
    } finally {
      inProcessing = false;
    }
  }
}
