import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vellio/components/quick_action_button.dart';
import 'package:vellio/services/onboarding_data_manager.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late Future<Map<String, dynamic>> obData;
  late String username = "...";
  late String amount = "0.0";
  List<String> cats = [];
  void fetchUserData() async {
    final OnboardingDataManager dataManager = OnboardingDataManager();
    Map<String, dynamic> userdata = await dataManager.readFile() ?? {};
    final String tempHolder = userdata['name'] as String;
    username = tempHolder.split(" ")[0];
    final double tempBudget = userdata['budget'];
    amount = NumberFormat('#,###.##').format(tempBudget);
  }

  @override
  void initState() {
    super.initState();
    obData = fetchObData();
    fetchUserData();
  }

  Future<Map<String, dynamic>> fetchObData() async {
    final OnboardingDataManager manager = OnboardingDataManager();
    final Map<String, dynamic>? dataFetched = await manager.readFile();
    return dataFetched ?? {};
  }

  final List<Map<String, dynamic>> myTransactions = [
    {"title": "Opay Transfer", "amount": 2500, "isDebit": true, "time": "Today, 10:42 AM"},
    {"title": "Salary Deposit", "amount": 150000, "isDebit": false, "time": "Yesterday, 08:00 AM"},
    {"title": "Airtime Recharge", "amount": 1000, "isDebit": true, "time": "Sep 12, 02:15 PM"},
  ];

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
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
                      children: [
                        Text(
                          "Welcome back",
                          style: Theme.of(
                            context,
                          ).textTheme.titleSmall?.copyWith(fontSize: 14),
                        ),
                        SizedBox(height: 4),
                        Text(
                          username,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE1E2F4),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: IconButton(
                        onPressed: () => print("Settings page"),
                        icon: Icon(
                          Icons.settings_outlined,
                          color: Theme.of(context).textTheme.titleMedium?.color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        isDark ? const Color(0xFF27214F) : const Color(0xFF7D70C9),
                        isDark ? const Color(0xFF545EA6) : const Color(0xFF9CA5E6),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x3D545EA6),
                        blurRadius: 24,
                        offset: const Offset(0, 12),
                      ),
                    ],
                    border: Border.all(
                      color: const Color(0x4C6E75C3),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Balance",
                        style: Theme.of(
                          context,
                        ).textTheme.titleSmall?.copyWith(fontSize: 16, color: isDark ? Theme.of(context).textTheme.titleSmall?.color : Color(0xFFD9D3FE)),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "₦ $amount",
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontSize: 40,
                          color: Color(0xFFFFFFFF),
                          letterSpacing: -1.0,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          QuickActionButton(
                            title: "Add Expense",
                            icon: Icons.remove_circle_outline,
                            color: isDark ? Color(0xFFEF4444) : Color(0xFFA95A6B),
                            subFn: () {},
                          ),
                          const SizedBox(width: 12),
                          QuickActionButton(
                            title: "Add Income",
                            icon: Icons.add_circle_outline,
                            color: isDark ? Color(0xFF10B981) : Color(0xFF427467),
                            subFn: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 24.0,
                  right: 24.0,
                  top: 32.0,
                  bottom: 16.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recent Transactions",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    TextButton(onPressed: () {}, child: Text("View All", style: Theme.of(context).textTheme.titleSmall,))
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final transaction = myTransactions[index];
                  final bool isDebit = transaction["isDebit"];
                  final String title = transaction["title"];
                  final String time = transaction["time"];
                  final String amountStr = "${isDebit ? '-' : '+'}₦${NumberFormat('#,###.##').format(transaction['amount'])}";

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE8EAF6),
                        borderRadius: BorderRadius.circular(16),
                        border: isDark ? null : Border.all(color: const Color(0xFFA9AABC), width: 1)
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: isDebit ? const Color(0xFF450A0A) : const Color(0xFF064E3B),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              isDebit ? Icons.arrow_outward : Icons.arrow_downward,
                              color: isDebit ? const Color(0xFFF87171) : const Color(0xFF34D399),
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  time,
                                  style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            amountStr,
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(color: isDebit ? Theme.of(context).textTheme.titleMedium?.color : Color(0xFF34D399)),
                            // style: TextStyle(
                            //   color: isDebit ? Colors.white : const Color(0xFF34D399),
                            //   fontSize: 16,
                            //   fontWeight: FontWeight.bold,
                            // ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                // 3. Crucial step: Tell the list exactly how many items to render
                childCount: myTransactions.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
