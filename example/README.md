# Pin/OTP Field Demo

This Flutter application demonstrates the usage of the `pin_otp_field` package to create customized PIN and OTP input fields.

## Features

*   **Customizable PIN Field:**
    *   Uses `CustomBoxOtpDecorator` for a unique visual appearance.
    *   Input length of 4 digits.
    *   Callback function `onCompleted` is triggered when the PIN is fully entered.
    *   Includes a `validator` to check if the entered PIN is "1234".
*   **Customizable OTP Field:**
    *   Uses `BoxOtpDecorator` with specific styling:
        *   Hint character: `*`
        *   Border radius: 10
        *   Border color: Light blue (`Colors.blue.shade200`)
        *   Focused border color: Blue (`Colors.blue`)
        *   Fill color: Light blue (`Colors.blue.shade50`)
    *   Input length of 4 digits.
    *   `obscure` is set to `false` (characters are visible).
    *   Callback function `onCompleted` is triggered when the OTP is fully entered.
    *   Includes a `validator` to check if the entered OTP is "1234".
    *   Custom `errorStyle` for displaying validation errors in red.

## How it Works

The application is structured with a `MyApp` widget as the root, which sets up the `MaterialApp`. The main screen is `MyHomePage`, a `StatefulWidget` that contains the PIN and OTP fields.

### `MyHomePage` State (`_MyHomePageState`)

*   **`_pinOtpFieldKey`**: A `GlobalKey` (though not actively used in this specific example, it's good practice for accessing widget states if needed).
*   **`build()` method**:
    *   Renders a `Scaffold` with an `AppBar`.
    *   The `body` is a `Padding` widget containing a `Column` to arrange the PIN and OTP sections vertically.
    *   Each section has a `Text` label ("PIN:" or "OTP:") followed by a `SizedBox` for spacing, and then the respective `PinOtpField`.

### `PinOtpField` Configuration

Both `PinOtpField` widgets share some common properties:

*   **`length`**: Defines the number of input boxes/characters.
*   **`onCompleted`**: A callback function that receives the entered code as a string once all digits are filled. In this demo, it prints the entered code to the console.
*   **`validator`**: A function that takes the entered value as input and returns an error message string if the validation fails, or `null` if it passes.

#### PIN Field Specifics:

*   **`decorator: CustomBoxOtpDecorator()`**: This applies a custom decoration defined in the `CustomBoxOtpDecorator` class.

#### OTP Field Specifics:

*   **`decorator: BoxOtpDecorator(...)`**: This uses the built-in `BoxOtpDecorator` and configures its appearance (hint character, border radius, colors, etc.).
*   **`obscure: false`**: Makes the entered characters visible.
*   **`errorStyle: TextStyle(fontSize: 15, color: Colors.red)`**: Defines the style for the error message displayed below the field when validation fails.

### `CustomBoxOtpDecorator`

This class implements the `OtpFieldDecorator` interface to provide a completely custom look and feel for the input fields.

*   **`getDecoration({bool hasError = false})`**: This method returns an `InputDecoration` object.
    *   It defines different border styles (`border`, `enabledBorder`, `focusedBorder`, `errorBorder`) with rounded corners and custom colors (green by default, red if `hasError` is true, blue when focused).
    *   `filled: true` and `fillColor: Colors.yellow.shade50` give the field a light yellow background.
    *   `hintText: '#'` sets the placeholder character.
    *   `counterText: ''` hides the default character counter.
    *   `contentPadding` adjusts the internal padding of each input box.

## How to Run

1.  **Ensure you have Flutter installed.** If not, follow the instructions on the [official Flutter website](https://flutter.dev/docs/get-started/install).
2.  **Add the `pin_otp_field` dependency** to your `pubspec.yaml` file:
3.  **Run `flutter pub get`** in your terminal.
4.  **Copy the provided Dart code** into your `main.dart` file (or a relevant file in your project).
5.  **Run the application** using `flutter run`.

## Example Usage

When you run the app, you will see two input fields:

*   **PIN Field:**
    *   Try entering "1234". The console will print "PIN entered: 1234".
    *   Try entering any other 4-digit number. An "Invalid PIN" message will appear below the field.
*   **OTP Field:**
    *   Try entering "1234". The console will print "OTP entered: 1234".
    *   Try entering any other 4-digit number. An "Invalid OTP" message will appear below the field in red.

This example showcases the flexibility of the `pin_otp_field` package in creating various styles of PIN/OTP input fields with validation.
