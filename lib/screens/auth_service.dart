import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthResult {
  final bool success;
  final String? errorMessage;
  final AuthStatus status;

  AuthResult({
    required this.success, 
    this.errorMessage, 
    this.status = AuthStatus.unknown
  });
}

enum AuthStatus {
  unknown,
  emailNotConfirmed,
  invalidCredentials,
  networkError,
  success
}

class AuthService extends ChangeNotifier {
  final _supabase = Supabase.instance.client;
  User? _currentUser;

  User? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  AuthService() {
    _supabase.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      if (event == AuthChangeEvent.signedIn) {
        _currentUser = data.session?.user;
        notifyListeners();
      } else if (event == AuthChangeEvent.signedOut) {
        _currentUser = null;
        notifyListeners();
      }
    });
  }

  Future<AuthResult> signUp({
    required String email, 
    required String password,
    required String name,
  }) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {'name': name}
      );
      
      if (response.user != null) {
        _currentUser = response.user;
        notifyListeners();
        return AuthResult(
          success: true, 
          status: AuthStatus.success,
          errorMessage: 'Please check your email to confirm your account'
        );
      } else {
        return AuthResult(
          success: false, 
          errorMessage: 'Unable to create account. Please try again.',
          status: AuthStatus.unknown
        );
      }
    } on AuthException catch (e) {
      return AuthResult(
        success: false, 
        errorMessage: e.message,
        status: AuthStatus.unknown
      );
    } catch (e) {
      return AuthResult(
        success: false, 
        errorMessage: 'An unexpected error occurred',
        status: AuthStatus.unknown
      );
    }
  }

  Future<AuthResult> signIn({
    required String email, 
    required String password
  }) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password
      );
      
      if (response.user != null) {
        // Check email confirmation status
        if (response.user?.emailConfirmedAt == null) {
          return AuthResult(
            success: false, 
            errorMessage: 'Please confirm your email before logging in',
            status: AuthStatus.emailNotConfirmed
          );
        }

        _currentUser = response.user;
        notifyListeners();
        return AuthResult(
          success: true, 
          status: AuthStatus.success
        );
      } else {
        return AuthResult(
          success: false, 
          errorMessage: 'Invalid credentials',
          status: AuthStatus.invalidCredentials
        );
      }
    } on AuthException catch (e) {
      // Handle specific Supabase auth exceptions
      if (e.message.contains('Email not confirmed')) {
        return AuthResult(
          success: false, 
          errorMessage: 'Please confirm your email before logging in',
          status: AuthStatus.emailNotConfirmed
        );
      }
      return AuthResult(
        success: false, 
        errorMessage: e.message,
        status: AuthStatus.invalidCredentials
      );
    } catch (e) {
      return AuthResult(
        success: false, 
        errorMessage: 'An unexpected error occurred',
        status: AuthStatus.networkError
      );
    }
  }

  Future<void> resendEmailConfirmation(String email) async {
    try {
      await _supabase.auth.resend(
        type: OtpType.signup,
        email: email,
      );
    } catch (e) {
      print('Error resending confirmation email: $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
    _currentUser = null;
    notifyListeners();
  }
}