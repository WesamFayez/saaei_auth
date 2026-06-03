import 'package:equatable/equatable.dart';
import '../../../../data/entity/user.dart';

abstract class ResetPasswordState extends Equatable {
  const ResetPasswordState();

  @override
  List<Object?> get props => [];
}

class ResetPasswordInitial extends ResetPasswordState {}

class ResetPasswordLoading extends ResetPasswordState {}

class ResetPasswordSuccess extends ResetPasswordState {
  final User user;
  const ResetPasswordSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class ResetPasswordError extends ResetPasswordState {
  final String message;
  const ResetPasswordError(this.message);

  @override
  List<Object?> get props => [message];
}
