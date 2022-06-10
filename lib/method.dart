import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:admin_job/constant/const.dart';
import 'package:admin_job/db/db.dart';
import 'package:admin_job/model/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'constant/url.dart';

class Method {
  List<Doctors> doctors = [];
  Future getDoctors() async {
    var res = await http.post(Uri.parse('${url}getDoctors.php'), body: {});
    // print(jsonDecode(res.body));
    return jsonDecode(res.body);
  }

  Future getOutDoctors() async {
    var res = await http.post(Uri.parse('${url}getOutDoctors.php'), body: {});
    print(jsonDecode(res.body));
    return jsonDecode(res.body);
  }

  Future sendWhatssApp(String phone, message) async {
    String url() {
      if (Platform.isIOS) {
        return "whatsapp://wa.me/+962$phone/?text=${Uri.parse(message + whatsmessge6)}";
      } else {
        return "whatsapp://send?phone=+962$phone&text=${Uri.parse(message)}";
      }
    }

    await http.post(Uri.parse(url()), body: {});
    // print(jsonDecode(res.body));

    // await launch(url());
  }

  // Future<void> share() async {
  // shareToWhatsApp;
  // Share.whatsapp;
  // await WhatsappShare.share(
  //   text: 'Example share text',
  //   linkUrl: 'https://flutter.dev/',
  //   phone: '911234567890',
  // );
  // }
  // launchWhatsApp() async {
  //   final link = WhatsAppUnilink(
  //     phoneNumber: '+001-(555)1234567',
  //     text: "Hey! I'm inquiring about the apartment listing",
  //   );
  //   // Convert the WhatsAppUnilink instance to a string.
  //   // Use either Dart's string interpolation or the toString() method.
  //   // The "launch" method is part of "url_launcher".
  //   await launch('$link');
  // }

  Future sendWhatssAppFile(String phone, File message) async {
    String url() {
      if (Platform.isIOS) {
        return "whatsapp://wa.me/+962$phone/?PDF=$message";
      } else {
        return "whatsapp://send?phone=+962$phone&text=$message";
      }
    }

    await launch(url());
  }

  Future sendSMS(String phone, message) async {
    if (Platform.isAndroid) {
      String uri = 'sms:+$phone?body=$message';
      await launch(uri);
    } else if (Platform.isIOS) {
      // iOS
      String uri = 'sms:$phone&body=$message';
      await launch(uri);
    }
  }

  void sendEmail(String email, message) async {
    var url = '$email?subject=Clinc App&body=$message';
    // print(url);
    Share.share('text');
    await launch(url);
  }

  Future callPhone(String phoneNumber) async {
    await launch("tel://$phoneNumber");
  }

  Future getMyDoctors() async {
    var res = await http.post(Uri.parse('${url}getMyDoctors.php'), body: {});
    // print(jsonDecode(res.body));
    return jsonDecode(res.body);
  }

  Future getDoctorsToDB() async {
    var res = await http.post(Uri.parse('${url}getDoctors.php'), body: {});
    var list = jsonDecode(res.body);
    await DBSql('doctors').getData('doctors').then((value) {
      if (value.isEmpty) {
        for (var i = 0; i < list.length; i++) {
          DBSql('doctors').insert({
            'name': list[i]['name'].toString(),
            'phone': list[i]['phone'].toString(),
            'email': list[i]['email'].toString(),
            'city': list[i]['city'].toString(),
            'site': list[i]['site'].toString(),
            'spesfication': 'sonra',
          });
        }
      } else {
        print('doctors not null and = ${value.length}');
      }
    });

    // print(jsonDecode(res.body));
    return jsonDecode(res.body);
  }

  Future updateSpesfication(
      String spes, String id, String price, String duration) async {
    var res = await http.post(Uri.parse('${url}updateSpesfication.php'), body: {
      'title': spes,
      'price': price,
      'id': id,
      'duration': duration,
    });
    // print(res.body);
    if (res.statusCode == 200) {
      Get.snackbar('Updated', 'Sucssful', backgroundColor: Colors.green);
    } else {
      Get.snackbar('Not Updated', 'Faild', backgroundColor: Colors.red);
    }
  }

  Future addDoctors(String name, phone, email, city, site, spes, price) async {
    var res = await http.post(Uri.parse('${url}add_myDoctor.php'), body: {
      'name': name.toString(),
      'phone': phone.toString(),
      'email': email.toString(),
      'city': city.toString(),
      'site': site.toString(),
      'spesfication': spes.toString(),
      'price': price.toString(),
    });
    // print(res.body);
    if (res.statusCode == 200) {
      Get.snackbar('Added', 'Sucssful', backgroundColor: Colors.green);
    } else {
      print(res.body);
      Get.snackbar('Not Added', res.body.toString(),
          backgroundColor: Colors.red);
    }
  }
}

class NeomphormDark extends StatelessWidget {
  // final String title;
  final double width;
  final Widget child;
  final Color color;
  const NeomphormDark(
      {Key? key,
      // required this.title,
      required this.width,
      required this.child,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        width: MediaQuery.of(context).size.width * width,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(12),
          // shape: BoxShape.rectangle,
          boxShadow: [
            BoxShadow(
              color: color,
              offset: const Offset(4, 7),
              blurRadius: 15,
              spreadRadius: 1,
            ),
            const BoxShadow(
              color: Colors.white12,
              offset: Offset(-7, -4),
              blurRadius: 15,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Center(child: child),
      ),
    );
  }
}

class BubelButton extends StatelessWidget {
  const BubelButton({
    Key? key,
    required this.width,
    // required this.height,
    required this.color,
    required this.child,
  }) : super(key: key);

  final double width;
  // final double height;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      // height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        shape: BoxShape.rectangle,
        gradient: LinearGradient(
          colors: [
            color.withOpacity(.2),
            color.withOpacity(.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: const [.1, .9],
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.deepPurple.shade700,
              offset: const Offset(4, 4),
              blurRadius: 15,
              spreadRadius: 1),
          BoxShadow(
              color: Colors.deepPurple.shade200,
              offset: const Offset(-4, -4),
              blurRadius: 15,
              spreadRadius: 1),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: child,
      ),
    );
  }
}

class Buton extends StatelessWidget {
  final String string;
  final double width;
  final VoidCallback voidCallback;

  const Buton(
      {super.key,
      required this.string,
      required this.width,
      required this.voidCallback});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: voidCallback,
          child: Container(
            height: size.width / 8,
            width: size.width / width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.05),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              string,
              style: TextStyle(color: Colors.white.withOpacity(.8)),
            ),
          ),
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final bool isPassword;
  final bool isEmail;
  final TextEditingController textController;

  const MyTextField(
      {super.key,
      required this.icon,
      required this.hintText,
      required this.isPassword,
      required this.isEmail,
      required this.textController});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaY: 15,
          sigmaX: 15,
        ),
        child: Container(
          height: size.width / 8,
          width: size.width / 1.2,
          alignment: Alignment.center,
          padding: EdgeInsets.only(right: size.width / 30),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.05),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            controller: textController,
            style: TextStyle(color: Colors.white.withOpacity(.8)),
            cursorColor: Colors.white,
            obscureText: isPassword,
            keyboardType:
                isEmail ? TextInputType.emailAddress : TextInputType.text,
            decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: Colors.white.withOpacity(.7),
              ),
              border: InputBorder.none,
              hintMaxLines: 1,
              hintText: hintText,
              hintStyle:
                  TextStyle(fontSize: 14, color: Colors.white.withOpacity(.5)),
            ),
          ),
        ),
      ),
    );
  }
}
