class TextUtils {
  static String getPostposition(String word) {
    if (word.isEmpty) {
      return '로';
    }
    final int last = word.codeUnits.last;
    // 한글 유니코드 범위: 0xAC00 ~ 0xD7A3
    if (last < 0xAC00 || last > 0xD7A3) {
      return '로';
    }
    final int jong = (last - 0xAC00) % 28;
    if (jong == 0 || jong == 8) {
      return '로';
    }
    return '으로';
  }
}
