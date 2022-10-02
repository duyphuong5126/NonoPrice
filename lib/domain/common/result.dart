abstract class Result<T> {
  const Result();

  Result<T> doOnSuccess(Function(T) onSuccess) {
    if (this is Success<T>) {
      onSuccess((this as Success<T>).data);
    }
    return this;
  }

  Result<T> doOnFailure(Function(Exception) onFailure) {
    if (this is Failure<T>) {
      onFailure((this as Failure<T>).error);
    }
    return this;
  }
}

class Success<T> extends Result<T> {
  final T data;

  const Success({required this.data});
}

class Failure<T> extends Result<T> {
  final Exception error;

  const Failure({required this.error});
}
