import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:scanmakan/tools/resources/resources.dart';

class KonsulPage extends StatefulWidget {
  @override
  _KonsulState createState() => _KonsulState();
}

class _KonsulState extends State<KonsulPage> {
  List<String> chatList = new List();
  TextEditingController controoller = new TextEditingController();
  int chatSizeReduce=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new ListTile(
          trailing: new Image.asset(Resources.rekomendariIcon),
          title: new Text("Live Chat"),
          subtitle: new Text("Sarah Ardika S.Gz"),
        ),
        backgroundColor: Colors.grey[300],
      ),
      body: Container(
        child: Container(
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 80),
                child: ListView(
                  children: chatList.map((e) => SinggleChatWidget(e)).toList(),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: new TextField(
                  controller: controoller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Pesan",
                      suffix: GestureDetector(
                          onTap: () => this.setState(() {
                                chatList.add(controoller.value.text);
                                controoller.text = "";
                              }),
                          child: new Icon(Icons.send))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding SinggleChatWidget(String s) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          new Image.asset(
            Resources.rekomendariIcon,
            height: 40,
            width: 40,
          ),
          new Bubble(
            margin: BubbleEdges.only(top: 10, left: 20),
            nip: BubbleNip.leftBottom,
            child: new Text(s),
          ),
        ],
      ),
    );
  }
}
