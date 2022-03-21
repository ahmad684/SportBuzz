import 'package:flutter/material.dart';
class Spectator extends StatefulWidget {
  const Spectator({Key? key}) : super(key: key);

  @override
  State<Spectator> createState() => _SpectatorState();
}

class _SpectatorState extends State<Spectator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spectator'),
      ),
    );
  }
}
