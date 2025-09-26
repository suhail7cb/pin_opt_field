

```markdown
# pin_otp_field

A customizable Flutter widget for entering PIN or OTP codes, supporting various styles and input behaviors.

[![pub package](https://img.shields.io/pub/v/pin_otp_field.svg)](https://pub.dev/packages/pin_otp_field)

## Features

- Customizable number of fields for PIN/OTP input
- Supports obscured input (for PIN privacy)
- Flexible field decoration: box, circle, underline, or custom
- Animated feedback (scale and shake on error)
- Custom error message and error styling
- Validator support for input
- Handles paste and auto-focus
- Callback when input is complete

## What's New in 0.0.2

- **Custom error message support:** Show custom error text below the fields on validation failure.
- **Error border color:** Fields show error border color when validation fails.
- **Multiple border styles:** Box, circle, and underline border options for fields.
- **Improved documentation and code comments.**

## Getting Started

Add to your `pubspec.yaml`:

```yaml
dependencies:
  pin_otp_field: ^0.0.2
```

Import in your Dart code:

```dart
import 'package:pin_otp_field/pin_otp_field.dart';
```

## Usage

```dart
PinOtpField(
  length: 4,
  obscure: true,
  decorator: BoxOtpDecorator(
    borderColor: Colors.blue,
    borderType: OtpBorderType.box, // box, circle, or underline
    borderRadius: 8.0,
    fillColor: Colors.grey.shade200,
    hintChar: '*',
  ),
  validator: (value) {
    if (value != '123456') return 'Invalid code';
    return null;
  },
  onCompleted: (code) {
    print('Completed: $code');
  },
)
```

## Custom Field Decoration

You can create your own field decoration by implementing the `OtpFieldDecorator` interface.  
For example:

```dart
class CustomBoxOtpDecorator implements OtpFieldDecorator {
  @override
  InputDecoration getDecoration({bool hasError = false}) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: hasError ? Colors.red : Colors.green, width: 2.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: hasError ? Colors.red : Colors.green, width: 2.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: hasError ? Colors.red : Colors.blue, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: Colors.red, width: 2.0),
      ),
      filled: true,
      fillColor: Colors.yellow.shade50,
      hintText: '#',
      hintStyle: TextStyle(color: Colors.grey),
      counterText: '',
      contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
    );
  }
}
```

Then use it in your widget:

```dart
PinOtpField(
  length: 4,
  decorator: CustomBoxOtpDecorator(),
  onCompleted: (code) { /* ... */ },
)
```
This allows you to fully control the appearance of each field.


## Customization

- **Field count:** Set `length`.
- **Obscure text:** Set `obscure: true`.
- **Decoration:** Use `BoxOtpDecorator` and set `borderType` to `box`, `circle`, or `underline`.
- **Error message:** Provide a `validator` function that returns a string on error.
- **Error style:** Customize with `errorStyle`.

## Example

See the [`example/`](example/) directory for a complete usage example.


## License

See [LICENSE](LICENSE).

```