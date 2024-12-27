import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final DateTime date;
  final bool isRead;

  const NotificationEntity(
      {required this.id,
      required this.title,
      required this.description,
      required this.date,
      required this.isRead});

  @override
  List<Object?> get props => [id];
}
