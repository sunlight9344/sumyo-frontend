import 'package:flutter/material.dart';
import 'package:v2/repositories/token_repository.dart';

class TokenProvider with ChangeNotifier {
  late String _token;
  final TokenRepository tokenRepository;

  TokenProvider({required this.tokenRepository});

  String? get token => _token;

  Future<void> fetchToken() async {
    String deviceId = await tokenRepository.getDeviceId();
    _token = deviceId;
    notifyListeners();
  }
}
