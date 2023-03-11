class appUser {
  String? uid;
  String? fullName;
  String? email;
  String? pic;
  String? birthdate;
  bool isConnected;
  late String connectedEmail;
  late String connectedPwd;
  String? joinedDate;

  appUser(
      {required this.uid,
      required this.fullName,
      required this.email,
      required this.pic,
      required this.birthdate,
      required this.isConnected,
      required this.joinedDate});

      setEmail(email,pwd){
    connectedEmail=email;
    connectedPwd=pwd;
  }
}
