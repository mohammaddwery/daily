
abstract class UseCase<Output, Param> {
  Future<Output> call(Param param);
}

class NoParams {
  const NoParams._internal();

  static const NoParams _instance = NoParams._internal();

  factory NoParams() => _instance;
}