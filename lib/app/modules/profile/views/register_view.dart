import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppy/app/utils/fancy_button.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../utils/alert_dialog.dart';
import '../../../utils/color.dart';
import '../controllers/account_controller.dart';
import 'package:flutter/services.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final AccountController accountController = Get.put(AccountController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController uIDController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phonenumberController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  WebSocketChannel? channel;
  bool _obscurePassword = true;
  bool isWebSocketConnected = false;

  @override
  void initState() {
    super.initState();
    connectWebSocket();
  }

  @override
  void dispose() {
    channel?.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Let's create your account",
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                    fontSize: 20,
                    color: ktextColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      expands: false,
                      decoration: InputDecoration(
                        labelText: "Name",
                        prefixIcon: const Icon(CupertinoIcons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: greyColor1,
                            width: 1.0,
                          ), // Warna border tetap
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Name';
                        } else if (value.length < 6) {
                          return 'Name should be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: usernameController,
                      expands: false,
                      decoration: InputDecoration(
                        labelText: "Username",
                        prefixIcon:
                            const Icon(CupertinoIcons.person_badge_plus),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: greyColor1,
                            width: 1.0,
                          ), // Warna border tetap
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        } else if (value.length < 6) {
                          return 'Username should be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: phonenumberController,
                      expands: false,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "Phone number",
                        prefixIcon: const Icon(CupertinoIcons.phone),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: greyColor1,
                            width: 1.0,
                          ), // Warna border tetap
                        ),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[+\d]')),
                        LengthLimitingTextInputFormatter(
                            12), // Batasi panjang nomor telepon
                        // PhoneNumberFormatter(),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: passwordController,
                      expands: false,
                      obscureText: _obscurePassword,
                      obscuringCharacter: '*',
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: const Icon(CupertinoIcons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? CupertinoIcons.eye_slash
                                : CupertinoIcons.eye,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: greyColor1,
                            width: 1.0,
                          ), // Warna border tetap
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 6) {
                          return 'Password should be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: pinController,
                            expands: false,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "PIN",
                              prefixIcon:
                                  const Icon(CupertinoIcons.lock_circle),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  color: greyColor1,
                                  width: 1.0,
                                ), // Warna border tetap
                              ),
                            ),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(6)
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your PIN';
                              } else if (value.length != 6) {
                                return 'PIN must be exactly 6 digits';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            controller: uIDController,
                            enabled: false,
                            decoration: InputDecoration(
                              labelText: "uID",
                              prefixIcon:
                                  const Icon(CupertinoIcons.barcode_viewfinder),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  color: greyColor1,
                                  width: 1.0,
                                ), // Warna border tetap
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please scan your ID card';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 35),
                    SizedBox(
                      width: double.infinity,
                      child: FancyButton(
                        borderRadius: 5,
                        color: greenColor2,
                        text: "Create Account",
                        onPressed: () {
                          _formKey.currentState!.validate();
                          _addAccount();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addAccount() {
    setState(() {
      if (_formKey.currentState?.validate() ?? false) {
        accountController.createAccount(
          name: nameController.text,
          username: usernameController.text,
          phoneNumber: phonenumberController.text,
          password: passwordController.text,
          pin: pinController.text,
          uID: uIDController.text,
        );
        Get.back();
      }
      FocusScope.of(context).unfocus(); // Hide keyboard
    });
  }

  void connectWebSocket() {
    try {
      channel = WebSocketChannel.connect(
        Uri.parse('ws://192.168.43.7:81/'), // Ganti dengan alamat IP ESP8266
      );
      channel?.stream.listen(
        (message) {
          print("Received message: $message"); // Log received message
          setState(() {
            uIDController.text = message;
            accountController.updateUID(message);
            isWebSocketConnected = true;
          });
        },
        onError: (error) {
          print("WebSocket error: $error");
          // Handle error appropriately, e.g., show a snackbar or dialog
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("WebSocket error: $error")),
          );
          setState(() {
            isWebSocketConnected = false;
          });
        },
        onDone: () {
          exit(1);
        },
      );
    } catch (e) {
      print("Error connecting to WebSocket: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error connecting to WebSocket: $e")),
      );
      setState(() {
        isWebSocketConnected = false;
      });
    }
  }

  void showAutoCloseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AutoCloseAlertDialog();
      },
    );
  }
}
