import 'package:admin_job/constant/colors.dart';
import 'package:admin_job/constant/const.dart';
import 'package:flutter/material.dart';

import 'method.dart';

class Mydoctors extends StatefulWidget {
  const Mydoctors({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MydoctorsState createState() => _MydoctorsState();
}

class _MydoctorsState extends State<Mydoctors> {
  List doctors = [];
  @override
  void initState() {
    super.initState();
    Method().getMyDoctors().then((value) {
      setState(() {
        doctors = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: gren,
        title: const Text('My Doctors'),
      ),
      body: ListView.builder(
        itemCount: doctors.length,
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
                        doctors[index]['name'].toString(),
                        style: tilte1Style,
                      ),
                    ),
                    NeomphormDark(
                      width: .1,
                      color: blue,
                      child: InkWell(
                        child: Text(
                          doctors[index]['Specification'].toString(),
                        ),
                      ),
                    ),
                    NeomphormDark(
                      width: .16,
                      color: gren!,
                      child: InkWell(
                        child: Text(
                          doctors[index]['duration'].toString(),
                        ),
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
                      color: red,
                      width: .4,
                      child: InkWell(
                        onTap: () {
                          doctors[index]['email'].toString().contains('@')
                              ? Method().sendEmail(
                                  doctors[index]['email'], whatsmessage1)
                              : Method().callPhone(doctors[index]['email']);
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
