import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:shoppy/app/modules/cart/controllers/cart_controller.dart';
import 'package:web_socket_channel/io.dart';

import '../../../utils/result_state.dart';

class PaymentController extends GetxController {
  var _state = ResultState.idle.obs;
  ResultState get state => _state.value;

  late IOWebSocketChannel channel;
  var uID = ''.obs;
  var isLoading = false.obs;
  var isPin = false.obs;
  var statusMessage = ''.obs;
  CartController cartController = Get.find<CartController>();
  final _dbRef = FirebaseDatabase.instance.ref('account');

  @override
  void onInit() {
    super.onInit();
    connectWebSocket();
  }

  @override
  void onClose() {
    channel.sink.close();
    super.onClose();
  }

  void connectWebSocket() {
    channel = IOWebSocketChannel.connect('ws://192.168.43.7:81/');
    channel.stream.listen((message) {
      uID.value = message;
      verifyUID();
    });
  }

  void startLoading() {
    isLoading.value = true;
    if (uID.value.isNotEmpty) {
      verifyUID();
    }
  }

  Future<void> verifyUID() async {
    if (uID.value.isNotEmpty) {
      try {
        print("object");
        DatabaseEvent event = await _dbRef.once();
        DataSnapshot snapshot = event.snapshot;
        if (snapshot.exists) {
          Map<dynamic, dynamic>? users =
              snapshot.value as Map<dynamic, dynamic>?;
          if (users != null) {
            for (var entry in users.entries) {
              dynamic value = entry.value;
              if (value['uID'] == uID.value) {
                isLoading.value = false;
                isPin.value = true;
                return; // UID ditemukan
              }
            }
            _state.value = ResultState.wrongCard;
            print('Kartu anda salah atau belum terdaftar');
          }
        }
      } catch (e) {
        print('Error saat verifikasi UID: $e');
      }
      isLoading.value = false;
    }
  }

  Future<void> verifyPIN(String enteredPin) async {
    if (uID.value.isNotEmpty) {
      try {
        DatabaseEvent event = await _dbRef.once();
        DataSnapshot snapshot = event.snapshot;
        if (snapshot.exists) {
          Map<dynamic, dynamic>? users =
              snapshot.value as Map<dynamic, dynamic>?;
          if (users != null) {
            for (var entry in users.entries) {
              dynamic value = entry.value;
              if (value['pin'] == enteredPin) {
                Map<String, dynamic> userData =
                    Map<String, dynamic>.from(value as Map);
                int currentSaldo = userData['saldo'] ?? 0;
                String keyUser = userData['username'];
                double price = cartController.totalPrice;
                if (currentSaldo >= price) {
                  double newSaldo = currentSaldo - price;
                  await _dbRef.child(keyUser).update({
                    'saldo': newSaldo,
                  });
                  isPin.value = false;
                  _state.value = ResultState.paymentSuccesful;
                } else {
                  isPin.value = false;
                  _state.value = ResultState.balanceIsLow;
                }
                return; // PIN valid
              }
            }
            isPin.value = false;
            _state.value = ResultState.wrongPin;
          }
        }
      } catch (e) {
        print('Error saat verifikasi PIN: $e');
      }
    }
  }

  void clearCall() {
    uID.value = '';
    isLoading.value = false;
    isPin.value = false;
    _state.value = ResultState.idle;
    statusMessage.value = '';
  }
}
