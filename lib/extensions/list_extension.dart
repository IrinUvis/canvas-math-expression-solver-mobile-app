extension MoveElement<T> on List<T> {
  void move(int from, int to) {
    RangeError.checkValidIndex(from, this, "from", length);
    RangeError.checkValidIndex(to, this, "to", length);
    var element = this[from];
    if (from < to) {
      this.setRange(from, to, this, from + 1);
    } else {
      this.setRange(to + 1, from + 1, this, to);
    }
    this[to] = element;
  }
}
