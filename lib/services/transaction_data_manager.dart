import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:vellio/components/transaction_dialog.dart';

class TransactionDataManager {
  static const String _keyName = 'ln_tdm';
  static const String _fileName = 'trnsc.lnl';
  final _secureStorage = FlutterSecureStorage();
  Future<File> get _getFile async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$_fileName');
  }
  Future<enc.Key> _getKey() async {
    final base64key = await _secureStorage.read(key: _keyName);
    if (base64key == null) {
      final newKey = enc.Key.fromSecureRandom(32);
      await _secureStorage.write(key: _keyName, value: newKey.base64);
      return newKey;
    }
    return enc.Key.fromBase64(base64key);
  }
  Future<void> writeFile({
    required String title,
    required double amount,
    required TransactionType transaction,
    required String time
}) async {
    final file = await _getFile;
    final key = await _getKey();
    final iv = enc.IV.fromSecureRandom(16);
    final List<Map<String, dynamic>> data = [
      {
        'title': title,
        'amount': amount,
        'transaction_type': transaction,
        'time': time
      }
    ];
    final encodedData = jsonEncode(data);
    final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc));
    final encrypted = encrypter.encrypt(encodedData, iv: iv);
    final String payload = "${iv.base64}:${encrypted.base64}";
    await file.writeAsString(payload, mode: FileMode.writeOnly);
  }
  Future<List<Map<String, dynamic>>> readFile() async {
    final file = await _getFile;
    final key = await _getKey();
    final rawData = await file.readAsString();
    final splitData = rawData.split(':');
    if (splitData.length < 2) return [];
    final iv = enc.IV.fromBase64(splitData[0]);
    final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc));
    final decryptedData = encrypter.decrypt(enc.Encrypted.from64(splitData[1]), iv: iv);
    final List<Map<String, dynamic>> decodedData = jsonDecode(decryptedData);
    return decodedData;
  }

  Future<int> updateFile({
    required String title,
    required double amount,
    required TransactionType transaction,
    required String time
}) async {
   final File file = await _getFile;
   final key = await _getKey();
   final String rawData = await file.readAsString();
   final List<String> splitData = rawData.split(':');
   if (splitData.length < 2) return 1;
   final iv = enc.IV.fromBase64(splitData[0]);
   final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc));
   final decryptedData = encrypter.decrypt(enc.Encrypted.from64(splitData[1]), iv: iv);
   final List<Map<String, dynamic>> decodedData = await jsonDecode(decryptedData);
   if (decodedData.isEmpty) return 1;
   final Map<String, dynamic> inputData = {
     'title': title,
     'amount': amount,
     'transaction_type': transaction,
     'time': time
   };
   decodedData.insert(0, inputData);
   final encodedData = jsonEncode(decodedData);
   final encryptedData = encrypter.encrypt(encodedData, iv: iv);
   final payload = "${iv.base64}:${encryptedData.base64}";
   await file.writeAsString(payload, mode: FileMode.writeOnly);
   return 0;
  }

}