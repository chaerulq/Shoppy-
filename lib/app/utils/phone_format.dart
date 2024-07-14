import 'package:flutter/services.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text
        .replaceAll(RegExp(r'\D'), ''); // Menghilangkan karakter selain digit
    if (text.isNotEmpty && text[0] != '0') {
      text = '0' + text;
    } // Menambahkan '0' di awal nomor telepon

    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if ((i + 1) % 4 == 0 && i != text.length - 1) {
        buffer.write(' '); // Menambahkan spasi setiap 4 angka kecuali di akhir
      }
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}
