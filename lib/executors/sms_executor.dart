// import 'package:telephony/telephony.dart';
//
// @pragma("vm:entry-point")
// void backgroundMessageHandler(SmsMessage message) async {
//   final String sender = message.address ?? "Unknown";
//   final String body = message.body ?? "";
//   print("Background Wakeup....Received sms from $sender: $body");
// }
//
// class SmsExecutor {
//   static final Telephony telephony = Telephony.instance;
//   static Future<void> initialize() async {
//     bool? permissionsGranted = await telephony.requestPhoneAndSmsPermissions;
//     if (permissionsGranted != null && permissionsGranted) {
//       telephony.listenIncomingSms(
//         onNewMessage: (SmsMessage message) {
//           print("Foreground sms: ${message.body}");
//         },
//         onBackgroundMessage: backgroundMessageHandler,
//       );
//       print("SMS executor successfully listening");
//     } else {
//       print("User denied SMS permissions");
//     }
//   }
// }
