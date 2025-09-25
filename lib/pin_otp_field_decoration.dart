part of 'pin_otp_field.dart';

/// Abstract interface for OTP field decoration
/// Defines a method to obtain the input decoration for each OTP input box.
/// This enables multiple different styles (boxed, circular, underline, custom).
abstract class OtpFieldDecorator {
  /// Returns the [InputDecoration] for the OTP field at the given [index].
  /// Provides [isFilled] to indicate if this field currently has input.
  InputDecoration getDecoration(int index, bool isFilled);
}


/// BoxOtpDecorator renders OTP fields with boxed borders and customizable corner radius.
/// Uses an [OutlineInputBorder] with rounded corners and optional fill color.
/// The hint character displays when the field is empty.
class BoxOtpDecorator implements OtpFieldDecorator {
  final Color borderColor;
  final double borderRadius;
  final Color fillColor;
  final String hintChar;
  final TextStyle? hintStyle;

  BoxOtpDecorator({
    this.borderColor = Colors.grey,
    this.borderRadius = 8.0,
    this.fillColor = Colors.transparent,
    this.hintChar = '',
    this.hintStyle,
  });

  @override
  InputDecoration getDecoration(int index, bool isFilled) {
    return InputDecoration(
      // Rounded rectangular box border
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: borderColor),
      ),
      filled: isFilled, // fill background only when field is filled
      fillColor: isFilled ? fillColor : Colors.transparent,
      hintText: hintChar, // show hint character when empty
      hintStyle: hintStyle ?? TextStyle(color: Colors.grey),
      counterText: '', // hides counter text for maxLength fields
      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
    );
  }
}



/// CircleOtpDecorator renders OTP fields with circular borders.
/// Uses a high border radius to create circle-effect on the input fields.
/// Ideal for rounded OTP input fields with customizable hint and fill colors.
class CircleOtpDecorator implements OtpFieldDecorator {
  final Color borderColor;
  final double borderRadius;
  final Color fillColor;
  final String hintChar;
  final TextStyle? hintStyle;

  CircleOtpDecorator({
    this.borderColor = Colors.grey,
    this.borderRadius = 30.0, // large radius for circle shape
    this.fillColor = Colors.transparent,
    this.hintChar = '',
    this.hintStyle,
  });

  @override
  InputDecoration getDecoration(int index, bool isFilled) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: borderColor),
      ),
      filled: isFilled,
      fillColor: isFilled ? fillColor : Colors.transparent,
      hintText: hintChar,
      hintStyle: hintStyle ?? TextStyle(color: Colors.grey),
      counterText: '',
      contentPadding: EdgeInsets.all(12),
    );
  }
}


/// UnderlineOtpDecorator renders OTP fields with underline style borders only.
/// Uses [UnderlineInputBorder] to create a simple line under the input.
/// Suitable for minimalist OTP input UI styles.
class UnderlineOtpDecorator implements OtpFieldDecorator {
  final Color borderColor;
  final Color fillColor;
  final String hintChar;
  final TextStyle? hintStyle;

  UnderlineOtpDecorator({
    this.borderColor = Colors.grey,
    this.fillColor = Colors.transparent,
    this.hintChar = '',
    this.hintStyle,
  });

  @override
  InputDecoration getDecoration(int index, bool isFilled) {
    return InputDecoration(
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: borderColor),
      ),
      filled: isFilled,
      fillColor: isFilled ? fillColor : Colors.transparent,
      hintText: hintChar,
      hintStyle: hintStyle ?? TextStyle(color: Colors.grey),
      counterText: '',
      contentPadding: EdgeInsets.symmetric(vertical: 8),
    );
  }
}


/// CustomOtpDecorator allows users to provide their own custom [InputDecoration].
/// Useful for full customization beyond boxed, circular, or underline styles.
/// This class acts as a wrapper forwarding the custom decoration provided.
class CustomOtpDecorator implements OtpFieldDecorator {
  final InputDecoration decoration;

  /// Creates a custom decorator by passing a fully customized [InputDecoration].
  /// [decoration] - user-defined decoration for the OTP field.
  CustomOtpDecorator(this.decoration);

  @override
  InputDecoration getDecoration(int index, bool isFilled) => decoration;
}


