import 'package:equatable/equatable.dart';
import '../../../../data/entity/user.dart';

abstract class VerificationState extends Equatable {
  const VerificationState();

  @override
  List<Object?> get props => [];
}

class VerificationInitial extends VerificationState {}

class VerificationLoading extends VerificationState {}

class VerificationSuccess extends VerificationState {
  final User user;
  const VerificationSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class VerificationError extends VerificationState {
  final String message;
  const VerificationError(this.message);

  @override
  List<Object?> get props => [message];
}
