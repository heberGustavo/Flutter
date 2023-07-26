import 'package:flutter/cupertino.dart';

class User{
  final String id;
  final String nome;
  final String email;
  final String avatarURL;
  
  const User({
    this.id, //Aceita receber nulo pq quando criar o usuario vai gerar o ID
    @required this.nome,
    @required this.email,
    @required this.avatarURL,
  });
}