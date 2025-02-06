// Track the active list type
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/l10n/l10n.dart';

enum ListType { none, bullet, numbered, numberedRtl }

class TextEditorWidget extends StatefulWidget {
  const TextEditorWidget(
      {Key? key, required this.controller, required this.title})
      : super(key: key);
  final TextEditingController controller;
  final String title;
  @override
  _TextEditorWidgetState createState() => _TextEditorWidgetState();
}

class _TextEditorWidgetState extends State<TextEditorWidget> {
  // final TextEditingController _controller = TextEditingController();
  bool isBold = false;
  bool isItalic = false;
  bool isUnderline = false;

  ListType currentListType = ListType.none;

  // Convert text to list format
  void _formatAsList(ListType type) {
    final String currentText = widget.controller.text;
    final List<String> lines = currentText.split('\n');
    String formattedText = '';

    if (currentListType == type) {
      // If same list type is selected again, remove list formatting
      formattedText = lines.map((line) {
        if (line.startsWith('• ')) return line.substring(2);
        if (RegExp(r'^\d+\. ').hasMatch(line)) {
          return line.substring(line.indexOf(' ') + 1);
        }
        return line;
      }).join('\n');
      currentListType = ListType.none;
    } else {
      // Apply new list formatting
      for (int i = 0; i < lines.length; i++) {
        String line = lines[i].trim();
        // Remove any existing list formatting
        if (line.startsWith('• ')) line = line.substring(2);
        if (RegExp(r'^\d+\. ').hasMatch(line)) {
          line = line.substring(line.indexOf(' ') + 1);
        }

        // Apply new formatting
        switch (type) {
          case ListType.bullet:
            formattedText += '• $line\n';
            break;
          case ListType.numbered:
            formattedText += '${i + 1}. $line\n';
            break;
          case ListType.numberedRtl:
            formattedText += '${i + 1}. $line\n';
            break;
          default:
            formattedText += '$line\n';
        }
      }
      currentListType = type;
    }

    widget.controller.value = TextEditingValue(
      text: formattedText.trimRight(),
      selection:
          TextSelection.collapsed(offset: formattedText.trimRight().length),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n=AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: KColors.darkerGrey,
              width: 1.2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              // Toolbar
              Container(
                padding: EdgeInsets.symmetric(horizontal: KSizes.md),
                child: Row(
                  children: [
                    _buildToolbarButton('B', isBold, FontWeight.bold),
                    _buildToolbarButton('I', isItalic, FontWeight.normal,
                        isItalic: true),
                    _buildToolbarButton('U', isUnderline, FontWeight.normal,
                        isUnderline: true),
                    _buildDivider(),
                    _buildListButton(
                        Icons.format_list_bulleted, ListType.bullet),
                    _buildListButton(
                        Icons.format_list_numbered, ListType.numbered),
                    _buildListButton(
                        Icons.format_list_numbered_rtl, ListType.numberedRtl),
                    _buildDivider(),
                    _buildIconButton(Icons.link),
                  ],
                ),
              ),
              Divider(
                color: KColors.grey,
                height: 10,
                endIndent: KSizes.md,
                indent: KSizes.md,
              ),
              // Text Area
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: TextFormField(
                  controller: widget.controller,
                  maxLines: 8,
                  // validator: (value) => KValidator.validateEmptyText(
                  //     "Roles and Responsibilities", value),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                    hintText:
                        '${l10n.hint_text_professional_goal}',
                    hintStyle: TextStyle(
                      color: KColors.darkGrey,
                      fontSize: 13.sp,
                    ),
                  ),
                  style: TextStyle(
                    fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                    fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
                    decoration: isUnderline
                        ? TextDecoration.underline
                        : TextDecoration.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildListButton(IconData icon, ListType type) {
    final bool isActive = currentListType == type;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _formatAsList(type),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Icon(
            icon,
            size: 18,
            color: isActive ? KColors.primary : KColors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildToolbarButton(String text, bool isActive, FontWeight weight,
      {bool isItalic = false, bool isUnderline = false}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          setState(() {
            if (text == 'B') isBold = !isBold;
            if (text == 'I') this.isItalic = !this.isItalic;
            if (text == 'U') this.isUnderline = !this.isUnderline;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Text(
            text,
            style: TextStyle(
              fontWeight: weight,
              fontSize: KSizes.fontSizeLg,
              fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
              decoration:
                  isUnderline ? TextDecoration.underline : TextDecoration.none,
              color: isActive ? KColors.primary : KColors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // Implement list and link functionality
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Icon(
            icon,
            size: 18,
            color: KColors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 24,
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      color: Colors.grey[300],
    );
  }
}
