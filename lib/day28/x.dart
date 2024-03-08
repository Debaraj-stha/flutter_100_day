void main() {
  int num = 999999999;
  ago(num);
}

void ago(int num) {
  String result = "";
  if (num > 999 && num <= 99999) {
    result = '${(num / 1000).toStringAsFixed(0)} k';
  } else if (num > 99999 && num <= 999999) {
    result = '${(num / 10000).toStringAsFixed(1)} k';
  } else if (num > 999999 && num <= 99999999) {
    result = '${(num / 1000000).toStringAsFixed(0)} M';
  } else if (num > 99999999) {
    result = '${(num / 10000000).toStringAsFixed(0)} B';
  }
  print(result);
}
