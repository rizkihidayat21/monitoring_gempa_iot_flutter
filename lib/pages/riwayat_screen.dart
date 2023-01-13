import 'package:earthquake_detection_app/models/riwayat_model.dart';
import 'package:earthquake_detection_app/services/database_helper.dart';
import 'package:earthquake_detection_app/widgets/riwayat_item.dart';
import 'package:earthquake_detection_app/widgets/template_app_bar.dart';

import 'package:flutter/material.dart';

class RiwayatScreen extends StatefulWidget {
  const RiwayatScreen({
    super.key,
  });

  @override
  State<RiwayatScreen> createState() => _RiwayatScreenState();
}

class _RiwayatScreenState extends State<RiwayatScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: TemplateAppBar(),
        ),
        body: FutureBuilder<List<Riwayat>?>(
          future: DatabaseHelper.getAllRiwayat(),
          builder: (context, AsyncSnapshot<List<Riwayat>?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else if (snapshot.hasData) {
              if (snapshot.data != null) {
                return Stack(
                  children: [
                    ListView.builder(
                      itemBuilder: (context, index) => RiwayatItem(
                        riwayat: snapshot.data![index],
                        onTap: () async {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title:
                                    const Text('Yakin mau hapus riwayat ini?'),
                                actions: [
                                  ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red)),
                                    onPressed: () async {
                                      await DatabaseHelper.deleteRiwayat(
                                          snapshot.data![index]);
                                      Navigator.pop(context);
                                      setState(() {});
                                    },
                                    child: const Text('Ya'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Tidak'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      itemCount: snapshot.data!.length,
                    ),
                    Positioned(
                      bottom: 20,
                      right: 20,
                      child: FloatingActionButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text(
                                    'Yakin mau hapus semua riwayat?'),
                                actions: [
                                  ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red)),
                                    onPressed: () async {
                                      await DatabaseHelper.deleteAllRiwayat(
                                          snapshot.data!);
                                      Navigator.pop(context);
                                      setState(() {});
                                    },
                                    child: const Text('Ya'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Tidak'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Icon(
                          Icons.delete,
                        ),
                      ),
                    ),
                  ],
                );
              }
              return const Center(
                child: Text('No notes yet'),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
