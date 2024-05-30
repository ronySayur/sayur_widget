class YurConvert {
  //Convert Hari Weekday(angka) ke Nama Hari
  static String hariWeekday(int weekday) {
    switch (weekday) {
      case 1:
        return "Senin";
      case 2:
        return "Selasa";
      case 3:
        return "Rabu";
      case 4:
        return "Kamis";
      case 5:
        return "Jumat";
      case 6:
        return "Sabtu";
      case 7:
        return "Minggu";
      default:
        return "Hari tidak ditemukan";
    }
  }
}
