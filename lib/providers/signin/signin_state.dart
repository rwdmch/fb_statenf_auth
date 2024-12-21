import 'package:equatable/equatable.dart';
import 'package:fb_statenf_auth/models/custom_error.dart';

enum SigninStatus {
  initial,
  submitting,
  success,
  error,
}

class SigninState extends Equatable {
  final SigninStatus signinStatus;
  final CustomError error;

  const SigninState({
    required this.signinStatus,
    required this.error,
  });

  factory SigninState.initial() {
    return const SigninState(
      signinStatus: SigninStatus.initial,
      error: CustomError(),
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw [signinStatus, error];

  @override
  String toString() {
    return 'SigninState{signinStatus: $signinStatus, error: $error}';
  }

  SigninState copyWith({
    SigninStatus? signinStatus,
    CustomError? error,
  }) {
    return SigninState(
      signinStatus: signinStatus ?? this.signinStatus,
      error: error ?? this.error,
    );
  }
}
