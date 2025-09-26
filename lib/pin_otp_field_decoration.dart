
part of 'pin_otp_field.dart';

/// Abstract interface for OTP field decoration
/// Defines a method to obtain the input decoration for each OTP input box.
/// This enables multiple different styles (boxed, circular, underline, custom).
abstract class OtpFieldDecorator {
  /// Returns the [InputDecoration] for the OTP field at the given [index].
  /// Provides [isFilled] to indicate if this field currently has input.
  InputDecoration getDecoration({bool hasError});
}


/// BoxOtpDecorator renders OTP fields with boxed borders and customizable corner radius.
/// Uses an [OutlineInputBorder] with rounded corners and optional fill color.
/// The hint character displays when the field is empty.
class BoxOtpDecorator implements OtpFieldDecorator {
  final Color borderColor;
  final Color focusedBorderColor;
  final Color errorBorderColor;

  final double borderRadius;
  final double borderWidth;
  final Color fillColor;
  final String hintChar;
  final TextStyle? hintStyle;

  BoxOtpDecorator({
    this.borderColor = Colors.grey,
    this.focusedBorderColor = Colors.black,
    this.errorBorderColor = Colors.red,
    this.borderRadius = 8.0,
    this.borderWidth = 1.0,
    this.fillColor = Colors.transparent,
    this.hintChar = '',
    this.hintStyle,
  });

  @override
  InputDecoration getDecoration({bool hasError= false}) {
    final Color effectiveBorderColor = hasError  ? errorBorderColor : borderColor;
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius,),
        borderSide: BorderSide(color: effectiveBorderColor, width: borderWidth),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: effectiveBorderColor,width: borderWidth),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: hasError ? effectiveBorderColor : focusedBorderColor,width: borderWidth),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: errorBorderColor, width: borderWidth),
      ),
      filled: true,
      // fillColor: isFilled ? fillColor : Colors.transparent,
      fillColor:  fillColor,
      hintText: hintChar,
      hintStyle: hintStyle ?? TextStyle(color: Colors.grey),
      counterText: '',
      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
    );
  }
}
