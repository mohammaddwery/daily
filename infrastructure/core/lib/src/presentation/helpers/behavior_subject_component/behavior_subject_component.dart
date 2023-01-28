import 'package:rxdart/rxdart.dart';

class BehaviorSubjectComponent<T> {
  final BehaviorSubject<T?> _controller = BehaviorSubject<T?>();
  ValueStream<T?> get stream => _controller.stream;
  T? getValue() => _controller.valueOrNull;
  void setValue(T value) => _controller.sink.add(value);

  dispose() => _controller.close();
}