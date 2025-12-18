import 'package:flutter/material.dart';
import 'api_endpoints.dart';
import 'api_service.dart';

class AuthProviders extends ChangeNotifier {
  bool loading = false;

  Future<String> createAccount({
    required String name,
    required String email,
    required String phone,
    required String gender,
    required String address,
    required String city,
    required String state,
    required String dob,
  }) async {
    loading = true;
    notifyListeners();

    try {
      final response = await ApiService.post(
        ApiEndpoints.createUser,
        {
          "name": name,
          "email": email,
          "phone_number": phone,
          "gender": gender.toLowerCase(),
          "address": address,
          "city": city,
          "state": state,
          "date_of_birth": dob,
        },
      );

      debugPrint("CREATE ACCOUNT RESPONSE 👉 $response");

      loading = false;
      notifyListeners();

      final message = (response["message"] ?? "").toString().toLowerCase();

      if (response["status"] == true ||
          response["status"] == 1 ||
          response["success"] == true) {
        return "success";
      }

      if (message.contains("already") ||
          message.contains("exist") ||
          message.contains("registered")) {
        return "already";
      }

      return "failed";
    } catch (e) {
      loading = false;
      notifyListeners();
      debugPrint("Create account error ❌ $e");
      return "failed";
    }
  }
}
