import 'dart:collection';
import 'dart:io';

/// Waiting list kendaraan (FIFO).
final Queue<String> waitingList = Queue<String>();

/// Tiga pos pencucian. null = pos kosong.
final Map<String, String?> pos = {'A': null, 'B': null, 'C': null};

void tampilmenu() {
  print('======================');
  print('Wash & Clean');
  print('======================');
  print('1. Tambah Waiting List');
  print('2. Lihat Waiting List');
  print('3. Lihat Pos');
  print('4. Selesaikan Pos');
  print('5. Keluar dari Aplikasi');
  print('======================');
}

/// Memasukkan kendaraan ke pos tertentu.
void masukkanKePos(String kode, String plat) {
  pos[kode] = plat;
  print('Kendaraan plat $plat masuk Pos $kode');
}

/// Mengisi pos yang kosong dengan kendaraan dari waiting list.
void isiPosKosong() {
  for (final kode in pos.keys) {
    if (pos[kode] == null && waitingList.isNotEmpty) {
      masukkanKePos(kode, waitingList.removeFirst());
    }
  }
}

void tambahWaitingList() {
  stdout.write('Plat Kendaraan : ');
  final plat = (stdin.readLineSync() ?? '').trim().toUpperCase();
  if (plat.isEmpty) {
    print('Plat kendaraan tidak boleh kosong.');
    return;
  }
  waitingList.add(plat);
  isiPosKosong();
  if (waitingList.contains(plat)) {
    print('Kendaraan plat $plat masuk waiting list');
  }
}

void showlist() {
  print('Daftar Waiting List');
  if (waitingList.isEmpty) {
    print('(kosong)');
    return;
  }
  var urutan = 1;
  for (final plat in waitingList) {
    print('Urutan $urutan : $plat');
    urutan++;
  }
}

void lihatPos() {
  print('Antrian Pada Pos');
  pos.forEach((kode, plat) => print('Pos $kode : ${plat ?? '-'}'));
}

void selesaikanPos() {
  stdout.write('Pilih Pos (A/B/C) : ');
  final kode = (stdin.readLineSync() ?? '').trim().toUpperCase();
  if (!pos.containsKey(kode)) {
    print('Pos tidak valid.');
    return;
  }
  final plat = pos[kode];
  if (plat == null) {
    print('Pos $kode sedang kosong.');
    return;
  }
  pos[kode] = null;
  print('Kendaraan plat $plat telah selesai');
  isiPosKosong(); // kendaraan berikutnya dari waiting list masuk
}

void main() {
  while (true) {
    tampilmenu();
    stdout.write('Pilih Menu (1/2/3/4/5) : ');
    final pilihan = (stdin.readLineSync() ?? '').trim();
    print('');

    switch (pilihan) {
      case '1':
        tambahWaitingList();
        break;
      case '2':
        showlist();
        break;
      case '3':
        lihatPos();
        break;
      case '4':
        selesaikanPos();
        break;
      case '5':
        print('Terima kasih telah menggunakan Wash & Clean.');
        exit(0);
      default:
        print('Menu tidak valid.');
    }
    print('');
  }
}