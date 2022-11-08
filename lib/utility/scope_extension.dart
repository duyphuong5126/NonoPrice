extension ScopeExtension<T> on T {
  O transform<O>(O Function(T) doSomething) {
    return doSomething(this);
  }

  void perform(Function(T) action) {
    action(this);
  }
}
