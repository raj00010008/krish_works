import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'common/app_constants/app_constant.dart';
import 'common/colors/app_color.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late WebViewController _webViewController;

  bool _selectedGallery = true;

  bool _selectedContact = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Close',
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .merge(TextStyle(color: AppColor.white)),
                  )),
              Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    'Setting',
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .merge(TextStyle(color: AppColor.white)),
                  ))
            ],
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: AppColor.white,
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          right: BorderSide(color: AppColor.darkBlue, width: 2),
                        ),
                      ),
                      child: ListView(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                border: const Border(
                                    right: BorderSide(color: Colors.grey),
                                    top: BorderSide(
                                        color: Colors.grey, width: 1)),
                                color: _selectedGallery
                                    ? AppColor.darkBlue
                                    : AppColor.white),
                            child: ListTile(
                              title: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Gallery',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2!
                                      .merge(TextStyle(
                                          color: _selectedGallery
                                              ? AppColor.gold
                                              : Colors.black)),
                                ),
                              ),
                              onTap: () {
                                if (_selectedGallery == false) {
                                  _webViewController.loadUrl(
                                     AppConstant.GALLERY_URL);
                                }
                                setState(() {
                                  _selectedGallery = true;
                                  _selectedContact = false;
                                });
                              },
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: const Border(
                                  bottom: BorderSide(
                                      color: AppColor.darkBlue, width: 2),
                                ),
                                color: _selectedContact
                                    ? AppColor.darkBlue
                                    : AppColor.white),
                            child: ListTile(
                              title: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Contact Us",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2!
                                      .merge(TextStyle(
                                          color: _selectedContact
                                              ? AppColor.gold
                                              : Colors.black)),
                                ),
                              ),
                              onTap: () {
                                if (_selectedContact == false) {
                                  _webViewController.loadUrl(
                                     AppConstant.CONTACT_URL);
                                }
                                setState(() {
                                  _selectedContact = true;
                                  _selectedGallery = false;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                      flex: 5,
                      child: WebView(
                        javascriptMode: JavascriptMode.unrestricted,
                        initialUrl: AppConstant.GALLERY_URL,
                        onWebViewCreated: (controller) {
                          _webViewController = controller;
                        },
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
