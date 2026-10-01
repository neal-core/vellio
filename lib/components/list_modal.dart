import 'package:flutter/material.dart';
import 'package:vellio/services/color_manager.dart';

class ListModal {
  final List<Map<String, dynamic>> modalValue;
  final String title;
  final String defaultValue;
  final BuildContext ctx;
  final Widget? trailingWidget;
  final StateSetter pageState;
  final Function(String) saveSelectedValue;
  const ListModal({
    required this.modalValue,
    required this.title,
    required this.ctx,
    this.trailingWidget,
    required this.defaultValue,
    required this.saveSelectedValue,
    required this.pageState,
  });

  Future<dynamic> showModal() {
    late String selectedItem = defaultValue;
    return showModalBottomSheet(
      context: ctx,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter modalState) {
            final ColorManager colorManager = ColorManager(context: context);
            return Container(
              decoration: BoxDecoration(
                color: colorManager.themeColSet(0xFFF6F6FA, 0xFF1A1D2E),
                borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: DraggableScrollableSheet(expand: false, builder: (BuildContext context, ScrollController scrollController) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 16),
                        ...modalValue.map((value) {
                          return ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                value['icon'],
                                width: 32,
                                height: 32,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stacktrace) {
                                  return Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF7D70C9),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        value['name'][0],
                                        style: Theme.of(
                                          context,
                                        ).textTheme.labelSmall,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            title: Text(
                              value['name'],
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            trailing: selectedItem == value['id']
                                ? trailingWidget
                                : null,
                            onTap: () {
                              modalState(() {
                                selectedItem = value['id'];
                              });
                              saveSelectedValue(selectedItem);
                              Navigator.pop(context);
                              pageState(() {});
                            },
                          );
                        }),
                      ],
                    );
                  })
                ),
              ),
            );
          },
        );
      },
    );
  }
}
