abstract class Database {
  String name();
  String phone();
}

class MyData implements Database {
  @override
  String name() {
    String displayName = "Tanmay";
    return displayName;
  }

  @override
  String phone() {
    String phoneNumber = "+91 98XXXXXXXX";
    return phoneNumber;
  }
}
