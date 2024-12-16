class UserCredentialService {
  bool isLoggedIn;
  bool hasRememberedUser;
  String userToken = '';

  UserCredentialService({this.isLoggedIn = false, this.hasRememberedUser = false});
}