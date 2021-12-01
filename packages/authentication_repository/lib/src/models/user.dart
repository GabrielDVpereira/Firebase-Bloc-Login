import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? email;
  final String id;
  final String? name;
  final String? photo;

  const User({
    required this.id,
    this.email,
    this.name,
    this.photo,
  });

  factory User.initial() {
    return User(id: '');
  }

  static const empty = User(id: '');

  bool get isEmpty => this == User.initial();
  bool get isNotEmpty => this != User.initial();

  @override
  List<Object?> get props => [id, email, name, photo];
}
