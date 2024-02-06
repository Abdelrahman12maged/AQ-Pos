import 'package:aq_pos/WebViewStack.dart';
import 'package:aq_pos/navigationwebbView.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewAqPos extends StatefulWidget {
  const WebViewAqPos({super.key});

  @override
  State<WebViewAqPos> createState() => _WebViewAqPosState();
}

class _WebViewAqPosState extends State<WebViewAqPos> {
  Future<bool> showExitConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text(
                'هل تريد الخروج من التطبيق',
                style: TextStyle(fontSize: 20),
                textDirection: TextDirection.rtl,
              ),
              actions: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.blueGrey[800])),
                      onPressed: () {
                        Navigator.of(context)
                            .pop(false); // إغلاق الحوار واسترجاع false
                      },
                      child: Text('لا',
                          style: TextStyle(
                              color: const Color.fromARGB(255, 240, 24, 8),
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.blueGrey[800])),
                      onPressed: () {
                        Navigator.of(context)
                            .pop(true); // إغلاق الحوار واسترجاع true
                      },
                      child: Text(
                        'نعم',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 6, 226, 13),
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ],
                )
              ],
            );
          },
        ) ??
        false; // إرجاع قيمة افتراضية في حالة عدم الضغط على أي زر
  }

  WebViewController controller = WebViewController();
  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..loadRequest(
        Uri.parse('https://pos.aqdeveloper.tech/login'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await controller.canGoBack()) {
          controller.goBack();
          return false;
        } else {
          return showExitConfirmationDialog(context);
        }
        // return true;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: BackButton(color: Colors.white),
            title: Padding(
              padding: const EdgeInsets.only(left: 100),
              child: const Text(
                'AQ POS',
                style: TextStyle(color: Colors.white),
              ),
            ),

            actions: [
              IconButton(
                icon: const Icon(
                  Icons.replay,
                  color: Colors.white,
                ),
                onPressed: () {
                  controller.reload();
                },
              ),
              //    NavigationControls(controller: controller),
            ],
            //   backgroundColor: Color.fromARGB(255, 40, 9, 176),
          ),
          body: RefreshIndicator(
              onRefresh: () async {
                await controller.reload();
              },
              child: WebViewStack(controller: controller)),
        ),
      ),
    );
  }
}
