import 'package:rxdart/rxdart.dart';

class SeededBehaviorSubjectComponent<T> {
  SeededBehaviorSubjectComponent(T seedValue) {
    _controller = BehaviorSubject.seeded(seedValue);
  }

  late final BehaviorSubject<T> _controller;
  ValueStream<T> get stream => _controller.stream;
  T getValue() => _controller.value;
  void setValue(T value) => _controller.sink.add(value);

  dispose() => _controller.close();
}