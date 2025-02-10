
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hexcolor/hexcolor.dart';

class VoiceNoteScreen extends StatefulWidget {
  const VoiceNoteScreen({super.key});

  @override
  _VoiceNoteScreenState createState() => _VoiceNoteScreenState();
}

class _VoiceNoteScreenState extends State<VoiceNoteScreen> {
  bool isRecording = false;
  Duration recordingDuration = Duration.zero;
  late final Ticker ticker;

  @override
  void initState() {
    super.initState();
    ticker = Ticker((_) {
      if (isRecording) {
        setState(() {
          recordingDuration += const Duration(seconds: 1);
        });
      }
    });
    ticker.start();
  }

  @override
  void dispose() {
    ticker.dispose();
    super.dispose();
  }

  void startRecording() {
    setState(() {
      isRecording = true;
      recordingDuration = Duration.zero;
    });
  }

  void stopRecording() {
    setState(() {
      isRecording = false;
    });
  }

  String get formattedDuration {
    final minutes = recordingDuration.inMinutes.toString().padLeft(2, '0');
    final seconds = (recordingDuration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes.m $seconds.s';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Voice Note Label
                Text(
                  'Voice Note',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: HexColor('#1DB954'),
                  ),
                ),
                const SizedBox(height: 20),

                // Waveform Placeholder
                Container(
                  height: 80,
                  width: double.infinity,
                  child: CustomPaint(
                    painter: WaveformPainter(),
                  ),
                ),
                const SizedBox(height: 20),

                // Recording Duration
                Text(
                  formattedDuration,
                  style: const TextStyle(fontSize: 24, color: Colors.black),
                ),
                const SizedBox(height: 20),

                // Controls (Stop and Send Icons)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close, size: 36, color: Colors.grey),
                      onPressed: stopRecording,
                    ),
                    const SizedBox(width: 40),
                    GestureDetector(
                      onTap: () {
                        if (isRecording) {
                          stopRecording();
                        } else {
                          startRecording();
                        }
                      },
                      child: Icon(
                        isRecording ? Icons.mic : Icons.mic_none,
                        size: 48,
                        color: HexColor('#1DB954'),
                      ),
                    ),
                    const SizedBox(width: 40),
                    IconButton(
                      icon: Icon(Icons.send, size: 36, color: HexColor('#1DB954')),
                      onPressed: () {
                        // Add send functionality here
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Custom painter for the waveform
class WaveformPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = HexColor('#1DB954')
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Simple waveform pattern (replace with real waveform if available)
    const waveHeight = 10.0;
    const waveSpacing = 5.0;
    for (double x = 0; x < size.width; x += waveSpacing) {
      final y = size.height / 2;
      canvas.drawLine(
        Offset(x, y - waveHeight),
        Offset(x, y + waveHeight),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
