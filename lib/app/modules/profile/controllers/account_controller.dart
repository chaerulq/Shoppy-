import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'dart:async';
import '../../../data/models/account_model.dart';

class AccountController extends GetxController {
  final DatabaseReference _dbRef =
      FirebaseDatabase.instance.ref().child('account');
  // Definisikan StreamController sebagai Broadcast Stream
  final StreamController<String> _streamController =
      StreamController<String>.broadcast();

  // Fungsi untuk mendapatkan Stream dari StreamController
  Stream<String> get stream => _streamController.stream;

  Account? currentAccount;

  @override
  void onClose() {
    _streamController.close();
    super.onClose();
  }

  void updateUID(String message) {
    _streamController.add(message);
  }

  Future<void> createAccount({
    required String name,
    required String uID,
    required String username,
    required String password,
    required String phoneNumber,
    required String pin,
  }) async {
    try {
      await _dbRef.child(username).set({
        'name': name,
        'username': username,
        'password': password,
        'phone_number': phoneNumber,
        'pin': pin,
        'saldo': 0,
        'uID': uID,
      });
      Get.snackbar('Success', 'Account created successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<Account?> fetchAccountByUID(String uID) async {
    try {
      DatabaseEvent event = await _dbRef.child(uID).once();
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.exists) {
        Map<String, dynamic> accountData =
            Map<String, dynamic>.from(snapshot.value as Map);
        return Account.fromMap(uID, accountData);
      } else {
        Get.snackbar('Error', 'No account found with uID: $uID');
        return null;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return null;
    }
  }

  Future<Account?> fetchAccountByphoneNumber(String phoneNumber) async {
    try {
      DatabaseEvent event = await _dbRef.once();
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.exists) {
        Map<dynamic, dynamic>? users = snapshot.value as Map<dynamic, dynamic>?;
        Account? foundUser;
        users!.forEach((key, value) {
          if (value['phone_number'] == phoneNumber) {
            Map<String, dynamic> userData =
                Map<String, dynamic>.from(value as Map);
            foundUser = Account.fromMap(key, userData);
          }
        });

        if (foundUser != null) {
          // Mengembalikan objek Account jika ditemukan
          currentAccount = foundUser;
          return foundUser;
        } else {
          print('Akun dengan nomor $phoneNumber tidak ditemukan.');
          return null;
        }
      } else {
        print('Tidak ada akun ditemukan dengan nomor: $phoneNumber');
        return null;
      }
    } catch (e) {
      print('Terjadi kesalahan: $e');
      return null;
    }
  }

  Future<void> updateSaldo({
    required String saldo,
  }) async {
    try {
      final username = currentAccount!.username;
      final currentSaldo = currentAccount!.saldo;
      // Convert String to int
      final saldoInt = int.parse(saldo);
      final totalSaldo = currentSaldo + saldoInt;
      await _dbRef.child(username).update({'saldo': totalSaldo});
      Get.snackbar('Success', 'Saldo updated successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
