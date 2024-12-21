import 'package:equatable/equatable.dart';
import 'package:fb_statenf_auth/models/custom_error.dart';

enum SignupStatus {
  initial,
  submitting,
  success,
  error,
}

class SignupState extends Equatable {
  final SignupStatus signupStatus;
  final CustomError error;

  const SignupState({
    required this.signupStatus,
    required this.error,
  });

  factory SignupState.initial() {
    return const SignupState(
      signupStatus: SignupStatus.initial,
      error: CustomError(),
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw [signupStatus, error];

  @override
  String toString() {
    return 'SignupState{signupStatus: $signupStatus, error: $error}';
  }

  SignupState copyWith({
    SignupStatus? signupStatus,
    CustomError? error,
  }) {
    return SignupState(
      signupStatus: signupStatus ?? this.signupStatus,
      error: error ?? this.error,
    );
  }
}
