enum AppRoute {
  splash(path: '/splash', name: 'splash'),
  onBoarding(path: '/on_boarding', name: 'on_boarding'),
  signUp(path: '/sign_up', name: 'signUp'),
  signIn(path: '/sign_in', name: 'signIn'),
  otp(path: '/otp', name: 'otp'),
  forgotPassword(path: '/forgot_password', name: 'forgotPassword'),
  resetPassword(path: '/reset_password', name: 'resetPassword'),
  home(path: '/home', name: 'home'),
  editProfile(path: '/edit_profile', name: 'editProfile'),
  notification(path: '/notification', name: 'notification'),
  policy(path: '/policy', name: 'policy'),
  profile(path: '/profile', name: 'profile');

  final String path;
  final String name;

  const AppRoute({required this.path, required this.name});
}
