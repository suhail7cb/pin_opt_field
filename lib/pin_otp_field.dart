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
  final OtpFieldDecorator decorator;

  /// Whether the input text should be obscured (like password fields).
  final bool obscure;

  /// Character to show as the hint when the field is empty.
  final String hintChar;

  /// Callback invoked when all PIN/OTP fields are filled.
  final ValueChanged<String> onCompleted;

  /// Optional validator for the entered code. Returns error message if invalid.
  final String? Function(String value)? validator;

  /// Style for the error message text.
  final TextStyle errorStyle;

  const PinOtpField({
    Key? key,
    required this.length,
    required this.decorator,
    this.obscure = false,
    this.hintChar = '',
    this.validator,
    this.errorStyle = const TextStyle(color: Colors.red, fontSize: 14),
    required this.onCompleted,
  }) : super(key: key);

  @override
  _PinOtpFieldState createState() => _PinOtpFieldState();
}

class _PinOtpFieldState extends State<PinOtpField> with TickerProviderStateMixin {
  late List<TextEditingController> _controllers; // Controllers for each field
  late List<FocusNode> _focusNodes; // Focus nodes for each field
  late List<AnimationController> _scaleControllers; // Animation controllers for scale
  late List<Animation<double>> _scaleAnimations; // Scale animations for each field
  late AnimationController _shakeController; // Controller for shake animation
  late Animation<double> _shakeAnimation; // Shake animation

  bool _hasError = false; // Tracks if there is a validation error
  String? errorText; // Stores the error message

  @override
  void initState() {
    super.initState();
    // Initialize controllers and focus nodes for each field
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());

    // Initialize scale animations for each field
    _scaleControllers = List.generate(
      widget.length,
          (_) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 120),
        lowerBound: 0.7,
        upperBound: 1.0,
      ),
    );
    _scaleAnimations = _scaleControllers
        .map((c) => Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: c, curve: Curves.easeOut),
    ))
        .toList();

    // Initialize shake animation for the whole row
    _shakeController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    _shakeAnimation = Tween<double>(begin: 0, end: 16)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(_shakeController);
  }

  @override
  void dispose() {
    // Dispose all controllers and focus nodes
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }
    for (final anim in _scaleControllers) {
      anim.dispose();
    }
    _shakeController.dispose();
    super.dispose();
  }

  /// Triggers the shake animation for error feedback
  void _triggerShake() {
    _shakeController.forward(from: 0);
  }

  /// Builds a single OTP field with animation and validation
  Widget _buildField(int index) {
    return AnimatedBuilder(
      animation: _scaleControllers[index],
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimations[index].value,
          child: child,
        );
      },
      child: TextField(
        focusNode: _focusNodes[index],
        controller: _controllers[index],
        obscureText: widget.obscure,
        decoration: widget.decorator.getDecoration(
          hasError: _hasError,
        ),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        onChanged: (value) {
          // Handle paste (if user pastes the whole code)
          if (value.length == widget.length) {
            _handlePaste(value);
          } else {
            // Only keep the last character if more than one is entered
            if (value.length > 1) {
              _controllers[index].text = value.substring(value.length - 1);
            }
            if (value.isNotEmpty) {
              _controllers[index].text = value.substring(value.length - 1);
              _scaleControllers[index].forward(from: 0); // Animate scale
              // Move focus to next field if not last
              if (index < widget.length - 1) {
                _focusNodes[index + 1].requestFocus();
              }
            } else {
              // Move focus to previous field if deleting
              if (index > 0) {
                _focusNodes[index - 1].requestFocus();
                _controllers[index - 1].selection = TextSelection.collapsed(
                    offset: _controllers[index - 1].text.length);
              }
            }
            // Set cursor at the end
            _controllers[index].selection = TextSelection.collapsed(
                offset: _controllers[index].text.length);

            // Validate when all fields are filled
            if (_controllers.every((c) => c.text.isNotEmpty)) {
              _validateInput();
            }
          }
        },
      ),
    );
  }

  /// Validates the input using the provided validator and updates error state
  void _validateInput() {
    if (widget.validator != null) {
      String currentValue = _controllers.map((c) => c.text).join();
      errorText = widget.validator!(currentValue);
      if (errorText != null) {
        // If validation fails, show error animation and set error state
        showErrorAnimation();
        setState(() {
          _hasError = true;
        });
        return;
      } else {
        // If valid, clear error and call onCompleted
        setState(() {
          _hasError = false;
        });
        _focusNodes.last.unfocus();
        widget.onCompleted(_controllers.map((c) => c.text).join());
      }
    } else {
      // If no validator, just call onCompleted
      widget.onCompleted(_controllers.map((c) => c.text).join());
    }
  }

  /// Shows error animation (shake) when validation fails
  void showErrorAnimation() {
    _triggerShake();
    // Optionally, clear fields or set error decoration
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shakeController,
      builder: (context, child) {
        // Apply shake animation to the whole row
        return Transform.translate(
          offset: Offset(_shakeAnimation.value * (_shakeController.status == AnimationStatus.forward ? 1 : 0), 0),
          child: child,
        );
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate field width based on available space
          double totalWidth = constraints.maxWidth * 0.9;
          double fieldWidth = (totalWidth - (widget.length - 1) * 16) / widget.length;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row of OTP fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(widget.length, (index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: SizedBox(
                      width: fieldWidth,
                      child: _buildField(index),
                    ),
                  );
                }),
              ),
              // Show error message if validation fails
              if (_hasError && errorText != null) ...[
                SizedBox(height: 8),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    errorText!,
                    style: widget.errorStyle,
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  /// Handles paste event: distributes pasted text across fields
  void _handlePaste(String pastedText) {
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

    _validateInput();
  }
}
