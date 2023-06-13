import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';

import '../controller/controllers.dart';
import '../controller/list.dart';
import '../providers/networkProvider.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  late PullToRefreshController pullRefreshController;
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<NetworkProvider>(context, listen: false).CheckInternet();
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;

    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white70,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.black,
          items: [
            BottomNavigationBarItem(
              label: "",
              icon: IconButton(
                onPressed: () async {
                  await inAppWebViewController?.loadUrl(
                    urlRequest: URLRequest(
                      url: Uri.parse("https://www.google.co.in/"),
                    ),
                  );
                },
                icon: Icon(Icons.home),
              ),
            ),
            BottomNavigationBarItem(
              label: "",
              icon: IconButton(
                icon: Icon(Icons.bookmark_add),
                onPressed: () async {
                  bookmark.add(await inAppWebViewController?.getUrl());
                },
              ),
            ),
            BottomNavigationBarItem(
              label: "",
              icon: IconButton(
                icon: Icon(Icons.arrow_back_ios_new_sharp),
                onPressed: () async {
                  if (await inAppWebViewController!.canGoBack()) {
                    inAppWebViewController?.goBack();
                  }
                },
              ),
            ),
            BottomNavigationBarItem(
              label: "",
              icon: IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  inAppWebViewController?.reload();
                },
              ),
            ),
            BottomNavigationBarItem(
              label: "",
              icon: IconButton(
                icon: Icon(Icons.arrow_forward_ios_sharp),
                onPressed: () async {
                  if (await inAppWebViewController!.canGoForward()) {
                    inAppWebViewController?.goForward();
                  }
                },
              ),
            ),
          ],
        ),
        appBar: AppBar(
          title: Text("My Browser"),
          centerTitle: true,
          actions: [
            PopupMenuButton(
              initialValue: popmenuvalue,
              icon: const Icon(Icons.more_vert),
              onSelected: (value) {
                if (value == "search_engine") {
                  showGeneralDialog(
                      context: context,
                      pageBuilder: (context, _, __) {
                        return Material(
                          child: Center(
                            child: Container(
                              height: h * 0.6,
                              width: w * 0.7,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade500,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return RadioListTile(
                                      title: Text(Enginelist[index]['name']),
                                      value: Enginelist[index]['val'],
                                      groupValue: "Google",
                                      onChanged: (val) {
                                        setState(() {
                                          Enginelist[index][val] = val!;
                                          Navigator.of(context).pushNamed(
                                              "Web_View_Page",
                                              arguments: Enginelist[index]);
                                        });
                                      });
                                },
                                itemCount: Enginelist.length,
                              ),
                            ),
                          ),
                        );
                      });
                } else if (value == "BookMark") {
                  showGeneralDialog(
                      context: context,
                      pageBuilder: (context, _, __) {
                        return Container(
                          padding: EdgeInsets.all(16),
                          margin: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Text(
                                    "${bookmark[index]}",
                                    style: TextStyle(
                                        fontSize: 8, color: Colors.black),
                                  ),
                                  Divider(color: Colors.black, thickness: 2),
                                ],
                              );
                            },
                            itemCount: bookmark.length,
                          ),
                        );
                      });
                }
                ;
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: "BookMark",
                  child: Row(
                    children: [
                      Icon(Icons.bookmark_add),
                      SizedBox(
                        width: 20,
                      ),
                      Text("All BookMarks"),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  padding: EdgeInsets.all(16),
                  value: "search_engine",
                  child: Row(
                    children: [
                      Icon(Icons.screen_search_desktop_outlined),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Search Engine"),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        body: (Provider.of<NetworkProvider>(
                  context,
                ).networkmodel.NetworkStatus ==
                "Waiting")
            ? Center(
                child: Container(
                  child: Text("no Internet   Please connect"),
                ),
              )
            : InAppWebView(
                pullToRefreshController: pullRefreshController,
                initialUrlRequest: URLRequest(
                  url: Uri.parse("https://www.google.co.in/"),
                ),
                onLoadStart: (controller, uri) {
                  setState(() {
                    inAppWebViewController = controller;
                  });
                },
                onLoadStop: (controller, uri) async {
                  await pullRefreshController.endRefreshing();
                },
              ));
  }
}
