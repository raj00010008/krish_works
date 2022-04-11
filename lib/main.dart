import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:krishworks/common/app_constants/app_constant.dart';
import 'package:krishworks/common/colors/app_color.dart';
import 'package:krishworks/setting_page.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'common/font/app_font.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // Theme.of(context).textTheme.headline1
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KrishWork Demo',
      theme: ThemeData(
          primarySwatch: primaryColors,
          textTheme: ThemeData.light().textTheme.copyWith(
              headline1: const TextStyle(
                  fontSize: AppFontSize.REGULAR_TEXT, fontFamily: 'Poppins'),
              headline2: const TextStyle(
                  fontSize: AppFontSize.MEDIUM_TEXT, fontFamily: 'Poppins'))),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  bool _selectedIcon = false;
  int currentState = 0;
  bool _selectedHome = true;
  bool _selectedAbout = false;
  bool _selectedUpdate = false;
  late WebViewController _webViewController;
  late final TextEditingController textEditingController;
  late int pass;

  @override
  void initState() {
    textEditingController = TextEditingController();

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(55.0),
          child: AppBar(
            leading: InkWell(
                    child: const Icon(Icons.settings),
                    onTap: () {
                      passCalculation();
                      setState(() {
                        _selectedIcon = true;
                      });
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              scrollable: true,
                              title:  Center(child: Text('Developer Passcode',style: Theme.of(context).textTheme.headline1!.merge(const TextStyle(fontSize: 18,color: Colors.black,fontWeight:FontWeight.w200),),)),
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Form(
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        width: w * 0.40,
                                        child: PinCodeTextField(

                                          textStyle:Theme.of(context)
                                              .textTheme.headline1!.merge(const TextStyle(fontSize: 35,fontWeight:FontWeight.w300,color: Colors.black )),
                                          autoFocus: true,
                                          cursorColor: Colors.grey,
                                          showCursor: true,
                                          backgroundColor: Colors.white,
                                          onCompleted: (v) async {
                                            if (pass.toString().padLeft(6, '0') ==
                                                v) {
                                              textEditingController.clear();
                                              _selectedIcon = true;
                                              Navigator.pop(context);
                                            await  Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                    const SettingPage()),
                                              );
                                            }
                                          },
                                          length: 6,
                                          onChanged: (String value) {
                                            print(value);
                                          },
                                          appContext: context,
                                          pinTheme: PinTheme(
                                            activeColor: Colors.grey ,
                                            inactiveColor: Colors.grey,
                                            inactiveFillColor: Colors.grey,
                                            shape: PinCodeFieldShape.box,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            fieldHeight: 75,
                                            fieldWidth: 55,
                                            activeFillColor: Colors.white,
                                          ),
                                          keyboardType: TextInputType.number,
                                          controller: textEditingController,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                  ),
            title: Container(
              decoration: const BoxDecoration(
                color: AppColor.lightBlue,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 1.0, bottom: 1.0, left: 20.0, right: 20.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        primary:
                            _selectedHome ? AppColor.white : AppColor.lightBlue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 1.0, bottom: 1.0, left: 20.0, right: 20.0),
                        child: Text(
                          'Home',
                          style:
                          Theme.of(context).textTheme.headline2!.merge( TextStyle(
                              color: _selectedHome
                                  ? AppColor.lightBlue
                                  : AppColor.white)),
                        ),
                      ),
                      onPressed: () {
                        // _controller.forward();
                        if (_selectedHome == false) {
                          _webViewController.loadUrl(AppConstant.Home_URL);
                        }
                        setState(() {
                          _selectedHome = true;
                          _selectedAbout = false;
                          _selectedUpdate = false;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 1.0, bottom: 1.0, left: 20.0, right: 20.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary:
                            _selectedAbout ? AppColor.white : AppColor.lightBlue,
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 1.0, bottom: 1.0, left: 20.0, right: 20.0),
                        child: Text(
                          'About us',
                          style:
                          Theme.of(context).textTheme.headline2!.merge(
                          TextStyle(
                              color: _selectedAbout
                                  ? AppColor.lightBlue
                                  : AppColor.white),
                        )),
                      ),
                      onPressed: () {
                        if (_selectedAbout == false) {
                          _webViewController
                              .loadUrl(AppConstant.ABOUT_URL);
                        }
                        setState(() {
                          _selectedHome = false;
                          _selectedAbout = true;
                          _selectedUpdate = false;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 2.0, bottom: 2.0, left: 20.0, right: 20.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        primary:
                            _selectedUpdate ? AppColor.white : AppColor.lightBlue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 1.0, bottom: 1.0, left: 20.0, right: 20.0),
                        child: Text(
                          'Updates',
                          style:
                          Theme.of(context).textTheme.headline2!.merge(
                          TextStyle(
                              color: _selectedUpdate
                                  ? AppColor.lightBlue
                                  : AppColor.white),
                        ),)
                      ),
                      onPressed: () {
                        if (_selectedUpdate == false) {
                          _webViewController
                              .loadUrl(AppConstant.UPDATES_URL);
                        }
                        setState(() {
                          _selectedHome = false;
                          _selectedAbout = false;
                          _selectedUpdate = true;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            centerTitle: true, // Text(widget.title),
          ),
        ),
        body:
        WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: AppConstant.Home_URL,
          onWebViewCreated: (controller) {
            _webViewController = controller;
          },
        ));
  }


  void passCalculation() {
    DateTime now = DateTime.now();
    var day = now.day;
    var month = now.month;
    var year = now.year;
    print(day * month * year);
    pass = day * month * year;
  }
}

