import 'package:flutter/material.dart';
import 'package:vellio/services/onboarding_data_manager.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late Future<Map<String, dynamic>> obData;
  List<String> cats = [];
  @override
  void initState() {
    super.initState();
    obData = fetchObData();
  }

  Future<Map<String, dynamic>> fetchObData() async {
    final OnboardingDataManager manager = OnboardingDataManager();
    final Map<String, dynamic>? dataFetched = await manager.readFile();
    return dataFetched ?? {};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text("Welcome back")],
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
