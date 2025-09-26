
# pin_otp_field

A customizable Flutter widget for entering PIN or OTP codes, supporting various styles and input behaviors.

## Features

- Customizable number of fields for PIN/OTP input
- Supports obscured input (for PIN privacy)
- Flexible field decoration: box, circle, underline, or custom
- Animated feedback (scale and shake on error)
- Custom error message and error styling
- Validator support for input
- Handles paste and auto-focus
- Callback when input is complete

## What's New in 0.0.3

- **Custom error message support:** Show custom error text below the fields on validation failure.
- **Error border color:** Fields show error border color when validation fails.
- **Multiple border styles:** Box, circle, and underline border options for fields.
- **Improved documentation and code comments.**

## Getting Started

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  pin_otp_field: ^0.0.3
```

Then run:

```sh
flutter pub get
```


## Usage

Import the package:

```dart
import 'package:pin_otp_field/pin_otp_field.dart';
```

## Use the widget in your app:

```dart
PinOtpField(
  length: 4,
  obscure: true,
  decorator: BoxOtpDecorator(
    borderColor: Colors.blue,
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


## Example

```dart
class OtpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PinOtpField(
          length: 4,
          decorator: BoxOtpDecorator(
              hintChar: '*',
              borderRadius:10,
              borderColor: Colors.blue.shade200,
              focusedBorderColor: Colors.blue,
              fillColor: Colors.blue.shade50),
          obscure: false,
          // autoFocus: true,
          onCompleted: (code) {
            // handle completion
            print('OTP entered: $code');
          },
          validator: (value) {
            if (value != "1234")
              return "Invalid OTP";
            return null;
          },
          errorStyle: TextStyle(fontSize: 15, color: Colors.red),
        ),
      ),
    );
  }
}


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
