import 'dart:core';

class Riwayat {
  final int? id;
  final String status;
  final String getaran;
  final String hari;
  final String tanggal;
  final String waktu;

  const Riwayat({
    required this.id,
    required this.status,
    required this.getaran,
    required this.hari,
    required this.tanggal,
    required this.waktu,
  });

  factory Riwayat.fromJson(Map<String, dynamic> json) => Riwayat(
        id: json['id'],
        status: json['status'],
        getaran: json['getaran'],
        hari: json['hari'],
        tanggal: json['tanggal'],
        waktu: json['waktu'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'status': status,
        'getaran': getaran,
        'hari': hari,
        'tanggal': tanggal,
        'waktu': waktu,
      };
}
