import 'package:admin_job/constant/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:share_plus/share_plus.dart';

import 'constant/colors.dart';
import 'method.dart';

class OutDoctors extends StatefulWidget {
  @override
  State<OutDoctors> createState() => _OutDoctorsState();
}

class _OutDoctorsState extends State<OutDoctors> {
  List outDoctors = [];

  @override
  void initState() {
    super.initState();
    Method().getOutDoctors().then((value) {
      setState(() {
        outDoctors = value;
      });
    });
  }

  final FlutterShareMe flutterShareMe = FlutterShareMe();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: red,
        title: const Text('Out Doctors'),
        actions: [
          ElevatedButton(
            onPressed: () async {
              await Method().sendWhatssApp('962798583052', whatsmessage1);
            },
            child: const Text('WhatsApp'),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: outDoctors.length,
        itemBuilder: (BuildContext context, int index) {
          return NeomphormDark(
            color: white,
            width: .9,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NeomphormDark(
                      width: .6,
                      color: gren!,
                      child: Text(
                        outDoctors[index]['name'].toString(),
                        style: tilte1Style,
                      ),
                    ),
                    NeomphormDark(
                      width: .1,
                      color: blue,
                      child: InkWell(
                        child: Text(
                          outDoctors[index]['Specification'].toString(),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      outDoctors[index]['site'].toString(),
                    ),
                    Text(
                      outDoctors[index]['city'].toString(),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    NeomphormDark(
                      color: red,
                      width: .4,
                      child: InkWell(
                        onTap: () {
                          Method().callPhone(outDoctors[index]['phone']);
                        },
                        child: Text(
                          outDoctors[index]['email'].toString(),
                        ),
                      ),
                    ),
                    NeomphormDark(
                      color: Colors.yellow,
                      width: .4,
                      child: InkWell(
                        onTap: () {
                          Method().callPhone(outDoctors[index]['phone']);
                        },
                        child: Text(
                          outDoctors[index]['phone'].toString(),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
