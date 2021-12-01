part of 'app_bloc.dart';

enum AppStatus {
  authenticated,
  unauthenticated,
}

class AppState extends Equatable {
  final AppStatus status;
  final User user;

  const AppState._({
    required this.status,
    this.user = User.empty,
  });

  const AppState.authenticated(User user)
      : this._(user: user, status: AppStatus.authenticated);

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  @override
  List<Object> get props => [status, user];
}
