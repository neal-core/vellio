import 'package:flutter/material.dart';

class TrackMethodScreen extends StatefulWidget {
  const TrackMethodScreen({super.key});
  _TrackMethodState createState() => _TrackMethodState();
}

class _TrackMethodState extends State<TrackMethodScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      top: true,
      bottom: false,
      left: true,
      right: true,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "How would you like to track your spending",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      "Select your preferred method. All your financial data is processed and stored only on your local device.",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
