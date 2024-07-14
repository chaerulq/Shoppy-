import 'package:flutter/material.dart';

class QFutureBuilder<T> extends StatelessWidget {
  final Future<T> future;
  final Widget Function() loading;
  final Widget Function(dynamic error) error;
  final Widget Function(T data) data;

  const QFutureBuilder({
    super.key,
    required this.future,
    required this.loading,
    required this.error,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loading();
        } else if (snapshot.hasError) {
          return error(snapshot.error);
        } else if (snapshot.hasData) {
          return data(snapshot.data!);
        } else {
          return Container(); // Return an empty container if none of the above conditions are met
        }
      },
    );
  }
}

// Cara menggunakan QFutureBuilder dalam sebuah widget
class ExampleWidget extends StatelessWidget {
  final Future<String> _sampleFuture = Future.delayed(
    const Duration(seconds: 2),
    () => 'Hello, Future!',
  );

  ExampleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QFutureBuilder Example')),
      body: Center(
        child: QFutureBuilder<String>(
          future: _sampleFuture,
          loading: () => const CircularProgressIndicator(),
          error: (err) => Text('Error: $err'),
          data: (data) => Text(data),
        ),
      ),
    );
  }
}
