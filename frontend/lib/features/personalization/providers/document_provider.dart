import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frontend/core/utils/constants/api_constants.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:frontend/common/widgets/alert_box/snackbar.dart';
import 'package:frontend/core/utils/constants/colors.dart';

class DocumentProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  /// **1️⃣ Add a Document**
  Future<void> addDocument({
    required String title,
    required String category,
    required File file,
    required BuildContext context,
  }) async {
    try {
      final box = GetStorage();
      String? token = box.read('token');
      _isLoading = true;
      notifyListeners();

      var uri = Uri.parse('$kAppBaseUrl/api/users/document/');

      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'Authorization': 'Bearer $token',
          'Content-Type': 'multipart/form-data',
        })
        ..fields['title'] = title
        ..fields['category'] = category
        ..files.add(await http.MultipartFile.fromPath('file', file.path));

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 201) {
        KSnackbar.CustomSnackbar(
            context, "Document added successfully", KColors.success);
      } else {
        KSnackbar.CustomSnackbar(
            context, "Upload failed: $responseBody", KColors.error);
      }
    } catch (e) {
      KSnackbar.CustomSnackbar(context, "Error: $e", KColors.error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// **2️⃣ Update a Document**
  Future<void> updateDocument({
    required String documentId,
    required String title,
    required String category,
    File? file, // Optional file for update
    required BuildContext context,
  }) async {
    try {
      final box = GetStorage();
      String? token = box.read('token');
      _isLoading = true;
      notifyListeners();

      var uri = Uri.parse('$kAppBaseUrl/api/users/document/$documentId');

      var request = http.MultipartRequest('PUT', uri)
        ..headers.addAll({
          'Authorization': 'Bearer $token',
          'Content-Type': 'multipart/form-data',
        })
        ..fields['title'] = title
        ..fields['category'] = category;

      if (file != null) {
        request.files.add(await http.MultipartFile.fromPath('file', file.path));
      }

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        KSnackbar.CustomSnackbar(
            context, "Document updated successfully", KColors.success);
      } else {
        KSnackbar.CustomSnackbar(
            context, "Update failed: $responseBody", KColors.error);
      }
    } catch (e) {
      KSnackbar.CustomSnackbar(context, "Error: $e", KColors.error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// **3️⃣ Delete a Document**
  Future<void> deleteDocument({
    required String documentId,
    required BuildContext context,
  }) async {
    try {
      final box = GetStorage();
      String? token = box.read('token');
      _isLoading = true;
      notifyListeners();

      var response = await http.delete(
        Uri.parse('$kAppBaseUrl/api/users/document/$documentId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        KSnackbar.CustomSnackbar(
            context, "Document deleted successfully", KColors.success);
      } else {
        KSnackbar.CustomSnackbar(
            context, "Delete failed: ${response.body}", KColors.error);
      }
    } catch (e) {
      KSnackbar.CustomSnackbar(context, "Error: $e", KColors.error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
