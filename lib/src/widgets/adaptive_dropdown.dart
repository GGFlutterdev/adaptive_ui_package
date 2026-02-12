import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

/// Item per il dropdown
class AdaptiveDropdownItem<T> {
  final T value;
  final String label;

  const AdaptiveDropdownItem({
    required this.value,
    required this.label,
  });
}

/// Dropdown adattivo
/// - Android: [DropdownButton]
/// - iOS: [CupertinoPicker] in un [CupertinoModalPopup]
class AdaptiveDropdown<T> extends StatelessWidget {
  final T? value;
  final List<AdaptiveDropdownItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final String? hint;

  /// Testo pulsante "Annulla" iOS
  final String cancelText;

  /// Testo pulsante "Conferma" iOS
  final String confirmText;

  /// Stile testo per pulsanti e label iOS
  final TextStyle? textStyle;

  const AdaptiveDropdown({
    Key? key,
    this.value,
    required this.items,
    this.onChanged,
    this.hint,
    this.cancelText = 'Annulla',
    this.confirmText = 'Conferma',
    this.textStyle,
  }) : super(key: key);

  static bool get isIOS => Platform.isIOS;

  @override
  Widget build(BuildContext context) {
    final TextStyle? defaultStyle =
        textStyle ?? Theme.of(context).textTheme.bodyMedium;
    if (isIOS) {
      return GestureDetector(
        onTap: () => _showIOSPicker(context, defaultStyle),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: CupertinoColors.tertiarySystemBackground,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value != null
                    ? items.firstWhere((item) => item.value == value).label
                    : hint ?? 'Seleziona',
                style: defaultStyle?.copyWith(
                  color: value != null
                      ? CupertinoColors.label
                      : CupertinoColors.placeholderText,
                ),
              ),
              const Icon(
                CupertinoIcons.chevron_down,
                size: 20,
                color: CupertinoColors.systemGrey,
              ),
            ],
          ),
        ),
      );
    } else {
      return DropdownButton<T>(
        value: value,
        hint: hint != null ? Text(hint!, style: defaultStyle) : null,
        isExpanded: true,
        items: items
            .map((item) => DropdownMenuItem<T>(
                  value: item.value,
                  child: Text(item.label, style: defaultStyle),
                ))
            .toList(),
        onChanged: onChanged,
      );
    }
  }

  void _showIOSPicker(BuildContext context, TextStyle? defaultStyle) {
    int selectedIndex =
        value != null ? items.indexWhere((item) => item.value == value) : 0;

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: Column(
            children: [
              Container(
                height: 44,
                color: CupertinoColors.systemBackground.resolveFrom(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      child: Text(cancelText, style: defaultStyle),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    CupertinoButton(
                      child: Text(confirmText, style: defaultStyle),
                      onPressed: () {
                        if (onChanged != null) {
                          onChanged!(items[selectedIndex].value);
                        }
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CupertinoPicker(
                  scrollController: FixedExtentScrollController(
                    initialItem: selectedIndex,
                  ),
                  itemExtent: 32.0,
                  onSelectedItemChanged: (int index) {
                    selectedIndex = index;
                  },
                  children: items
                      .map((item) => Center(
                              child: Text(
                            item.label,
                            style: defaultStyle,
                          )))
                      .toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
