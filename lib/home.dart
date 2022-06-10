import 'package:admin_job/constant/colors.dart';
import 'package:admin_job/method.dart';
import 'package:admin_job/mydoctors.dart';
import 'package:admin_job/out_doctos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constant/const.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List doctors = [];
  TextEditingController spesfication = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController duration = TextEditingController();

  @override
  void initState() {
    Method().getDoctors().then((value) {
      // DBSql('doctors').getData('doctors').then((value) {
      setState(() {
        doctors = value;
      });
    });

    // print(doctors);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
              onPressed: () {
                // DBSql('doctors').deleteAll('doctors');
                Get.to(() => const Mydoctors());
              },
              icon: Icon(
                Icons.home_max,
                color: nb1,
              )),
          IconButton(
            onPressed: () {
              // DBSql('doctors').deleteAll('doctors');
              Get.to(() => OutDoctors());
            },
            icon: Icon(
              Icons.outbond_outlined,
              color: red,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: doctors.length,
        itemBuilder: (BuildContext context, int index) {
          return NeomphormDark(
            width: .92,
            color: white,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onLongPress: () async {
                        Method().sendWhatssApp(
                            doctors[index]['phone'].toString(),
                            whatsmessage1 +
                                whatsmessge2 +
                                whatsmessge3 +
                                whatsmessge4 +
                                whatsmessge5);
                      },
                      child: NeomphormDark(
                        color: white,
                        width: .5,
                        child: Text(doctors[index]['name'].toString(),
                            style: tilte1Style),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // print(doctors[index]['id']);
                        Get.defaultDialog(
                          backgroundColor: Colors.grey,
                          title:
                              'Add the Spesfication for  ${doctors[index]['name']}',
                          content: Column(
                            children: [
                              MyTextField(
                                  icon: Icons.timelapse_rounded,
                                  hintText: 'spesfication',
                                  isPassword: false,
                                  isEmail: false,
                                  textController: spesfication),
                              MyTextField(
                                  icon: Icons.timelapse_rounded,
                                  hintText: 'price',
                                  isPassword: false,
                                  isEmail: false,
                                  textController: price),
                              MyTextField(
                                  icon: Icons.timelapse_rounded,
                                  hintText: 'duration',
                                  isPassword: false,
                                  isEmail: false,
                                  textController: duration),
                              ElevatedButton(
                                child: const Text('Update'),
                                onPressed: () async {
                                  // await DBSql('doctors')
                                  //     .updateSpesfication(
                                  //   'doctors',
                                  //   spesfication.text.toString(),
                                  //   doctors[index]['id'].toString(),
                                  // )
                                  //     .then((value) {
                                  //   Get.back();
                                  // });
                                  await Method().updateSpesfication(
                                      spesfication.text.toString(),
                                      doctors[index]['id'],
                                      price.text.toString(),
                                      duration.text.toString());
                                  // ignore: use_build_context_synchronously
                                  navigator?.pop(context);

                                  // Get.to(() => const Mydoctors());
                                },
                              )
                            ],
                          ),
                        );
                      },
                      child: NeomphormDark(
                        color:
                            doctors[index]['Specification'].toString() == 'ok'
                                ? gren!
                                : red,
                        width: .2,
                        child: Text(
                          doctors[index]['Specification'].toString(),
                        ),
                      ),
                    ),
                    NeomphormDark(
                      color: Colors.brown,
                      width: .1,
                      child: Text(
                        doctors[index]['price'].toString(),
                      ),
                    )
                  ],
                ),
                NeomphormDark(
                  color: white,
                  width: .9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        doctors[index]['site'].toString(),
                      ),
                      Text(
                        doctors[index]['city'].toString(),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    NeomphormDark(
                      color: white,
                      width: .4,
                      child: InkWell(
                        onTap: () {
                          Method().callPhone(doctors[index]['email']);
                        },
                        child: Text(
                          doctors[index]['email'].toString(),
                        ),
                      ),
                    ),
                    NeomphormDark(
                      color: Colors.yellow,
                      width: .4,
                      child: InkWell(
                        onTap: () {
                          Method().callPhone(doctors[index]['phone']);
                        },
                        child: Text(
                          doctors[index]['phone'].toString(),
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
