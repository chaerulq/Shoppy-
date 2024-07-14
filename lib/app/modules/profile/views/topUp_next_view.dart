import 'package:flutter/material.dart';
import 'package:shoppy/app/data/models/account_model.dart';

class TopUpNextView extends StatelessWidget {
  final Account account;

  const TopUpNextView({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nama: ${account.name}'),
            Text('PIN: ${account.pin}'),
            Text('Saldo: ${account.saldo}'),
            Text('uID: ${account.uID}'),
          ],
        ),
      ),
    );
  }
}
