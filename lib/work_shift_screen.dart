import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WorkShiftScreen extends StatefulWidget {
  const WorkShiftScreen({super.key});

  @override
  State<WorkShiftScreen> createState() => _WorkShiftScreenState();
}

class _WorkShiftScreenState extends State<WorkShiftScreen> {
  bool _showPopupMenu = false;
  final List<Map<String, dynamic>> weekDays = [
    {'day': '25', 'weekday': 'Thứ 2', 'isSelected': false},
    {'day': '26', 'weekday': 'Thứ 3', 'isSelected': true},
    {'day': '27', 'weekday': 'Thứ 4', 'isSelected': false},
    {'day': '28', 'weekday': 'Thứ 5', 'isSelected': false},
    {'day': '29', 'weekday': 'Thứ 6', 'isSelected': false},
    {'day': '30', 'weekday': 'Thứ 7', 'isSelected': false},
    {'day': '1', 'weekday': 'CN', 'isSelected': false},
    {'day': '2', 'weekday': 'Thứ 2', 'isSelected': false},
    {'day': '3', 'weekday': 'Thứ 3', 'isSelected': false},
    {'day': '4', 'weekday': 'Thứ 4', 'isSelected': false},
    {'day': '5', 'weekday': 'Thứ 5', 'isSelected': false},
    {'day': '6', 'weekday': 'Thứ 6', 'isSelected': false},
    {'day': '7', 'weekday': 'Thứ 7', 'isSelected': false},
    {'day': '8', 'weekday': 'CN', 'isSelected': false},
  ];

  final List<Map<String, dynamic>> timeSlots = [
    {'time': '07:00', 'status': 'free'},
    {'time': '08:00', 'status': 'free'},
    {'time': '09:00', 'status': 'working'}, // Bắt đầu ca sáng
    {'time': '10:00', 'status': 'working'},
    {'time': '11:00', 'status': 'working'},
    {'time': '12:00', 'status': 'working'}, // Ca sáng tiếp tục
    {'time': '13:00', 'status': 'break'}, // Kết thúc ca sáng, bắt đầu nghỉ
    {'time': '14:00', 'status': 'working'}, // Bắt đầu ca chiều
    {'time': '15:00', 'status': 'working'},
    {'time': '16:00', 'status': 'working'},
    {'time': '17:00', 'status': 'working'}, // Kết thúc ca chiều
    {'time': '18:00', 'status': 'free'},
    {'time': '19:00', 'status': 'free'},
    {'time': '20:00', 'status': 'free'},
    {'time': '21:00', 'status': 'free'},
    {'time': '22:00', 'status': 'free'},
  ];

  final List<Map<String, dynamic>> activities = [
    {
      'title': 'Check-in',
      'date': '05/04/2025',
      'time': '7:30',
      'status': 'Đúng giờ',
      'statusColor': const Color(0xFF12B669),
    },
    {
      'title': 'Check-out',
      'date': '04/04/2025',
      'time': '13:30',
      'status': 'Đúng giờ',
      'statusColor': const Color(0xFF12B669),
    },
    {
      'title': 'Check-in',
      'date': '04/04/2025',
      'time': '7:50',
      'status': 'Trễ 10 phút',
      'statusColor': const Color(0xFFF04437),
    },
    {
      'title': 'Đăng ký ca',
      'date': '04/04/2025',
      'time': '7:50',
      'status': 'Chờ duyệt',
      'statusColor': const Color(0xFFF79009),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // Status Bar
                _buildStatusBar(),
                
                // Header
                _buildHeader(),
                
                // Main Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        
                        // Today's Shift Card
                        _buildTodayShiftCard(),
                        
                        const SizedBox(height: 16),
                        
                        // Register Shift Button
                        _buildRegisterButton(),
                        
                        const SizedBox(height: 16),
                        
                        // Action Buttons
                        _buildActionButtons(),
                        
                        const SizedBox(height: 24),
                        
                        // Week Calendar and Schedule Timeline combined
                        _buildWeekCalendarAndSchedule(),
                        
                        const SizedBox(height: 24),
                        
                        // Legend/Hint Section (moved to top)
                        _buildLegendSection(),
                        
                        const SizedBox(height: 16),
                        
                        // Recent Activities
                        _buildRecentActivities(),
                        
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Popup Menu Overlay
            if (_showPopupMenu) 
              GestureDetector(
                onTap: () {
                  setState(() {
                    _showPopupMenu = false;
                  });
                },
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black.withOpacity(0.3),
                  child: _buildPopupMenu(),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildStatusBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            '08:15',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF111927),
              letterSpacing: -0.30,
            ),
          ),
          Row(
            children: [
              const Icon(Icons.signal_cellular_4_bar, size: 16, color: Color(0xFF111927)),
              const SizedBox(width: 4),
              const Icon(Icons.wifi, size: 16, color: Color(0xFF111927)),
              const SizedBox(width: 4),
              Container(
                width: 22,
                height: 11.33,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black.withOpacity(0.35)),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Container(
                  margin: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Image.asset(
              'images/back.png',
              width: 24,
              height: 24,
              color: const Color(0xFF111927),
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.arrow_back,
                  size: 24,
                  color: Color(0xFF111927),
                );
              },
            ),
          ),
          const Expanded(
            child: Center(
              child: Text(
                'Ca làm việc',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF111927),
                ),
              ),
            ),
          ),
          const Icon(
            Icons.info_outline,
            size: 24,
            color: Color(0xFF111927),
          ),
        ],
      ),
    );
  }

  Widget _buildTodayShiftCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        shadows: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // First row: Icon + "Hôm nay" + Countdown
          Container(
            width: double.infinity,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon "Hôm nay"
                Container(
                  width: 20,
                  height: 20,
                  child: Image.asset(
                    'images/homnay.png',
                    width: 20,
                    height: 20,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                          color: Color(0xFF21D4D4),
                          shape: BoxShape.circle,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 4),
                // "Hôm nay" text
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hôm nay',
                        style: TextStyle(
                          color: const Color(0xFF111927),
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w600,
                          height: 1.40,
                        ),
                      ),
                    ],
                  ),
                ),
                // Countdown container
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10000),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '07:59:30',
                        style: TextStyle(
                          color: const Color(0xFFF79009),
                          fontSize: 12,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.50,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'nữa là đến ca',
                        style: TextStyle(
                          color: const Color(0xFF111927),
                          fontSize: 12,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.50,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Second row: Time range + Duration + Shift count
          Container(
            width: double.infinity,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '09:00 AM - 05:00 PM',
                  style: TextStyle(
                    color: const Color(0xFF111927),
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.50,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '08:00',
                        style: TextStyle(
                          color: const Color(0xFF111927),
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.50,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '1 ',
                              style: TextStyle(
                                color: const Color(0xFF111927),
                                fontSize: 16,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                letterSpacing: -0.50,
                              ),
                            ),
                            TextSpan(
                              text: 'ca',
                              style: TextStyle(
                                color: const Color(0xFF8C9BB0),
                                fontSize: 16,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                letterSpacing: -0.50,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterButton() {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFF21D4D4),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'images/dangkyca.png',
              width: 16,
              height: 16,
              color: Colors.white,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.calendar_today,
                  color: Colors.white,
                  size: 16,
                );
              },
            ),
            const SizedBox(width: 8),
            const Text(
              'Đăng ký ca làm',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFF79009)),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/bosungcong.png',
                  width: 20,
                  height: 20,
                  color: const Color(0xFFF79009),
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.add, color: Color(0xFFF79009), size: 20);
                  },
                ),
                const SizedBox(width: 8),
                const Text(
                  'Bổ sung công',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFF79009),
                    height: 1.43,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFF95555)),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/xinnghiphep.png',
                  width: 20,
                  height: 20,
                  color: const Color(0xFFF95555),
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.event_busy, color: Color(0xFFF95555), size: 20);
                  },
                ),
                const SizedBox(width: 8),
                const Text(
                  'Xin nghỉ phép',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFF95555),
                    height: 1.43,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWeekCalendarAndSchedule() {
    const double slotHeight = 42.83;
    const double columnWidth = 50.0; // Fixed width for each day column
    const double timeColumnWidth = 86.0; // Match time column width exactly
    
    return Column(
      children: [
        // Header row: Month selector + Week days (scrollable)
        SizedBox(
          height: 60,
          child: Row(
            children: [
              // Month selector (fixed) - exact same width as time column
              Container(
                width: timeColumnWidth, // Match time column width exactly
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: const Color(0xFFF8F8FB),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 52,
                      child: Text(
                        'Tháng 05',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF111927),
                          fontSize: 12,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w600,
                          height: 1.50,
                        ),
                      ),
                    ),
                    const SizedBox(width: 2),
                    Container(
                      width: 24,
                      height: 24,
                      child: const Icon(Icons.keyboard_arrow_down, size: 16),
                    ),
                  ],
                ),
              ),
              // Week days (scrollable) - NO spacing between month selector and days
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: weekDays.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, dynamic> day = entry.value;
                      return Container(
                        width: columnWidth + 1, // Add 1px for border to match schedule columns exactly
                        height: 60,
                        margin: EdgeInsets.zero, // Remove all margins
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: day['isSelected'] 
                              ? const Color(0xFF21D4D4) 
                              : const Color(0xFFF8F8FB),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              day['day'],
                              style: TextStyle(
                                color: day['isSelected'] 
                                    ? Colors.white 
                                    : const Color(0xFF111927),
                                fontSize: 16,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              day['weekday'],
                              style: TextStyle(
                                color: day['isSelected'] 
                                    ? Colors.white.withOpacity(0.8) 
                                    : const Color(0xFF8C9BB0),
                                fontSize: 11,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Schedule Timeline
        Container(
          width: double.infinity,
          height: 685,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Time column (fixed) - exact same width as month selector
              Container(
                width: timeColumnWidth, // Match month selector width exactly
                decoration: const BoxDecoration(
                  color: Color(0xFFF8F8FB),
                  border: Border(
                    right: BorderSide(
                      color: Color(0xFFD9D9D9),
                      width: 0.5,
                    ),
                  ),
                ),
                child: Column(
                  children: timeSlots.map((slot) => Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xFFD9D9D9),
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          slot['time'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF111927),
                            height: 1.50,
                          ),
                        ),
                      ),
                    ),
                  )).toList(),
                ),
              ),
              // Schedule columns (scrollable) - exact same width and spacing as header days
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      // Day 25 - Ca sáng
                      _buildScheduleColumn(
                        columnWidth + 1, // Match header day width exactly (including border)
                        [
                          _buildShiftBlock(
                            top: (685 / 16) * 2, // Start at 9AM
                            height: 210,
                            color: const Color(0xFFFEFBE8),
                            borderColor: const Color(0xFFEAA907),
                            title: 'Ca sáng',
                            duration: '04:00',
                          ),
                        ],
                      ),
                      // Day 26 - Ca trưa
                      _buildScheduleColumn(
                        columnWidth + 1,
                        [
                          _buildShiftBlock(
                            top: (685 / 16) * 5, // Start at 12PM
                            height: 252, // Updated to match layercatrua.txt design
                            color: const Color(0xFFFEE7E7),
                            borderColor: const Color(0xFFF53D68),
                            title: 'Ca trưa',
                            duration: '05:00', // Updated to match layercatrua.txt design
                          ),
                        ],
                      ),
                      // Day 27 - Ca trưa extended
                      _buildScheduleColumn(
                        columnWidth + 1,
                        [
                          _buildShiftBlock(
                            top: (685 / 16) * 8, // Start at 3PM
                            height: 252,
                            color: const Color(0xFFFEE7E7),
                            borderColor: const Color(0xFFF53D68),
                            title: 'Ca trưa',
                            duration: '05:00',
                          ),
                        ],
                      ),
                      // Day 28 - Ca sáng
                      _buildScheduleColumn(
                        columnWidth + 1,
                        [
                          _buildShiftBlock(
                            top: 0, // Start at 7AM
                            height: 210,
                            color: const Color(0xFFFEFBE8),
                            borderColor: const Color(0xFFEAA907),
                            title: 'Ca sáng',
                            duration: '04:00',
                          ),
                        ],
                      ),
                      // Day 29 - Ca tối
                      _buildScheduleColumn(
                        columnWidth + 1,
                        [
                          _buildShiftBlock(
                            top: (685 / 16) * 8, // Start at 3PM
                            height: 210,
                            color: const Color(0xFFEEE8FE),
                            borderColor: const Color(0xFF7959F8),
                            title: 'Ca tối',
                            duration: '04:00',
                          ),
                        ],
                      ),
                      // Day 30 - Empty
                      _buildScheduleColumn(columnWidth + 1, []),
                      // Day 1 - Empty
                      _buildScheduleColumn(columnWidth + 1, []),
                      // Day 2 - Empty
                      _buildScheduleColumn(columnWidth + 1, []),
                      // Day 3 - Empty
                      _buildScheduleColumn(columnWidth + 1, []),
                      // Day 4 - Empty
                      _buildScheduleColumn(columnWidth + 1, []),
                      // Day 5 - Empty
                      _buildScheduleColumn(columnWidth + 1, []),
                      // Day 6 - Empty
                      _buildScheduleColumn(columnWidth + 1, []),
                      // Day 7 - Empty
                      _buildScheduleColumn(columnWidth + 1, []),
                      // Day 8 - Empty
                      _buildScheduleColumn(columnWidth + 1, []),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildScheduleColumn(double width, List<Widget> shifts) {
    return Container(
      width: width,
      decoration: const BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Color(0xFFEAECF0),
            width: 1,
          ),
        ),
      ),
      child: Stack(
        children: [
          // Background empty slots
          Column(
            children: timeSlots.map((slot) => Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFF8F8FB),
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xFFD9D9D9),
                      width: 0.5,
                    ),
                  ),
                ),
              ),
            )).toList(),
          ),
          // Shift blocks
          ...shifts,
        ],
      ),
    );
  }

  Widget _buildShiftBlock({
    required double top,
    required double height,
    required Color color,
    required Color borderColor,
    required String title,
    required String duration,
  }) {
    // Determine which icon to use based on shift title
    String iconPath = '';
    switch (title) {
      case 'Ca sáng':
        iconPath = 'images/casang.png';
        break;
      case 'Ca trưa':
        iconPath = 'images/catrua.png';
        break;
      case 'Ca tối':
        iconPath = 'images/catoi.png';
        break;
    }

    // Handle special case for Ca tối with wrapper structure
    if (title == 'Ca tối') {
      return Positioned(
        top: top,
        left: 0,
        right: 0,
        child: GestureDetector(
          onTap: () {
            setState(() {
              _showPopupMenu = !_showPopupMenu;
            });
          },
          child: Container(
            width: double.infinity,
            height: height,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: height,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEE8FE),
                    border: Border(
                      top: BorderSide(
                        width: 3, // Thicker top border like in Figma
                        color: const Color(0xFF7959F8),
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Icon at the very top
                      Container(
                        width: 20,
                        height: 20,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(),
                        child: iconPath.isNotEmpty
                            ? Image.asset(
                                iconPath,
                                width: 20,
                                height: 20,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF7959F8).withOpacity(0.3),
                                      shape: BoxShape.circle,
                                    ),
                                  );
                                },
                              )
                            : Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF7959F8).withOpacity(0.3),
                                  shape: BoxShape.circle,
                                ),
                              ),
                      ),
                      const SizedBox(height: 8),
                      // Title - BOLD like in Figma
                      Text(
                        'Ca tối',
                        style: const TextStyle(
                          color: Color(0xFF111826),
                          fontSize: 12,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700, // Bold like in Figma
                          height: 1.50,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Duration
                      Text(
                        '04:00',
                        style: const TextStyle(
                          color: Color(0xFF8C9BB0),
                          fontSize: 12,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          height: 1.50,
                        ),
                      ),
                      // Spacer to push content to top, rest is background color
                      const Spacer(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // For Ca sáng and Ca trưa - only top border, bold text
    return Positioned(
      top: top,
      left: 0,
      right: 0,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _showPopupMenu = !_showPopupMenu;
          });
        },
        child: Container(
          width: double.infinity,
          height: height,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: color,
            border: Border(
              top: BorderSide(
                width: 3, // Thicker top border like in Figma
                color: borderColor,
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon at the very top
              Container(
                width: 20,
                height: 20,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(),
                child: iconPath.isNotEmpty
                    ? Image.asset(
                        iconPath,
                        width: 20,
                        height: 20,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: borderColor.withOpacity(0.3),
                              shape: BoxShape.circle,
                            ),
                          );
                        },
                      )
                    : Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: borderColor.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                      ),
              ),
              const SizedBox(height: 8),
              // Title - BOLD like in Figma
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF111826),
                  fontSize: 12,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700, // Bold like in Figma
                  height: 1.50,
                ),
              ),
              const SizedBox(height: 8),
              // Duration
              Text(
                duration,
                style: const TextStyle(
                  color: Color(0xFF8C9BB0),
                  fontSize: 12,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  height: 1.50,
                ),
              ),
              // Spacer to push content to top, rest is background color
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentActivities() {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Header with title and arrow icon
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Hoạt động gần đây',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF111927),
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    height: 1.25,
                  ),
                ),
                Container(
                  width: 24,
                  height: 24,
                  child: Image.asset(
                    'images/hoatdongganday.png',
                    width: 24,
                    height: 24,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.arrow_forward,
                        size: 24,
                        color: Color(0xFF111927),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // Activities list
          Container(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Check-in - Đúng giờ
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Check-in',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF111826),
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              height: 1.43,
                            ),
                          ),
                          const SizedBox(height: 4),
                          SizedBox(
                            width: 100,
                            child: Text(
                              '05/04/2025',
                              style: TextStyle(
                                color: Color(0xFF8C9BB0),
                                fontSize: 12,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                height: 1.50,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            '7:30',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF111826),
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                              height: 1.43,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text(
                              'Đúng giờ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF12B669),
                                fontSize: 12,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                height: 1.50,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Check-out - Đúng giờ
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Check-out',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF111826),
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              height: 1.43,
                            ),
                          ),
                          const SizedBox(height: 4),
                          SizedBox(
                            width: 100,
                            child: Text(
                              '04/04/2025',
                              style: TextStyle(
                                color: Color(0xFF8C9BB0),
                                fontSize: 12,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                height: 1.50,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            '13:30',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF111826),
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                              height: 1.43,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text(
                              'Đúng giờ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF12B669),
                                fontSize: 12,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                height: 1.50,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Check-in - Trễ 10 phút
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Check-in',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF111826),
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              height: 1.43,
                            ),
                          ),
                          const SizedBox(height: 4),
                          SizedBox(
                            width: 100,
                            child: Text(
                              '04/04/2025',
                              style: TextStyle(
                                color: Color(0xFF8C9BB0),
                                fontSize: 12,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                height: 1.50,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            '7:50',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF111826),
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                              height: 1.43,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text(
                              'Trễ 10 phút',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFFF04437),
                                fontSize: 12,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                height: 1.50,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Đăng ký ca - Chờ duyệt
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Đăng ký ca',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF111826),
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              height: 1.43,
                            ),
                          ),
                          const SizedBox(height: 4),
                          SizedBox(
                            width: 100,
                            child: Text(
                              '04/04/2025',
                              style: TextStyle(
                                color: Color(0xFF8C9BB0),
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 1.50,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            '7:50',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF111826),
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              height: 1.43,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                child: Image.asset(
                                  'images/choduyet.png',
                                  width: 16,
                                  height: 16,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(
                                      Icons.warning,
                                      size: 16,
                                      color: Color(0xFFF79009),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                'Chờ duyệt',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFFF79009),
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  height: 1.50,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendSection() {
    return Container(
      width: double.infinity,
      height: 34,
      child: Container(
        decoration: ShapeDecoration(
          color: const Color(0xFFFEFBE8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              child: Container(
                width: 18,
                height: 18,
                child: Image.asset(
                  'images/nhanvaocadexemtuychon.png',
                  width: 18,
                  height: 18,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.warning,
                      color: Color(0xFFF78F08),
                      size: 18,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 6),
            const Text(
              'Nhấn vào ca để xem tuỳ chọn',
              style: TextStyle(
                color: Color(0xFFF79009),
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopupMenu() {
    return Center(
      child: GestureDetector(
        onTap: () {}, // Prevent click through
        child: Container(
          width: 200,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0x19000000),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildMenuItemWithIcon('Đổi ca', 'images/doica.png', const Color(0xFF3B82F6)),
              const SizedBox(height: 16),
              _buildMenuItemWithIcon('Xin đi trễ', 'images/xinditre.png', const Color(0xFFF59E0B)),
              const SizedBox(height: 16),
              _buildMenuItemWithIcon('Xin về sớm', 'images/xinvesom.png', const Color(0xFFF59E0B)),
              const SizedBox(height: 16),
              _buildMenuItemWithIcon('Tăng ca', 'images/tangca.png', const Color(0xFF8B5CF6)),
              const SizedBox(height: 16),
              _buildMenuItemWithIcon('Xin nghỉ phép', 'images/xinnghiphepmodal.png', const Color(0xFFEF4444)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItemWithIcon(String title, String iconPath, Color iconColor) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showPopupMenu = false;
        });
        // Handle menu item tap
        _handleMenuItemTap(title);
      },
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            child: Image.asset(
              iconPath,
              width: 24,
              height: 24,
              fit: BoxFit.contain,
              color: iconColor,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Icon(
                    _getFallbackIconForMenuItem(title),
                    size: 16,
                    color: iconColor,
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF111927),
                height: 1.43,
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getFallbackIconForMenuItem(String title) {
    switch (title) {
      case 'Đổi ca':
        return Icons.swap_horiz;
      case 'Xin đi trễ':
        return Icons.schedule;
      case 'Xin về sớm':
        return Icons.access_time;
      case 'Tăng ca':
        return Icons.add_circle_outline;
      case 'Xin nghỉ phép':
        return Icons.event_busy;
      default:
        return Icons.work;
    }
  }

  void _handleMenuItemTap(String title) {
    // Handle different menu actions
    print('Selected: $title');
    // You can add navigation or show dialogs here
    switch (title) {
      case 'Đổi ca':
        // Handle shift change
        break;
      case 'Xin đi trễ':
        // Handle late request
        break;
      case 'Xin về sớm':
        // Handle early leave request
        break;
      case 'Tăng ca':
        // Handle overtime request
        break;
      case 'Xin nghỉ phép':
        // Handle leave request
        break;
    }
  }

  Widget _buildBottomNavigation() {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        color: Color(0xFFFBFEFE),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x07000000),
            blurRadius: 24,
            offset: Offset(0, -5),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItemWithAsset('images/logo-timeso.png', 'Trang chủ', false),
          _buildNavItemWithAsset('images/Frame.png', 'Lịch ca', true),
          _buildNavItemWithAsset('images/Frame-1.png', 'Cộng đồng', false),
          _buildNavItemWithAsset('images/Frame-2.png', 'Trò chuyện', false),
          _buildNavItemWithAsset('images/Frame-3.png', 'Tài khoản', false),
        ],
      ),
    );
  }

  Widget _buildNavItemWithAsset(String iconPath, String label, bool isSelected) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            iconPath,
            width: 24,
            height: 24,
            color: isSelected ? const Color(0xFF21D4D4) : const Color(0xFF8C9BB0),
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                _getFallbackIcon(label),
                size: 24,
                color: isSelected ? const Color(0xFF21D4D4) : const Color(0xFF8C9BB0),
              );
            },
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected ? const Color(0xFF21D4D4) : const Color(0xFF8C9BB0),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getFallbackIcon(String label) {
    switch (label.toLowerCase()) {
      case 'trang chủ':
        return Icons.home;
      case 'lịch ca':
        return Icons.calendar_today;
      case 'cộng đồng':
        return Icons.people;
      case 'trò chuyện':
        return Icons.chat;
      case 'tài khoản':
        return Icons.person;
      default:
        return Icons.home;
    }
  }
}