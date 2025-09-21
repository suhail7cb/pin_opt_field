
# pin_otp_field

A customizable Flutter widget for entering PIN or OTP codes, supporting various styles and input behaviors.

## Features

- Customizable length and style
- Supports numeric and alphanumeric input
- Handles paste and autofill
- Error and success states

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  pin_otp_field: ^0.0.1
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

Use the widget in your app:

```dart
PinOtpField(
  length: 6,
  onChanged: (value) {
    print('Current value: $value');
  },
  onCompleted: (value) {
    print('Completed with: $value');
  },
  // Customize appearance and behavior as needed
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
          onCompleted: (code) {
            // Handle completed code
          },
        ),
      ),
    );
  }
}
```

## License

See [LICENSE](LICENSE).
