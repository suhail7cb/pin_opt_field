
import 'package:flutter/material.dart';

part 'pin_otp_field_decoration.dart';

/// A customizable PIN/OTP input widget that allows input of fixed-length numeric codes.
///
/// This widget creates individual text fields for each character of the PIN/OTP.
/// It supports customization of the number of fields, obscuring text (for PIN privacy),
/// customizable decoration for each field, and a callback when input is complete.
///
/// The input fields automatically move focus to the next field upon entry and notify
/// when the entire PIN/OTP is entered.
///
/// Uses the [OtpFieldDecorator] abstraction to style each input field flexibly for
/// boxed, circular, underline, or custom appearances.
class PinOtpField extends StatefulWidget {
  /// Number of characters (fields) in the PIN/OTP code.
  final int length;

  /// A decorator instance that defines the styling of each individual field.
  /// This allows different styles like boxed, circle, underline, or fully custom.
  final OtpFieldDecorator decorator;

  /// Whether the input text should be obscured (like password fields).
  final bool obscure;

  /// Character to show as the hint when the field is empty.
  final String hintChar;

  /// Callback invoked when all PIN/OTP fields are filled.
  /// Returns the combined text as a single string.
  final ValueChanged<String> onCompleted;

  /// Creates a [PinOtpField] widget.
  ///
  /// [length] must be greater than zero.
  /// [decorator] must not be null and defines the appearance.
  /// [obscure] defaults to false.
  /// [hintChar] defaults to '*'.
  /// [onCompleted] is required and called when input is fully populated.
  const PinOtpField({
    Key? key,
    required this.length,
    required this.decorator,
    this.obscure = false,
    this.hintChar = '*',
    required this.onCompleted,
  }) : super(key: key);

  @override
  _PinOtpFieldState createState() => _PinOtpFieldState();
}

/// State class that manages text controllers and rendering of the PIN fields.
class _PinOtpFieldState extends State<PinOtpField> {
  /// List of controllers, one for each OTP input field, to manage input text.
  ///
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;


  @override
  void initState() {
    super.initState();
    // Initialize controllers for each text field in the OTP
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());

  }

  @override
  void dispose() {
    // Clean up and dispose each text controller when widget is removed from tree
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  /// Builds an individual OTP input field widget at [index].
  /// Configures the controller, obscuring, decoration, and keyboard interactions.
  Widget _buildField(int index) {
    return TextField(
      focusNode: _focusNodes[index],
      controller: _controllers[index],
      obscureText: widget.obscure, // show dots for sensitive inputs if true
      decoration: widget.decorator.getDecoration(
        index,
        _controllers[index].text.isNotEmpty,
      ), // Get decoration style per field from the decorator
      textAlign: TextAlign.center, // Center the input text
      keyboardType: TextInputType.number, // Numeric keyboard for OTP digits
      // maxLength: 2, // Only allow one character per field
      maxLength: widget.length, // Only allow one character per field

        onChanged: (value) {

        //To check if value is pasted or typed
          if (value.length == widget.length) {
            _handlePaste(value);
          }

          else {
            if (value.length > 1) {
              // This can happen if user pastes or quickly types: keep only last char
              _controllers[index].text = value.substring(value.length - 1);
            }

            if (value.isNotEmpty) {
              // Replace current value and move to next field if any
              _controllers[index].text = value.substring(value.length - 1);
              if (index < widget.length - 1) {
                _focusNodes[index + 1].requestFocus();
              }
            } else {
              // If value is empty, move focus backward if possible
              if (index > 0) {
                _focusNodes[index - 1].requestFocus();
                _controllers[index - 1].selection = TextSelection.collapsed(
                    offset: _controllers[index - 1].text.length);
              }
            }

            // Set cursor position to end in current field
            _controllers[index].selection = TextSelection.collapsed(
                offset: _controllers[index].text.length);

            // Check if all fields are filled
            if (_controllers.every((c) => c.text.isNotEmpty)) {
              widget.onCompleted(_controllers.map((c) => c.text).join());
            }

            setState(() {});
          }
        }

    );
  }

  void _handlePaste(String pastedText) {
    // Distribute pasted text across fields

    for (int i = 0; i < widget.length; i++) {
      if (i < pastedText.length) {
        _controllers[i].text = pastedText[i];
      }
    }
    // Move focus to the last filled field or the last field
    int lastFilledIndex = pastedText.length - 1;
    if (lastFilledIndex >= widget.length) {
      lastFilledIndex = widget.length - 1;
    }
    _focusNodes[lastFilledIndex].requestFocus();

    // If all fields are filled, invoke completion callback
    if (_controllers.every((c) => c.text.isNotEmpty)) {
      widget.onCompleted(_controllers.map((c) => c.text).join());
    }

    setState(() {});

  }


  @override
  Widget build(BuildContext context) {
    // Use LayoutBuilder to adapt the size of fields according to available width
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate total width available (95% of max width for margin)
        double totalWidth = constraints.maxWidth * 0.95;
        // Calculate width for each field, accounting for 8px gap between fields
        double fieldWidth = (totalWidth - (widget.length - 1) * 8) / widget.length;

        // Layout input fields horizontally with spacing and fixed width
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.length, (index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 4), // Half gap on each side = 8px total
              child: SizedBox(
                width: fieldWidth, // Fixed width per input field for uniform visuals
                child: _buildField(index), // Build individual text field widget
              ),
            );
          }),
        );
      },
    );
  }
}


