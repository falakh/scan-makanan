import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:scanmakan/tools/resources/resources.dart';

class KonsulPage extends StatelessWidget {
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
              Positioned(
                bottom: -10,
                right: 0,
                top: 0,
                left: 0,
                child: ListView(
                  children: <Widget>[
                    SinggleChatWidget()
                  ],
                ),
              ),
              Positioned(
                child: new TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Pesan",
                      suffix: GestureDetector(
                          onTap: () => print("Tekan"),
                          child: new Icon(Icons.send))),
                ),
                bottom: 10,
                right: 0,
                width: MediaQuery.of(context).size.width,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SinggleChatWidget extends StatelessWidget {
  const SinggleChatWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          new Image.asset(Resources.rekomendariIcon,height: 40,width: 40,),
          new Bubble(
            margin: BubbleEdges.only(top: 10, left: 20),
            nip: BubbleNip.leftBottom,
            child: new Text("Ini chat"),
          ),
        ],
      ),
    );
  }
}
