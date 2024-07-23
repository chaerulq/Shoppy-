import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shoppy/app/utils/color.dart';

class PinCodeWidget extends StatefulWidget {
  final Function(String) onPinEntered; // Tambahkan callback untuk PIN

  const PinCodeWidget({super.key, required this.onPinEntered});

  @override
  State<PinCodeWidget> createState() => _PinCodeWidgetState();
}

class _PinCodeWidgetState extends State<PinCodeWidget> {
  String enteredPin = '';
  bool isPinVisible = false;

  /// Widget untuk setiap digit
  Widget numButton(int number) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              if (enteredPin.length < 6) {
                enteredPin += number.toString();
                if (enteredPin.length == 6) {
                  // Panggil callback saat PIN lengkap
                  widget.onPinEntered(enteredPin);
                  print(enteredPin);
                }
              }
            });
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(2), // Membuat tombol sedikit melengkung
            ),
            backgroundColor: Colors.white, // Warna tombol
          ),
          child: Text(
            number.toString(),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        const Center(
          child: Text(
            'Masukkan PIN Shoppy Anda',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 20),

        /// Area kode pin
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            6,
            (index) {
              return Container(
                margin: const EdgeInsets.all(6.0),
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: index < enteredPin.length
                      ? greenColor2
                      : Colors.grey[300],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),

        /// Lupa PIN
        TextButton(
          onPressed: () {
            // Lupa PIN action
          },
          child: const Text(
            'Lupa PIN Shoppy?',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 5),

        /// Digit dan tombol hapus
        Container(
          color: Colors.black26,
          child: Column(
            children: [
              const SizedBox(height: 5),

              /// Digit
              for (var i = 0; i < 3; i++)
                Row(
                  children: List.generate(
                    3,
                    (index) => numButton(1 + 3 * i + index),
                  ).toList(),
                ),

              /// Digit 0 dengan tombol hapus
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Spacer(),
                  numButton(0),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(
                            () {
                              if (enteredPin.isNotEmpty) {
                                enteredPin = enteredPin.substring(
                                    0, enteredPin.length - 1);
                              }
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              2,
                            ), // Membuat tombol sedikit melengkung
                          ),
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ),
                        child: const Icon(
                          Icons.backspace_outlined,
                          color: Colors.black,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.security_outlined,
                    size: 14,
                    color: Colors.grey[700],
                  ),
                  const SizedBox(width: 1),
                  Text(
                    "Shoppy Dual Verification",
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 13,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
