import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shoppy/app/modules/cart/controllers/cart_controller.dart';
import 'package:web_socket_channel/io.dart';

class PaymentController extends GetxController {
  late IOWebSocketChannel channel;
  var uID = ''.obs;
  var isLoading = true.obs;
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

  Future<void> verifyUID() async {
    isLoading.value = true;
    if (uID.value.isNotEmpty) {
      DatabaseEvent event = await _dbRef.once();
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.exists) {
        Map<dynamic, dynamic>? users = snapshot.value as Map<dynamic, dynamic>?;
        await Future.forEach(users!.entries,
            (MapEntry<dynamic, dynamic> entry) async {
          dynamic value = entry.value;
          if (value['uID'] == uID.value) {
            Map<String, dynamic> userData =
                Map<String, dynamic>.from(value as Map);
            int currentSaldo = userData['saldo'] ?? 0;
            String keyUser = userData['username'];
            double price = cartController.totalPrice;
            if (currentSaldo > price) {
              double newSaldo = currentSaldo - price; // Mengurangi saldo
              await _dbRef.child(keyUser).update({
                'saldo': newSaldo,
              });
              statusMessage.value =
                  'Pembayaran berhasil. Saldo baru: $newSaldo';
            } else {
              statusMessage.value = 'Saldo tidak cukup';
            }
          } else {
            statusMessage.value = 'Kartu anda salah atau belum terdaftar';
          }
        });
      }
      isLoading.value = false;
    }
  }
}
