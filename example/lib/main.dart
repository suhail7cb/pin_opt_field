import 'package:flutter/material.dart';
import 'package:pin_otp_field/pin_otp_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'OTP PIN Field Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('PIN:', style: TextStyle(fontSize: 20),),
            SizedBox(height: 5,),
            PinOtpField(
              length: 4,
              decorator: CustomBoxOtpDecorator(),
              // autoFocus: true,
              onCompleted: (code) {
                // handle completion
                print('PIN entered: $code');
              },
              validator: (value) {
                if (value != "1234")
                  return "Invalid PIN";
                return null;
              },
            ),

            SizedBox(height: 30,),
            Text('OTP:', style: TextStyle(fontSize: 20),),
            SizedBox(height: 5,),
            PinOtpField(
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
          ],
        ),
      ),
    );
  }
}


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

