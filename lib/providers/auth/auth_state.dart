import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;

enum AuthStatus {
  unknown,
  authenticated,
  unauthenticated,
}

class AuthState extends Equatable {
  final AuthStatus authStatus;
  final fbAuth.User? user;

  const AuthState({
    required this.authStatus,
    this.user,
  });

  factory AuthState.unknown() {
    return const AuthState(authStatus: AuthStatus.unknown);
  }

  @override
  List<Object?> get props => [authStatus, user];

  @override
  String toString() {
    return 'AuthState{authStatus: $authStatus, user: $user}';
  }

  AuthState copyWith({
    AuthStatus? authStatus,
    fbAuth.User? user,
  }) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      user: user ?? this.user,
    );
  }
}
