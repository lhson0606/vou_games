import 'package:equatable/equatable.dart';

class SystemMessageEntity extends Equatable {
  final String message;

  const SystemMessageEntity({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
