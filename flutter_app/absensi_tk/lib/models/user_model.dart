class User {

  final int idUser;
  final String username;

  User({
    required this.idUser,
    required this.username,
  });

  factory User.fromJson(Map<String,dynamic> json){
    return User(
      idUser: json["idUser"],
      username: json["username"],
    );
  }

}