import 'dart:io';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:path_provider/path_provider.dart';

class OnboardingDataManager {
  static const _fileName = "onbdt.lnl";
  final _secureStorage = FlutterSecureStorage();
  static const _keyName = 'odm-key';
  Future<File> get _getFile async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$_fileName');
  }

  Future<enc.Key> _getKey() async {
    final base64Key = await _secureStorage.read(key: _keyName);
    if (base64Key == null) {
      final newKey = enc.Key.fromSecureRandom(32);
      await _secureStorage.write(key: _keyName, value: newKey.base64);
      return newKey;
    }
    return enc.Key.fromBase64(base64Key);
  }

  Future<void> writeFile({
    required String name,
    required List<String> categories,
    required String trackMethod,
    required double budget,
  }) async {
    final key = await _getKey();
    final iv = enc.IV.fromSecureRandom(16);
    final Map<String, dynamic> obItems = {
      'name': name,
      'categories': categories,
      'track_method': trackMethod,
      'budget': budget,
    };
    String jsonItems = jsonEncode(obItems);
    final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc));
    final encryptedData = encrypter.encrypt(jsonItems, iv: iv);
    String payload = "${iv.base64}:${encryptedData.base64}";
    final file = await _getFile;
    await file.writeAsString(payload, mode: FileMode.writeOnly);
  }

  Future<Map<String, dynamic>?> readFile() async {
    try {
      final file = await _getFile;
      if (!await file.exists()) return null;
      final key = await _getKey();
      final data = await file.readAsString();
      List<String> parts = data.split(":");
      final iv = enc.IV.fromBase64(parts[0]);
      final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc));
      final encryptedData = encrypter.decrypt(
        enc.Encrypted.from64(parts[1]),
        iv: iv,
      );
      final jsonData = jsonDecode(encryptedData);
      return jsonData;
    } catch (e) {
      print("Failed to read file: $e");
      return null;
    }
  }

  Future<void> deleteFile() async {
    final docFile = await _getFile;
    await docFile.delete();
  }
}
