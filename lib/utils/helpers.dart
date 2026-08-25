String formatIndianNumber(double amount) {
  final rounded = amount.round().toString();
  if (rounded.length <= 3) return rounded;
  final lastThree = rounded.substring(rounded.length - 3);
  var remaining = rounded.substring(0, rounded.length - 3);
  final groups = <String>[];
  while (remaining.length > 2) {
    groups.insert(0, remaining.substring(remaining.length - 2));
    remaining = remaining.substring(0, remaining.length - 2);
  }
  if (remaining.isNotEmpty) groups.insert(0, remaining);
  return '${groups.join(',')},$lastThree';
}
