class TimeService {
  String morningOrAfternoon(int hourOfDay) {
    if (hourOfDay == null) return "";
    if (hourOfDay >= 12) {
      return "A F T E R N O O N\r\n";
    } else {
      return "M O R N I N G\r\n";
    }
  }
}
