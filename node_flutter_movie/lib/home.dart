import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:node_flutter_movie/description.dart';

import 'Models/model.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  List<Data> dataList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAlbum();
  }

  void fetchAlbum() async {
    final response =
        await http.get(Uri.parse('http://192.168.0.100:5000/qwerty123/data'));
    Map map = jsonDecode(response.body) as Map<String, dynamic>;
    for (var item in map['movieData']) {
      Data data = Data(
          name: item['name'],
          desc: item['desc'],
          image: item["image"],
          link: item["link"]);
      dataList.add(data);
    }
    setState(() {});
  }

  Future<void> refresh() async {
    fetchAlbum();
    setState(() {});
  }

  static const imageBaseUrl = "http://192.168.0.100:5000/qwerty123/image/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: refresh,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("images/homeback.jpg"),
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.2)),
              child: GridView.builder(
                itemCount: dataList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: (0.8),
                    crossAxisCount: 7,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 5.0),
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.white,
                    child: Card(
                      elevation: 5,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => descPage(
                                videoLink: dataList[index].link,
                                desc: dataList[index].desc,
                                image: dataList[index].image,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    imageBaseUrl + dataList[index].image),
                                fit: BoxFit.fill),
                          ),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                dataList[index].name,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
