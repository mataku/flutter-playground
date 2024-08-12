sealed class Result<T> {
  const Result();

  factory Result.progress(bool loading) = Progress<T>;
  factory Result.success(T data) = Success<T>;
  factory Result.failure(Error throwable) = Failure<T>;

  T? getOrNull() {
    if (this is Success<T>) {
      return (this as Success<T>).data;
    }
    return null;
  }

  Error? exceptionOrNull() {
    if (this is Failure<T>) {
      return (this as Failure<T>).throwable;
    }
    return null;
  }
}

class Progress<T> extends Result<T> {
  final bool loading;

  Progress(this.loading);
}

class Success<T> extends Result<T> {
  final T data;

  Success(this.data);
}

class Failure<T> extends Result<T> {
  final Error throwable;

  Failure(this.throwable);
}
