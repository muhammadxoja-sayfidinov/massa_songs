import 'package:flutter/material.dart';

import 'home.page.dart';
class frist_page extends StatelessWidget {
  const frist_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children:[
        Container(
          width:MediaQuery.of(context).size.width * 0.8 ,
          height: MediaQuery.of(context).size.height * 0.8,
          child: Image.network('https://yt3.ggpht.com/ytc/AKedOLQjRd8JtdxOv3saJt31jIvdnRMTQW-bnMWU1WuX=s900-c-k-c0x00ffffff-no-rj'),
      ),
      FlatButton(
        onPressed: () {  Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Homepage()),
        ); },
        child: Container(
          color: Colors.orange,
          width: 250,
          height: 100,
          child:Center(child: const Text('Open',style: TextStyle(fontSize: 75),)),
        ),
      )
    ]);
  }
}
