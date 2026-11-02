class UserModel {
  const UserModel({
    this.userId = '',
    required this.name,
    required this.email,
    required this.phone,
    required this.parentAccount,
    required this.subscription,
  });

  final String userId;
  final String name;
  final String email;
  final String phone;
  final String parentAccount;
  final String subscription;



  String get plan => subscription.replaceFirst('Calley ', '');
  String get initial => name.isEmpty ? '?' : name[0].toUpperCase();

  // TODO: replace with UserModel.fromJson when the API is ready.
  static const UserModel dummy = UserModel(
    name: 'Swati',
    email: 'swati@cstech.in',
    phone: '9971125588',
    parentAccount: 'NA',
    subscription: 'Calley Personal', userId: '',
  );
}
