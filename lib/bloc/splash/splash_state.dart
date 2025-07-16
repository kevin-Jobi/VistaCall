abstract class SplashState {}

class SplashLoadingState extends SplashState {}

class SplashNavigateState extends SplashState {
  final String route;

  SplashNavigateState(this.route);
}