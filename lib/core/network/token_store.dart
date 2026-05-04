class TokenStore {
  String? _token;

  String? get token => _token;

  void setToken(String? token) {
    if (token == null || token.isEmpty) {
      _token = null;
      return;
    }
    _token = token;
  }

  void clear() {
    _token = null;
  }
}
