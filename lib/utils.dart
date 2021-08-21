extension FirstWhereOrNullExtension<E> on List<E> {
  E? firstWhereOrNull(bool Function(E) test) {
    for (E element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

extension ToBonusNumber on int {

  String toBonusString() {
    if (this > 0) {
      return "+$this";
    } else {
      return this.toString();
    }
  }
}