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
  int _counter = 0;


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
            Text('Box PIN:', style: TextStyle(fontSize: 20),),
            SizedBox(height: 5,),
            PinOtpField(
              length: 5, // OTP length
              decorator: BoxOtpDecorator(hintChar: '*'), // Custom decorator for boxed style
              obscure: false, // Show or hide input
              hintChar: '*', // Custom hint character
              onCompleted: (String otp) {
                // Action when OTP entry is complete
                print('PIN entered: $otp');
                // Add further OTP validation logic here if needed
              },
            ),
            SizedBox(height: 30,),
            Text('Rounded OTP:', style: TextStyle(fontSize: 20),),
            SizedBox(height: 5,),
            PinOtpField(
              length: 4, // OTP length
              decorator: CircleOtpDecorator(hintChar: '-'), // Custom decorator for boxed style
              obscure: false, // Show or hide input
              hintChar: '', // Custom hint character
              onCompleted: (String otp) {
                // Action when OTP entry is complete
                print('OTP entered: $otp');
                // Add further OTP validation logic here if needed
              },
            ),
            SizedBox(height: 30,),
            Text('Underline OTP:', style: TextStyle(fontSize: 20),),
            SizedBox(height: 5,),
            PinOtpField(
              length: 4, // OTP length
              decorator: UnderlineOtpDecorator(hintChar: '*'), // Custom decorator for boxed style
              obscure: false, // Show or hide input
              hintChar: '', // Custom hint character
              onCompleted: (String otp) {
                // Action when OTP entry is complete
                print('OTP entered: $otp');
                // Add further OTP validation logic here if needed
              },
            )
          ],
        ),
      ),
    );
  }
}
