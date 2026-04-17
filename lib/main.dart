import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

const primaryColor = Color(0xFF4F8CFF);
const secondaryColor = Color(0xFF00C9FF);
const backgroundColor = Color(0xFFF5F7FB);
const successColor = Colors.green;
const warningColor = Color(0xFFFFA726);

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeDemo(),
  );
}

class HomeDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pinput 10 API Demo", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'serif', fontSize: 22, color: Colors.white)),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      backgroundColor: backgroundColor,
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          _demoCard(
            context,
            icon: Icons.lock,
            title: "1. Basic PIN",
            subtitle: "length, controller, autofocus",
            page: BasicDemo(),
          ),
          _demoCard(
            context,
            icon: Icons.style,
            title: "2. Styling",
            subtitle: "defaultPinTheme, focusedPinTheme",
            page: StylingDemo(),
          ),
          _demoCard(
            context,
            icon: Icons.check_circle,
            title: "3. Validation",
            subtitle: "validator, errorPinTheme, forceErrorState",
            page: ValidationDemo(),
          ),
          _demoCard(
            context,
            icon: Icons.visibility,
            title: "4. Show/Hide",
            subtitle: "obscureText",
            page: ShowHideDemo(),
          ),
          _demoCard(
            context,
            icon: Icons.flash_on,
            title: "5. Events",
            subtitle: "onChanged, onCompleted",
            page: EventsDemo(),
          ),
        ],
      ),
    );
  }

  Widget _demoCard(BuildContext context, {required IconData icon, required String title, required String subtitle, required Widget page}) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
      child: Card(
        margin: EdgeInsets.only(bottom: 15),
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [primaryColor.withOpacity(0.1), Colors.white],
            ),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: primaryColor.withOpacity(0.2),
                child: Icon(icon, color: primaryColor, size: 30),
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'serif', color: Colors.black)),
                    SizedBox(height: 5),
                    Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.black87)),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: primaryColor, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// DEMO 1: Basic PIN
class BasicDemo extends StatefulWidget {
  @override
  State<BasicDemo> createState() => _BasicDemoState();
}

class _BasicDemoState extends State<BasicDemo> {
  final controller = TextEditingController();
  String result = "Enter PIN...";

  @override
  Widget build(BuildContext context) {
    final defaultTheme = PinTheme(
      width: 70,
      height: 70,
      textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primaryColor),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: primaryColor, width: 2),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: primaryColor.withOpacity(0.2), blurRadius: 10, offset: Offset(0, 4))],
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text("1. Basic PIN", style: TextStyle(fontFamily: 'serif', color: Colors.white)), backgroundColor: primaryColor),
      backgroundColor: backgroundColor,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(30),
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Enter 4 Digit PIN", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'serif', color: Colors.black)),
              SizedBox(height: 10),
              Text("API: length, controller, autofocus", style: TextStyle(fontSize: 12, color: Colors.black87)),
              SizedBox(height: 30),
              Pinput(
                length: 4,
                controller: controller,
                autofocus: true,
                defaultPinTheme: defaultTheme,
                onChanged: (v) => setState(() => result = v.isEmpty ? "Enter PIN..." : "PIN: $v"),
              ),
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(10)),
                child: Text(result, style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold, fontFamily: 'serif')),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
                onPressed: () {
                  controller.clear();
                  setState(() => result = "Enter PIN...");
                },
                child: Text("Reset"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

// DEMO 2: Styling
class StylingDemo extends StatefulWidget {
  @override
  State<StylingDemo> createState() => _StylingDemoState();
}

class _StylingDemoState extends State<StylingDemo> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final defaultTheme = PinTheme(
      width: 70,
      height: 70,
      textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primaryColor),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: primaryColor, width: 2),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: primaryColor.withOpacity(0.2), blurRadius: 10, offset: Offset(0, 4))],
      ),
    );

    final focusedTheme = PinTheme(
      width: 70,
      height: 70,
      textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [primaryColor, secondaryColor]),
        border: Border.all(color: primaryColor, width: 2),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: primaryColor.withOpacity(0.5), blurRadius: 15, offset: Offset(0, 6))],
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text("2. Styling", style: TextStyle(fontFamily: 'serif', color: Colors.white)), backgroundColor: primaryColor),
      backgroundColor: backgroundColor,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(30),
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
            Text("Styled PIN", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'serif', color: Colors.black)),
            SizedBox(height: 10),
            Text("API: defaultPinTheme, focusedPinTheme", style: TextStyle(fontSize: 12, color: Colors.black87)),
              SizedBox(height: 30),
              Pinput(
                length: 4,
                controller: controller,
                autofocus: true,
                defaultPinTheme: defaultTheme,
                focusedPinTheme: focusedTheme,
              ),
              SizedBox(height: 20),
              Text("Beautiful styling!", style: TextStyle(fontSize: 12, color: Colors.black87, fontStyle: FontStyle.italic)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

// DEMO 3: Validation
class ValidationDemo extends StatefulWidget {
  @override
  State<ValidationDemo> createState() => _ValidationDemoState();
}

class _ValidationDemoState extends State<ValidationDemo> {
  final controller = TextEditingController();
  bool showError = false;
  String errorMsg = "";

  @override
  Widget build(BuildContext context) {
    final defaultTheme = PinTheme(
      width: 70,
      height: 70,
      textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primaryColor),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: primaryColor, width: 2),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: primaryColor.withOpacity(0.2), blurRadius: 10, offset: Offset(0, 4))],
      ),
    );

    final errorTheme = PinTheme(
      width: 70,
      height: 70,
      textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [primaryColor.withOpacity(0.9), secondaryColor.withOpacity(0.9)]),
        border: Border.all(color: primaryColor, width: 2),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: primaryColor.withOpacity(0.4), blurRadius: 15, offset: Offset(0, 6))],
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text("3. Validation", style: TextStyle(fontFamily: 'serif', color: Colors.white)), backgroundColor: primaryColor),
      backgroundColor: backgroundColor,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(30),
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Validate PIN", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'serif', color: Colors.black)),
              SizedBox(height: 10),
              Text("API: validator, errorPinTheme, forceErrorState", style: TextStyle(fontSize: 12, color: Colors.black87)),
              SizedBox(height: 10),
              Text("Correct: 1234", style: TextStyle(fontSize: 12, color: successColor, fontWeight: FontWeight.bold)),
              SizedBox(height: 30),
              Pinput(
                length: 4,
                controller: controller,
                autofocus: true,
                defaultPinTheme: defaultTheme,
                errorPinTheme: errorTheme,
                forceErrorState: showError,
                validator: (v) {
                  if (v!.length < 4) return "Incomplete";
                  return null;
                },
              ),
              SizedBox(height: 20),
              if (errorMsg.isNotEmpty)
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: warningColor.withOpacity(0.1),
                    border: Border.all(color: warningColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(errorMsg, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
                    onPressed: () {
                      if (controller.text == "1234") {
                        setState(() {
                          showError = false;
                          errorMsg = "✅ Correct!";
                        });
                      } else {
                        setState(() {
                          showError = true;
                          errorMsg = "❌ Wrong! Try: 1234";
                        });
                      }
                    },
                    child: Text("Check"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                    onPressed: () {
                      controller.clear();
                      setState(() {
                        showError = false;
                        errorMsg = "";
                      });
                    },
                    child: Text("Reset"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

// DEMO 4: Show/Hide
class ShowHideDemo extends StatefulWidget {
  @override
  State<ShowHideDemo> createState() => _ShowHideDemoState();
}

class _ShowHideDemoState extends State<ShowHideDemo> {
  final controller = TextEditingController();
  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    final defaultTheme = PinTheme(
      width: 70,
      height: 70,
      textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primaryColor),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: primaryColor, width: 2),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: primaryColor.withOpacity(0.2), blurRadius: 10, offset: Offset(0, 4))],
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text("4. Show/Hide", style: TextStyle(fontFamily: 'serif', color: Colors.white)), backgroundColor: primaryColor),
      backgroundColor: backgroundColor,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(30),
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
            Text("Show/Hide PIN", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'serif', color: Colors.black)),
            SizedBox(height: 10),
            Text("API: obscureText", style: TextStyle(fontSize: 12, color: Colors.black87)),
              SizedBox(height: 30),
              Pinput(
                length: 4,
                controller: controller,
                autofocus: true,
                obscureText: isObscured,
                defaultPinTheme: defaultTheme,
              ),
              SizedBox(height: 30),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
                onPressed: () => setState(() => isObscured = !isObscured),
                icon: Icon(isObscured ? Icons.visibility : Icons.visibility_off),
                label: Text(isObscured ? "Show" : "Hide"),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(10)),
                child: Text(
                  isObscured ? "PIN: ••••" : "PIN: ${controller.text}",
                  style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

// DEMO 5: Events
class EventsDemo extends StatefulWidget {
  @override
  State<EventsDemo> createState() => _EventsDemoState();
}

class _EventsDemoState extends State<EventsDemo> {
  final controller = TextEditingController();
  final focusNode = FocusNode();
  String status = "Waiting...";
  int changeCount = 0;

  @override
  Widget build(BuildContext context) {
    final defaultTheme = PinTheme(
      width: 70,
      height: 70,
      textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primaryColor),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: primaryColor, width: 2),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: primaryColor.withOpacity(0.2), blurRadius: 10, offset: Offset(0, 4))],
      ),
    );

    final focusedTheme = PinTheme(
      width: 70,
      height: 70,
      textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [primaryColor, secondaryColor]),
        border: Border.all(color: primaryColor, width: 2),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: primaryColor.withOpacity(0.5), blurRadius: 15, offset: Offset(0, 6))],
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text("5. Events", style: TextStyle(fontFamily: 'serif', color: Colors.white)), backgroundColor: primaryColor),
      backgroundColor: backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(30),
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20)],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Events Demo", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'serif', color: Colors.black)),
                SizedBox(height: 10),
                Text("API: onChanged, onCompleted", style: TextStyle(fontSize: 12, color: Colors.black87)),
                SizedBox(height: 30),
                Pinput(
                  length: 4,
                  controller: controller,
                  focusNode: focusNode,
                  autofocus: true,
                  defaultPinTheme: defaultTheme,
                  focusedPinTheme: focusedTheme,
                  onChanged: (v) {
                    setState(() {
                      changeCount++;
                      status = "Typing: ${v.length}/4";
                    });
                  },
                  onCompleted: (pin) {
                    setState(() {
                      status = "✅ Complete: $pin";
                    });
                  },
                ),
                SizedBox(height: 30),
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    border: Border.all(color: primaryColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Text(status, style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold, fontFamily: 'serif')),
                      SizedBox(height: 10),
                      Text("onChange: $changeCount times", style: TextStyle(fontSize: 12, color: Colors.black87)),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
                      onPressed: () {
                        focusNode.requestFocus();
                        setState(() => status = "Focus!");
                      },
                      child: Text("Focus"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                      onPressed: () {
                        controller.clear();
                        changeCount = 0;
                        setState(() => status = "Reset");
                      },
                      child: Text("Reset"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }
}