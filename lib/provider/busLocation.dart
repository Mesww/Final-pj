import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Bus {
  final int? id;
  final int? direction;
  final int? speed;
  final String? serverTime;
  final String? trackerTime;
  final String? position;

  const Bus({
    required this.id,
    required this.direction,
    required this.speed,
    required this.serverTime,
    required this.trackerTime,
    required this.position,
  });
}

const String bearerToken = 'k3wbpy57L4pVQC';

class BusLocation extends ChangeNotifier {
  List<Bus> _buses = [];
  WebSocketChannel? _channel;
  bool _isConnected = false;

  List<Bus> get buses => _buses;
  bool get isConnected => _isConnected;

  void connectToWebSocket() {
    if (_isConnected) return;

    final wsUrl = Uri.parse('wss://7a7b-58-10-0-103.ngrok-free.app');
    _channel = WebSocketChannel.connect(wsUrl);

    _channel!.stream.listen(
      (message) {
        _handleMessage(message);
      },
      onError: (error) {
        print('WebSocket error: $error');
        _isConnected = false;
        notifyListeners();
      },
      onDone: () {
        print('WebSocket connection closed');
        _isConnected = false;
        notifyListeners();
      },
    );

    _isConnected = true;
    notifyListeners();
  }

  void _handleMessage(String message) {
    var jsonData = jsonDecode(message);
    _buses.clear();
    for (var key in jsonData['data'].keys) {
      final eachData = jsonData['data'][key];
      final bus = Bus(
        id: int.tryParse(key),
        direction: eachData['direction'],
        speed: eachData['speed'],
        serverTime: eachData['server_time'],
        trackerTime: eachData['tracker_time'],
        position: eachData['position'],
      );
      _buses.add(bus);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _channel?.sink.close();
    _isConnected = false;
    super.dispose();
  }
}