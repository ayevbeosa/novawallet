abstract final class AppRoutes {
  static const wallet = '/';
  static const save = '/save';
  static const settings = '/settings';
  static const send = '/send';
  static const transactions = '/wallet/transactions';
  static const createGoal = '/save/create';
  static const goalDetails = '/save/:goalId';

  static String goalDetailsWithId(String id) => '/save/$id';
}
