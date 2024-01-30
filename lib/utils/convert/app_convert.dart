class AppConvert {
  static String formatMoney(double money) {
    String formattedMoney = money.toStringAsFixed(0);
    formattedMoney = formattedMoney.replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');
    formattedMoney += "đ";
    return formattedMoney;
  }

  static String formatLikes(double likes) {
    if (likes >= 1000000) {
      double likesInMillions = likes / 1000000;
      return '${likesInMillions.toStringAsFixed(1)}M';
    } else if (likes >= 1000) {
      double likesInThousands = likes / 1000;
      return '${likesInThousands.toStringAsFixed(1)}K';
    } else if (likes == likes.toInt().toDouble()) {
      return likes.toInt().toString();
    } else {
      return likes.toString();
    }
  }
}
