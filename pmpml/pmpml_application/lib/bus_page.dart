

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:async';
import 'dart:math';
import 'choose_color_page.dart';

class BusPassPage extends StatefulWidget {
  final Color backgroundColor;
  final Function(Color) onColorChange;

  const BusPassPage({Key? key, required this.backgroundColor, required this.onColorChange}) : super(key: key);

  @override
  State<BusPassPage> createState() => _BusPassPageState();
}

class _BusPassPageState extends State<BusPassPage>
    with SingleTickerProviderStateMixin {
  late String _qrData;
  late DateTime _currentDate;
  late DateTime _bookingTime;
  late DateTime _validityTime;
  late Timer _timer;
  Duration _remainingTime = Duration.zero;

  late AnimationController _zoomController;
  late Animation<double> _zoomAnimation;

  @override
  void initState() {
    super.initState();
    _initializePassData();
    _startCountdownTimer();

    // Zoom animation: you can adjust begin < 1.0 for very small after zoom-out, and end > 1.0 for zoom-in
    _zoomController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _zoomAnimation = Tween<double>(
      begin: 0.2,   // start at 0.8× size (you can set this to e.g., 0.5 if you want even smaller)
      end: 1.0,   // maximum zoom size
    ).animate(
      CurvedAnimation(
        parent: _zoomController,
        curve: Curves.linear,
      ),
    );
  }

  void _initializePassData() {
    _currentDate = DateTime.now();
    final random = Random();
    int randomMinute = random.nextInt(60);

    _bookingTime = DateTime(
        _currentDate.year, _currentDate.month, _currentDate.day, 7, randomMinute);
    _validityTime =
        DateTime(_currentDate.year, _currentDate.month, _currentDate.day, 23, 59);

    String dateStr =
        '${_currentDate.year.toString().substring(2)}${_two(_currentDate.month)}${_two(_currentDate.day)}';
    String timeStr = '07${_two(randomMinute)}';
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    String randomPart = '';
    for (int i = 0; i < 6; i++) {
      randomPart += chars[random.nextInt(chars.length)];
    }
    _qrData = '$dateStr$timeStr$randomPart';
  }

  void _startCountdownTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _remainingTime = _validityTime.difference(DateTime.now());
        if (_remainingTime.isNegative) {
          _remainingTime = Duration.zero;
          _timer.cancel();
        }
      });
    });
  }

  String _two(int n) => n.toString().padLeft(2, '0');
  String _month(int m) => const [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ][m - 1];

  String _fmtTime(DateTime t) {
    final h = t.hour == 0 ? 12 : (t.hour > 12 ? t.hour - 12 : t.hour);
    final m = _two(t.minute);
    final p = t.hour >= 12 ? 'PM' : 'AM';
    return '$h:$m $p';
  }

  String _fmt(DateTime d) =>
      '${d.day} ${_month(d.month)}, ${d.year.toString().substring(2)} | ${_fmtTime(d)}';

  @override
  void dispose() {
    _timer.cancel();
    _zoomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bg = widget.backgroundColor;
    final size = MediaQuery.of(context).size;
    final cardWidth = size.width * 0.9;
    final cardHeight = cardWidth * 1.18 + 180;

    // Fine-tuned values
    const double halfCutSize = 28.0;
    const double halfCutTopOffset = 117.0; // slightly lower for perfect alignment
    const double bookingValidityDown = 28.0;
    const double oneDayPassDown = 18.0;

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const SizedBox.shrink(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'Need Help?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChooseColorPage(
                          onColorSelected: widget.onColorChange,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'All passes',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: cardWidth,
                    height: cardHeight,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Colors.grey.shade300),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 8,
                            offset: const Offset(0, 3))
                      ],
                    ),
                    child: Column(
                      children: [
                        // Marathi Header
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: const BoxDecoration(
                            color: Color(0xFFD32F2F),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(18),
                                topRight: Radius.circular(18)),
                          ),
                          child: const Text(
                            'पुणे महानगर परिवहन महामंडळ लि.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Column(
                            children: [
                              // Pass Type / ID / Fare
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const _InfoColumn(
                                    title: 'Pass Type',
                                    value: 'PMC & PCMC',
                                    valueStyle: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16,
                                        color: Colors.black),
                                  ),
                                  const _InfoColumn(
                                    title: 'ID',
                                    value: '8034',
                                    valueStyle: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 18,
                                        color: Colors.black),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('Fare',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12)),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text('₹70.8',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 18,
                                                  color: Colors.black)),
                                          Transform.translate(
                                            offset: Offset(-32, 20),
                                            child: Text(
                                              '3',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 18,
                                                color: Colors.black,
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),

                              const SizedBox(height: bookingValidityDown),

                              // Clean dashed line across single set of half-circles
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Center(
                                    child: LayoutBuilder(
                                      builder: (context, constraints) {
                                        const dashW = 8.0;
                                        const dashS = 6.0;
                                        final count =
                                            (constraints.maxWidth /
                                                    (dashW + dashS))
                                                .floor();
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: List.generate(count, (_) {
                                            return Container(
                                              width: dashW,
                                              height: 2,
                                              color: const Color(0xFFD0D0D0),
                                            );
                                          }),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 14),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _InfoColumn(
                                      title: 'Booking Time',
                                      value: _fmt(_bookingTime)),
                                  _InfoColumn(
                                      title: 'Validity Time',
                                      value: _fmt(_validityTime)),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 10),
                        Text(_qrData,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.grey)),
                        SizedBox(height: oneDayPassDown),

                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Center(
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  const dashW = 8.0;
                                  const dashS = 6.0;
                                  final count =
                                      (constraints.maxWidth /
                                              (dashW + dashS))
                                          .floor();
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: List.generate(count, (_) {
                                      return Container(
                                        width: dashW,
                                        height: 2,
                                        color: const Color(0xFFD0D0D0),
                                      );
                                    }),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),

                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          color: const Color(0xFFD32F2F),
                          child: const Text(
                            'One Day Pass',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        ),

                        const SizedBox(height: 25),

                        // Animated image with zoom in/out effect
                        ScaleTransition(
                          scale: _zoomAnimation,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: Image.asset(
                              'assets/images/image2.png',
                              height: 195,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),

                        const Spacer(),

                        Text(
                          _remainingTime.isNegative
                              ? 'Expired'
                              : 'Expires in ${_formatDuration(_remainingTime)}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),

                  // ONE CLEAN pair of small half-cuts aligned with dashed line
                  Positioned(
                     left: -halfCutSize / 2,
                     top: halfCutTopOffset,
                     child: Container(
                       width: halfCutSize,
                       height: halfCutSize,
                       decoration: BoxDecoration(
                           color: bg, shape: BoxShape.circle),
                     ),
                   ),
                   Positioned(
                     right: -halfCutSize / 2,
                     top: halfCutTopOffset,
                     child: Container(
                       width: halfCutSize,
                       height: halfCutSize,
                       decoration: BoxDecoration(
                           color: bg, shape: BoxShape.circle),
                     ),
                   ),
                ],
              ),

              const SizedBox(height: 20),

              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Scan QR Code'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.green.shade900, width: 2.5),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: QrImageView(
                              data: _qrData,
                              version: QrVersions.auto,
                              size: 180,
                              backgroundColor: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Please show this code for validation',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          )
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Close'),
                        )
                      ],
                    ),
                  );
                },
                child: Container(
                  width: cardWidth,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDFF5D8),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.green.shade700),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.qr_code_2_rounded, color: Colors.green),
                      SizedBox(width: 8),
                      Text(
                        'Show QR code',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDuration(Duration d) {
    final h = d.inHours.toString().padLeft(2, '0');
    final m = (d.inMinutes % 60).toString().padLeft(2, '0');
    final s = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$h:$m:$s';
  }
}

class _InfoColumn extends StatelessWidget {
  final String title;
  final String value;
  final TextStyle? valueStyle;

  const _InfoColumn({required this.title, required this.value, this.valueStyle});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      const SizedBox(height: 4),
      Text(value,
          style: valueStyle ??
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
    ]);
  }
}
