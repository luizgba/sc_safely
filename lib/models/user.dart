import 'dart:html';
import 'package:flutter/material.dart';

class User {
  final String? id;
  final String? nome;
  final String? email;
  final String? senha;

  const User({
    @required this.id,
    @required this.nome,
    @required this.email,
    @required this.senha,
  });
}
