import 'package:flutter/material.dart';
import 'package:vellio/data/track_methods.dart';
import 'package:vellio/screens/budget_screen.dart';

class TrackMethodScreen extends StatefulWidget {
  final List<String> selectedCategories;
  final String name;
  const TrackMethodScreen({
    super.key,
    required this.name,
    required this.selectedCategories,
  });
  @override
  State<TrackMethodScreen> createState() => _TrackMethodState();
}

class _TrackMethodState extends State<TrackMethodScreen> {
  String selectedTM = "default";
  @override
  void initState() {
    super.initState();
    for (var tm in trackMethods) {
      if (tm['status'] == 'selected') tm['status'] = 'unselected';
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      top: true,
      bottom: false,
      left: true,
      right: true,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Scaffold(
          body: Column(
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
              Wrap(
                direction: Axis.horizontal,
                spacing: 12,
                runSpacing: 12,
                children: trackMethods.map((mthd) {
                  return SizedBox(
                    width: double.infinity,
                    height: 150,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          gradient: isDark
                              ? const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFF545EA6),
                                    Color(0xFF2F3150),
                                  ],
                                )
                              : null,
                          color: isDark ? null : const Color(0xFFB8BBE0),
                          border: mthd['status'] == 'selected'
                              ? Border.all(
                                  color: isDark
                                      ? const Color(0xE2283081)
                                      : const Color(0xFF6E75C3),
                                  width: 1.5,
                                )
                              : null,
                          boxShadow: [
                            BoxShadow(
                              color: isDark
                                  ? const Color(0xE2202361)
                                  : const Color(0xE27F74DD),
                              blurRadius: 12,
                              spreadRadius: 1,
                            ),
                            BoxShadow(
                              color: isDark
                                  ? Color(0X59000000)
                                  : const Color(0xB3C3BAD5),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(18),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(18),
                            onTap: () {
                              setState(() {
                                mthd['status'] = mthd['status'] == 'selected'
                                    ? 'unselected'
                                    : 'selected';
                                selectedTM = mthd['status'] == 'selected'
                                    ? mthd['title']
                                    : 'default';
                                for (var mt in trackMethods) {
                                  if (selectedTM != mt['title']) {
                                    mt['status'] = 'unselected';
                                  }
                                }
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 12,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          mthd['title'],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                                // color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                        ),
                                      ),

                                      const SizedBox(width: 8),

                                      Icon(
                                        mthd['icon'],
                                        size: 32,
                                        color: Theme.of(
                                          context,
                                        ).textTheme.titleMedium?.color,
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 8),
                                  Container(
                                    height: 1,
                                    color: const Color(0x7300B878),
                                  ),
                                  const SizedBox(height: 10),
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            mthd['desc'],
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                  // color: Color(0xE4FFFFFF),
                                                  fontSize: 15,
                                                  height: 1.25,
                                                ),
                                          ),
                                        ),

                                        const SizedBox(width: 12),

                                        Container(
                                          width: 54,
                                          height: 54,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: mthd['status'] == 'selected'
                                                ? const Color(0xFF00D98B)
                                                : const Color(0xFFF70808),
                                            boxShadow: [
                                              BoxShadow(
                                                color:
                                                    mthd['status'] == 'selected'
                                                    ? const Color(0x7300E89A)
                                                    : const Color(0x5AFF0000),
                                                blurRadius: 10,
                                              ),
                                            ],
                                          ),
                                          child: Icon(
                                            mthd['status'] == 'selected'
                                                ? Icons.check
                                                : Icons.close,
                                            color: mthd['status'] == 'selected'
                                                ? Color(0xFFE4D3D3)
                                                : Colors.black87,
                                            size: 34,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(width: double.infinity, height: 20),
              SizedBox(
                width: double.infinity,
                height: 75,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: selectedTM != "default"
                        ? () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BudgetScreen(
                                name: widget.name,
                                selectedCategories: widget.selectedCategories,
                                selectedMethod: selectedTM,
                              ),
                            ),
                          )
                        : null,
                    child: Text(
                      "Continue",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
