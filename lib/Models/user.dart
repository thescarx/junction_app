class appUser {
  String? uid;
  String? fullName;
  String? email;
  String? pic;
  String? birthdate;
  bool isConnected;
  String? joinedDate;

  appUser(
      {required this.uid,
      required this.fullName,
      required this.email,
      required this.pic,
      required this.birthdate,
      required this.isConnected,
      required this.joinedDate});
}
