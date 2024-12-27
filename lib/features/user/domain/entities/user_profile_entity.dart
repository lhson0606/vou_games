import 'package:equatable/equatable.dart';

class UserProfileEntity extends Equatable {
  final int userId;
  final String userName;
  final String email;
  final String phoneNumber;
  final bool isActive;
  final DateTime createdAt;

  const UserProfileEntity({
    required this.userId,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.isActive,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [userId];
}