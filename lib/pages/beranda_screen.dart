import 'package:audiofileplayer/audiofileplayer.dart';
import 'package:earthquake_detection_app/models/riwayat_model.dart';
import 'package:earthquake_detection_app/pages/riwayat_screen.dart';
import 'package:earthquake_detection_app/services/database_helper.dart';
import 'package:earthquake_detection_app/widgets/template_app_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';

class BerandaScreen extends StatelessWidget {
  final dbRef = FirebaseDatabase.instance.ref();

  final Audio audio =
      Audio.load('assets/audios/audio.mp3', playInBackground: true);
  final Riwayat? riwayat;

  BerandaScreen({Key? key, this.riwayat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget playAudio(msg, status) {
      audio.play();
      Future.delayed(Duration.zero, () => showAlert(context, msg, status));

      return const SizedBox.shrink();
    }

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return SafeArea(
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: TemplateAppBar(),
        ),
        body: Center(
          child: StreamBuilder(
            stream: dbRef.onValue,
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return const CircularProgressIndicator();
              }
              final snapshotGetaran = snapshot.data!.snapshot
                  .child("earthquake")
                  .children
                  .elementAt(1)
                  .value
                  .toString();
              final snapshotPesan = snapshot.data!.snapshot
                  .child("earthquake")
                  .children
                  .elementAt(0)
                  .value
                  .toString();
              final snapshotHari = snapshot.data!.snapshot
                  .child("time")
                  .children
                  .elementAt(0)
                  .value
                  .toString();
              final snapshotTanggal = snapshot.data!.snapshot
                  .child("time")
                  .children
                  .elementAt(2)
                  .value
                  .toString();
              final snapshotWaktu = snapshot.data!.snapshot
                  .child("time")
                  .children
                  .elementAt(1)
                  .value
                  .toString();
              if (kDebugMode) {
                print(snapshotPesan);
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasData &&
                  !snapshot.hasError &&
                  snapshot.data != null) {
                final getaran = snapshotGetaran;
                final pesan = snapshotPesan;
                final hari = snapshotHari;
                final tanggal = snapshotTanggal;
                final waktu = snapshotWaktu;
                var status = "";
                final Riwayat model = Riwayat(
                  id: riwayat?.id,
                  status: pesan,
                  getaran: getaran,
                  hari: hari,
                  tanggal: tanggal,
                  waktu: waktu,
                );

                if (int.parse(getaran) >= 5000 && int.parse(getaran) < 6999) {
                  status = "SIAGA";
                } else if (int.parse(getaran) >= 7000 &&
                    int.parse(getaran) < 8999) {
                  status = "AWAS";
                  DatabaseHelper.addRiwayat(model);
                } else if (int.parse(getaran) >= 9000 &&
                    int.parse(getaran) < 11000) {
                  status = "BENCANA";
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (int.parse(getaran) >= 5000 &&
                        int.parse(getaran) < 6999) ...[
                      const Text(
                        "Getaran Dirasakan Status SIAGA",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      playAudio(pesan, status)
                    ] else if (int.parse(getaran) >= 7000 &&
                        int.parse(getaran) < 8999) ...[
                      const Text(
                        "Getaran Dirasakan Status AWAS",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      playAudio(pesan, status)
                    ] else if (int.parse(getaran) >= 9000 &&
                        int.parse(getaran) < 11000) ...[
                      const Text(
                        "Getaran Dirasakan Status BENCANA",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      playAudio(pesan, status)
                    ],
                    const SizedBox(height: 5),
                    const Divider(
                      thickness: 2,
                      color: Colors.black,
                      indent: 30,
                      endIndent: 30,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Kekuatan Gempa",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(getaran),
                    const SizedBox(height: 20),
                    const Text(
                      "Pesan",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(pesan),
                    const SizedBox(height: 20),
                    const Text(
                      "Hari",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(hari),
                    const SizedBox(height: 20),
                    const Text(
                      "Tanggal",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(tanggal),
                    const SizedBox(height: 20),
                    const Text(
                      "Waktu",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(waktu),
                    const SizedBox(height: 20),
                  ],
                );
              } else {
                return const Text("Salah");
              }
            },
          ),
        ),
      ),
    );
  }

  void showAlert(BuildContext context, msg, status) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(status),
          content: Text(msg),
          actions: [
            ElevatedButton.icon(
              onPressed: () {
                audio.pause();
                Navigator.pop(context);
              },
              icon: const Icon(Icons.stop),
              label: const Text("Berhenti"),
            )
          ],
        );
      },
    );
  }
}
