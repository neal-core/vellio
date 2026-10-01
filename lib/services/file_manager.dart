import 'dart:convert';
import 'dart:io';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';

enum DataTypes { onboarding, transactional, settings }

class FileManager {
  final String fileName;
  final String keyName;
  FileManager({required this.fileName, required this.keyName});
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  Future<File> get getFile async {
    final dir = await getApplicationDocumentsDirectory();
    return File("${dir.path}/$fileName.lnl");
  }

  Future<enc.Key> get getKey async {
    final base64Key = await _secureStorage.read(key: keyName);
    if (base64Key == null) {
      final newKey = enc.Key.fromSecureRandom(32);
      _secureStorage.write(key: keyName, value: newKey.base64);
      return newKey;
    }
    return enc.Key.fromBase64(base64Key);
  }

  Future<void> writeFile(Map<String, dynamic> data, DataTypes dataType) async {
    final file = await getFile;
    final key = await getKey;
    var mode = "write";
    switch (dataType) {
      case DataTypes.onboarding:
        mode = "write";
      case DataTypes.settings:
        mode = "write";
      case DataTypes.transactional:
        mode = "append";
    }
    ;
    final iv = enc.IV.fromSecureRandom(16);
    final encodedData = jsonEncode(data);
    final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc));
    final encryptedData = encrypter.encrypt(encodedData, iv: iv);
    final payload = "${iv.base64}:${encryptedData.base64}";
    await file.writeAsString(
      payload,
      mode: mode == "append" ? FileMode.writeOnlyAppend : FileMode.writeOnly,
    );
  }

  Future<dynamic> readFile() async {
    final file = await getFile;
    final key = await getKey;
    if (!(await file.exists())) return null;
    final String rawData = await file.readAsString();
    final List<String> payload = rawData.split(":");
    final iv = enc.IV.fromBase64(payload[0]);
    final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc));
    final String extractedData = encrypter.decrypt(
      enc.Encrypted.from64(payload[1]),
      iv: iv,
    );
    final decodedData = jsonDecode(extractedData);
    return decodedData;
  }
}
