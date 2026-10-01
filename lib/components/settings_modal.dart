import 'package:flutter/material.dart';

/*
class SettingsModal {
  final BuildContext context;
  const SettingsModal({required this.context});
  static StateSetter? modalState;
  static late BuildContext? modalCtx;
  Future<StateSetter?> get getModalState async {
    return modalState;
  }
  Future<BuildContext?> get getModalCtx async => modalCtx;

  void showModal(BuildContext context, List<Widget> children) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext ctx, StateSetter setModalState) {
            modalState = setModalState;
            modalCtx = ctx;
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: children,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
*/
