import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';


class OtpInput extends StatefulWidget {
  const OtpInput({super.key, this.length = 6, required this.onChanged});

  final int length;
  final ValueChanged<String> onChanged;

  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _nodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _nodes = List.generate(widget.length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final n in _nodes) {
      n.dispose();
    }
    super.dispose();
  }

  String get _value => _controllers.map((c) => c.text).join();

  void _onChanged(int i, String v) {
    if (v.isNotEmpty) {
      if (i < widget.length - 1) {
        _nodes[i + 1].requestFocus();
      } else {
        _nodes[i].unfocus();
      }
    }
    widget.onChanged(_value);
  }

  KeyEventResult _onKey(int i, KeyEvent event) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace &&
        _controllers[i].text.isEmpty &&
        i > 0) {
      _controllers[i - 1].clear();
      _nodes[i - 1].requestFocus();
      widget.onChanged(_value);
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.border),
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(widget.length, (i) {
        return SizedBox(
          width: 48,
          height: 50,
          child: Focus(
            onKeyEvent: (_, e) => _onKey(i, e),
            child: TextField(
              controller: _controllers[i],
              focusNode: _nodes[i],
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              style: AppTextStyles.inter(20, weight: FontWeight.w700),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(1),
              ],
              onChanged: (v) => _onChanged(i, v),
              decoration: InputDecoration(
                counterText: '',
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.zero,
                border: border,
                enabledBorder: border,
                focusedBorder: border.copyWith(
                  borderSide:  BorderSide(color: AppColors.primary, width: 1.4),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
