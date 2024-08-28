abstract interface class AuthRepository {
  signupWithEmailPassword(
      {required String name, required String email, required String password});
  loginWithEmailPassword({required String email, required String password});
}
