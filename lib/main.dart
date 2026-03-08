import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:math';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const HuzurluBahceApp());
}

class HuzurluBahceApp extends StatelessWidget {
  const HuzurluBahceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Huzurlu Bahçe',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xff09090b),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xff10b981),
          secondary: Color(0xff3b82f6),
          surface: Color(0xff18181b),
          background: Color(0xff09090b),
          onBackground: Color(0xfffafafa),
          onSurface: Color(0xfffafafa),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Color(0xfff4f4f5)),
          titleTextStyle: TextStyle(
            color: Color(0xfff4f4f5),
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        cardTheme: CardThemeData(
          color: const Color(0xff18181b),
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
              side: BorderSide(color: Colors.white.withOpacity(0.05))),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 0.5),
            foregroundColor: const Color(0xff09090b),
            backgroundColor: const Color(0xff10b981),
          ),
        ),
        fontFamily: 'Roboto',
      ),
      home: const MainMenuScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FrostedGlass extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  const FrostedGlass({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
    this.width,
    this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: const Color(0xff18181b).withOpacity(0.6),
        borderRadius: borderRadius ?? BorderRadius.circular(32),
        border: Border.all(color: Colors.white.withOpacity(0.08), width: 1),
        boxShadow: [
           BoxShadow(
             color: Colors.black.withOpacity(0.4),
             blurRadius: 24,
             offset: const Offset(0, 12),
           ),
        ],
      ),
      child: child,
    );
  }
}

class InteractiveCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final Color accentColor;

  const InteractiveCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    required this.accentColor,
  });

  @override
  State<InteractiveCard> createState() => _InteractiveCardState();
}

class _InteractiveCardState extends State<InteractiveCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(0, _isHovered ? -5 : 0, 0),
          decoration: BoxDecoration(
            color: const Color(0xff18181b),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: _isHovered ? widget.accentColor.withOpacity(0.5) : Colors.white.withOpacity(0.05),
              width: 1.5
            ),
            boxShadow: [
              if (_isHovered)
                BoxShadow(
                  color: widget.accentColor.withOpacity(0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                )
              else
                 BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _isHovered ? widget.accentColor.withOpacity(0.15) : const Color(0xff27272a),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(widget.icon, color: widget.accentColor, size: 28),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xfffafafa),
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.subtitle,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xffa1a1aa),
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedContainer(
                   duration: const Duration(milliseconds: 200),
                   transform: Matrix4.translationValues(_isHovered ? 5 : 0, 0, 0),
                   child: Icon(Icons.arrow_forward_rounded, color: _isHovered ? widget.accentColor : const Color(0xff52525b)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -150,
            right: -50,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xff10b981).withOpacity(0.15),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -100,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xff3b82f6).withOpacity(0.15),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
                  children: [
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                           color: const Color(0xff10b981).withOpacity(0.1),
                           borderRadius: BorderRadius.circular(24),
                        ),
                        child: const Icon(
                          Icons.all_inclusive_rounded,
                          size: 64,
                          color: Color(0xff10b981),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'Huzurlu Bahçe',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        color: Color(0xfff4f4f5),
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Gelişiminiz İçin Profesyonel Egzersizler',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Color(0xffa1a1aa)),
                    ),
                    const SizedBox(height: 48),
                    InteractiveCard(
                      title: 'Bilişsel Modül',
                      subtitle: 'Hafıza ve dikkat yoğunluklu çalışmalar',
                      icon: Icons.psychology_rounded,
                      accentColor: const Color(0xff3b82f6),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const CognitiveMenuScreen()),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    InteractiveCard(
                      title: 'Motor Modül',
                      subtitle: 'İnce motor ve koordinasyon gelişimleri',
                      icon: Icons.back_hand_rounded,
                      accentColor: const Color(0xfff59e0b),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MotorMenuScreen()),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    InteractiveCard(
                      title: 'Performans Analizi',
                      subtitle: 'İlerlemelerinizi anlık olarak gözlemleyin',
                      icon: Icons.query_stats_rounded,
                      accentColor: const Color(0xff10b981),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ProgressScreen()),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    InteractiveCard(
                      title: 'Başarı Kriterleri',
                      subtitle: 'Elde edilen yetkinlik derecelendirmeleri',
                      icon: Icons.military_tech_rounded,
                      accentColor: const Color(0xff8b5cf6),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AwardsScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CognitiveMenuScreen extends StatelessWidget {
  const CognitiveMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bilişsel Modül'),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: ListView(
              padding: const EdgeInsets.all(24.0),
              children: [
                const SizedBox(height: 16),
                InteractiveCard(
                  title: 'Hafıza Odaklanması',
                  subtitle: 'Sıralı nesne tanıma ve akılda tutma',
                  icon: Icons.memory_rounded,
                  accentColor: const Color(0xff3b82f6),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MemoryGameScreen()),
                    );
                  },
                ),
                const SizedBox(height: 16),
                InteractiveCard(
                  title: 'Dikkat Dağılımı',
                  subtitle: 'Karmaşık alanlarda spesifik hedef tespiti',
                  icon: Icons.radar_rounded,
                  accentColor: const Color(0xff3b82f6),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AttentionGameScreen()),
                    );
                  },
                ),
                const SizedBox(height: 16),
                InteractiveCard(
                  title: 'Yönelim Algısı',
                  subtitle: 'Hızlı refleks motor komut denetimi',
                  icon: Icons.explore_rounded,
                  accentColor: const Color(0xff3b82f6),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const OrientationGameScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MotorMenuScreen extends StatelessWidget {
  const MotorMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Motor Modül'),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: ListView(
              padding: const EdgeInsets.all(24.0),
              children: [
                 const SizedBox(height: 16),
                InteractiveCard(
                  title: 'Serbest Geometri',
                  subtitle: 'Dokunmatik hassasiyet ve serbest çizim',
                  icon: Icons.gesture_rounded,
                  accentColor: const Color(0xfff59e0b),
                  onTap: () {
                     Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ShapeDrawingScreen()),
                    );
                  },
                ),
                const SizedBox(height: 16),
                InteractiveCard(
                  title: 'Asenkron Koordinasyon',
                  subtitle: 'Zamana karşı anlık el göz tepkimesi',
                  icon: Icons.touch_app_rounded,
                  accentColor: const Color(0xfff59e0b),
                  onTap: () {
                     Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HandEyeCoordinationScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: const Text('Performans Analizi'),
      ),
      body: Center(
        child: FrostedGlass(
          width: 340,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                   color: const Color(0xff10b981).withOpacity(0.1),
                   shape: BoxShape.circle,
                ),
                child: const Icon(Icons.auto_graph_rounded, size: 80, color: Color(0xff10b981)),
              ),
              const SizedBox(height: 32),
              const Text(
                'Analitik Veriler Toplanıyor',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xfff4f4f5)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'Sistem düzenli ölçümleri doğrultusunda performans grafiğiniz çok yakında burada olacak.',
                style: TextStyle(fontSize: 14, color: Color(0xffa1a1aa), height: 1.5),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AwardsScreen extends StatelessWidget {
  const AwardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Başarı Kriterleri'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: FrostedGlass(
               width: 340,
               child: Column(
                 mainAxisSize: MainAxisSize.min,
                 children: [
               Container(
                 padding: const EdgeInsets.all(24),
                 decoration: BoxDecoration(
                    color: const Color(0xff8b5cf6).withOpacity(0.1),
                    shape: BoxShape.circle,
                 ),
                 child: const Icon(Icons.workspace_premium_rounded, size: 80, color: Color(0xff8b5cf6)),
               ),
                const SizedBox(height: 32),
                const Text(
                  'Yetkinlik Dereceleri Bulunamadı',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xfff4f4f5)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Modülleri başarıyla tamamlayarak sistem üzerinde rozet elde edebilirsiniz.',
                  style: TextStyle(fontSize: 14, color: Color(0xffa1a1aa), height: 1.5),
                  textAlign: TextAlign.center,
                ),
                 ],
               ),
            ),
          ),
        ),
      ),
    );
  }
}

class MemoryGameScreen extends StatefulWidget {
  const MemoryGameScreen({super.key});

  @override
  State<MemoryGameScreen> createState() => _MemoryGameScreenState();
}

class _MemoryGameScreenState extends State<MemoryGameScreen> {
  final List<IconData> _allIcons = [
     Icons.data_usage_rounded, 
     Icons.fingerprint_rounded, 
     Icons.webhook_rounded, 
     Icons.grid_view_rounded, 
     Icons.filter_drama_rounded, 
     Icons.blur_on_rounded
  ];
  final List<IconData> _sequence = [];
  final List<IconData> _userSequence = [];
  bool _isPlayingSequence = false;
  String _message = 'Eğitimi Başlatmak İçin Hazırsanız Tıklayın';
  int _level = 1;

  IconData? _currentDisplayIcon;

  void _startGame() async {
    setState(() {
      _userSequence.clear();
      _isPlayingSequence = true;
      _message = 'Objektifleri Ezberleyin...';
      _sequence.clear();
      _currentDisplayIcon = null;
    });

    final random = Random();
    for (int i = 0; i < _level + 2; i++) {
      _sequence.add(_allIcons[random.nextInt(_allIcons.length)]);
    }

    for (int i = 0; i < _sequence.length; i++) {
      if (!mounted) return;
      
      setState(() {
        _currentDisplayIcon = _sequence[i];
      });
      
      await Future.delayed(const Duration(milliseconds: 800));
      
      if (!mounted) return;
      setState(() {
         _currentDisplayIcon = null; // blink effect
      });
      
      await Future.delayed(const Duration(milliseconds: 200));
    }

    if (mounted) {
      setState(() {
        _isPlayingSequence = false;
        _message = 'Analiz Ettiğiniz Sırayı Girin';
      });
    }
  }

  void _onIconTap(IconData icon) {
    if (_isPlayingSequence || _sequence.isEmpty) return;

    setState(() {
      _userSequence.add(icon);
      if (_userSequence.length == _sequence.length) {
         bool correct = true;
         for (int i = 0; i < _sequence.length; i++) {
           if (_sequence[i] != _userSequence[i]) {
             correct = false;
             break;
           }
         }
         if (correct) {
           _message = 'Başarılı. Aşama $_level Tamamlandı.';
           _level++;
         } else {
           _message = 'Güvenlik İhlali: Yanlış Sıralama. Tekrar Deneyiniz.';
           _level = 1;
         }
         _sequence.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hafıza Odaklanması')),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: FrostedGlass(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                   Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                     decoration: BoxDecoration(
                        color: const Color(0xff3b82f6).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16)
                     ),
                     child: Text(
                        'Aşama $_level', 
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xff3b82f6), letterSpacing: 1)
                     ),
                   ),
                  const SizedBox(height: 24),
                  Text(
                    _message, 
                    textAlign: TextAlign.center,
                    style: TextStyle(
                       fontSize: 18, 
                       fontWeight: FontWeight.w600, 
                       color: _message.contains('Yanlış') ? const Color(0xffef4444) : const Color(0xfff4f4f5),
                       height: 1.4
                    )
                  ),
                  const SizedBox(height: 48),
                  SizedBox(
                    height: 120,
                    child: Center(
                      child: _isPlayingSequence
                        ? AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder: (Widget child, Animation<double> animation) {
                               return ScaleTransition(scale: animation, child: FadeTransition(opacity: animation, child: child));
                            },
                            child: _currentDisplayIcon != null 
                              ? Container(
                                  key: ValueKey(_currentDisplayIcon!.codePoint),
                                  padding: const EdgeInsets.all(32),
                                  decoration: const BoxDecoration(
                                    color: Color(0xff27272a),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(_currentDisplayIcon, size: 48, color: const Color(0xff3b82f6)),
                                )
                              : const SizedBox(key: ValueKey('empty_space')),
                          )
                        : !_isPlayingSequence && _sequence.isNotEmpty
                          ? Wrap(
                              spacing: 16,
                              runSpacing: 16,
                              alignment: WrapAlignment.center,
                              children: _allIcons.map((icon) {
                                return Material(
                                  color: const Color(0xff27272a),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  clipBehavior: Clip.antiAlias,
                                  child: InkWell(
                                    onTap: () => _onIconTap(icon),
                                    child: Padding(
                                      padding: const EdgeInsets.all(24),
                                      child: Icon(icon, color: const Color(0xff3b82f6), size: 32),
                                    ),
                                  ),
                                );
                              }).toList(),
                            )
                          : const Icon(Icons.layers_clear_rounded, size: 60, color: Color(0xff52525b)),
                    ),
                  ),
                  const SizedBox(height: 48),
                  if (_sequence.isEmpty)
                    ElevatedButton(
                      onPressed: _startGame, 
                      style: ElevatedButton.styleFrom(
                         backgroundColor: const Color(0xff3b82f6),
                         minimumSize: const Size(double.infinity, 56)
                      ),
                      child: const Text('Sistemi Başlat')
                    ),
                  if (_userSequence.isNotEmpty && _sequence.isNotEmpty && !_isPlayingSequence)
                     Padding(
                       padding: const EdgeInsets.all(16.0),
                       child: LinearProgressIndicator(
                          value: _userSequence.length / _sequence.length,
                          backgroundColor: const Color(0xff27272a),
                          color: const Color(0xff3b82f6),
                          borderRadius: BorderRadius.circular(8),
                          minHeight: 8,
                       ),
                     ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AttentionGameScreen extends StatefulWidget {
  const AttentionGameScreen({super.key});

  @override
  State<AttentionGameScreen> createState() => _AttentionGameScreenState();
}

class _AttentionGameScreenState extends State<AttentionGameScreen> {
  final List<IconData> _icons = [
     Icons.device_hub_rounded, 
     Icons.dns_rounded, 
     Icons.security_rounded, 
     Icons.api_rounded, 
     Icons.bug_report_rounded, 
     Icons.integration_instructions_rounded
  ];
  IconData? _targetIcon;
  final List<IconData> _gridIcons = [];
  int _score = 0;
  String _message = 'Sistem Hedefini Tespit Edin';

  @override
  void initState() {
    super.initState();
    _generateGrid();
  }

  void _generateGrid() {
    final random = Random();
    _targetIcon = _icons[random.nextInt(_icons.length)];
    _gridIcons.clear();
    for (int i = 0; i < 20; i++) {
      _gridIcons.add(_icons[random.nextInt(_icons.length)]);
    }
    _gridIcons[random.nextInt(20)] = _targetIcon!;
    setState(() {});
  }

  void _onIconTap(IconData icon) {
    if (icon == _targetIcon) {
      setState(() {
        _score += 150;
        _message = 'Başarılı. Yeni Hedef Derleniyor.';
        _generateGrid();
      });
    } else {
      setState(() {
         if (_score >= 50) _score -= 50;
        _message = 'Hatalı Parametre.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dikkat Dağılımı')),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: FrostedGlass(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                borderRadius: BorderRadius.circular(24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                             _message, 
                             style: TextStyle(
                                fontSize: 14, 
                                color: _message.contains('Hatalı') ? const Color(0xffef4444) : const Color(0xffa1a1aa)
                             )
                          ),
                          const SizedBox(height: 12),
                           Row(
                            children: [
                              const Text('Hedef Düğüm: ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xfff4f4f5))),
                              const SizedBox(width: 8),
                              Icon(_targetIcon, size: 28, color: const Color(0xff10b981)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xff3b82f6).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xff3b82f6).withOpacity(0.2))
                      ),
                      child: Column(
                        children: [
                           const Text('XP', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xff3b82f6), letterSpacing: 1)),
                           Text('$_score', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xfff4f4f5))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(24),
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, 
                  mainAxisSpacing: 16, 
                  crossAxisSpacing: 16
                ),
                itemCount: 20,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => _onIconTap(_gridIcons[index]),
                    borderRadius: BorderRadius.circular(16),
                    splashColor: const Color(0xff3b82f6).withOpacity(0.2),
                    highlightColor: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xff18181b),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white.withOpacity(0.05))
                      ),
                      child: Icon(_gridIcons[index], size: 32, color: const Color(0xff71717a)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrientationGameScreen extends StatefulWidget {
  const OrientationGameScreen({super.key});

  @override
  State<OrientationGameScreen> createState() => _OrientationGameScreenState();
}

class _OrientationGameScreenState extends State<OrientationGameScreen> {
  final List<String> _directions = ['Kuzey', 'Güney', 'Batı', 'Doğu'];
  String _targetDirection = '';
  int _score = 0;
  String _message = 'Sistemi Başlatmak İçin Test Girin';

  @override
  void initState() {
    super.initState();
    _nextDirection();
  }

  void _nextDirection() {
    final random = Random();
    _targetDirection = _directions[random.nextInt(_directions.length)];
  }

  void _checkDirection(String direction) {
    if (direction == _targetDirection) {
      setState(() {
        _score++;
        _message = 'Vektör Doğrulandı';
        _nextDirection();
      });
    } else {
      setState(() {
        _message = 'Hatalı Vektör Girişi';
      });
    }
  }

  Widget _buildDirectionButton(IconData icon, String direction) {
    return Material(
      color: const Color(0xff27272a),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: InkWell(
        onTap: () => _checkDirection(direction),
        borderRadius: BorderRadius.circular(24),
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(24),
             border: Border.all(color: Colors.white.withOpacity(0.05))
          ),
          child: Icon(icon, size: 36, color: const Color(0xff3b82f6)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Yönelim Algısı')),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              FrostedGlass(
                 child: Column(
                    children: [
                       Text('Geçerli Doğrulama: $_score', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xffa1a1aa))),
                       const SizedBox(height: 32),
                       const Text('Hedef Ara Nokta', style: TextStyle(fontSize: 12, color: Color(0xff71717a), letterSpacing: 1.5, fontWeight: FontWeight.bold)),
                       const SizedBox(height: 8),
                       Text(
                         _targetDirection, 
                         style: const TextStyle(fontSize: 32, color: Color(0xfff4f4f5), fontWeight: FontWeight.w900, letterSpacing: 2)
                       ),
                       const SizedBox(height: 32),
                       Text(
                          _message, 
                          style: TextStyle(
                             fontSize: 14, 
                             color: _message.contains('Hatalı') ? const Color(0xffef4444) : const Color(0xff10b981),
                             fontWeight: FontWeight.bold
                          )
                       ),
                    ],
                 ),
              ),
              const SizedBox(height: 60),
              _buildDirectionButton(Icons.keyboard_arrow_up_rounded, 'Kuzey'),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildDirectionButton(Icons.keyboard_arrow_left_rounded, 'Batı'),
                  const SizedBox(width: 80),
                  _buildDirectionButton(Icons.keyboard_arrow_right_rounded, 'Doğu'),
                ],
              ),
              const SizedBox(height: 16),
              _buildDirectionButton(Icons.keyboard_arrow_down_rounded, 'Güney'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ShapeDrawingScreen extends StatefulWidget {
  const ShapeDrawingScreen({super.key});

  @override
  State<ShapeDrawingScreen> createState() => _ShapeDrawingScreenState();
}

class _ShapeDrawingScreenState extends State<ShapeDrawingScreen> {
  final List<Offset?> _points = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Serbest Geometri'),
        actions: [
          IconButton(
            icon: const Icon(Icons.cleaning_services_rounded, color: Color(0xffef4444)),
            onPressed: () {
              setState(() {
                _points.clear();
              });
            },
            tooltip: 'Tuvali Temizle',
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Row(
               children: [
                  Icon(Icons.info_outline_rounded, size: 16, color: Color(0xff71717a)),
                  SizedBox(width: 8),
                  Text(
                    'Motor senkronizasyonu için serbest çizim protokolü.', 
                    style: TextStyle(fontSize: 14, color: Color(0xff71717a))
                  ),
               ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xff18181b),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.white.withOpacity(0.1)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      setState(() {
                        RenderBox renderBox = context.findRenderObject() as RenderBox;
                        _points.add(renderBox.globalToLocal(details.globalPosition));
                      });
                    },
                    onPanEnd: (details) {
                      setState(() {
                        _points.add(null);
                      });
                    },
                    child: CustomPaint(
                      painter: DrawingPainter(_points),
                      size: Size.infinite,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawingPainter extends CustomPainter {
  final List<Offset?> points;

  DrawingPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    GridPaperPainter.paintGrid(canvas, size);

    final paint = Paint()
      ..color = const Color(0xfff59e0b)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4.0
      ..strokeJoin = StrokeJoin.round;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(DrawingPainter oldDelegate) => true;
}

class GridPaperPainter {
   static void paintGrid(Canvas canvas, Size size) {
      final paint = Paint()
         ..color = Colors.white.withOpacity(0.02)
         ..strokeWidth = 1.0;
      
      const double spacing = 40.0;
      
      for (double x = 0; x < size.width; x += spacing) {
         canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
      }
      for (double y = 0; y < size.height; y += spacing) {
         canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
      }
   }
}

class HandEyeCoordinationScreen extends StatefulWidget {
  const HandEyeCoordinationScreen({super.key});

  @override
  State<HandEyeCoordinationScreen> createState() => _HandEyeCoordinationScreenState();
}

class _HandEyeCoordinationScreenState extends State<HandEyeCoordinationScreen> {
  double _top = 100;
  double _left = 100;
  int _score = 0;
  int _timeLeft = 30;
  Timer? _timer;
  bool _isPlaying = false;

  void _startGame() {
    setState(() {
      _score = 0;
      _timeLeft = 30;
      _isPlaying = true;
    });
    _moveTarget();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (_timeLeft > 0) {
            _timeLeft--;
          } else {
            _isPlaying = false;
            _timer?.cancel();
          }
        });
      }
    });
  }

  void _moveTarget() {
    final random = Random();
    setState(() {
      _top = random.nextDouble() * 400 + 50;
      _left = random.nextDouble() * 250 + 20;
    });
  }

  void _onTargetTap() {
    if (_isPlaying) {
      setState(() {
        _score++;
      });
      _moveTarget();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Asenkron Koordinasyon')),
      body: _isPlaying
          ? Stack(
              children: [
                Positioned(
                  top: 24,
                  left: 24,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                       color: const Color(0xff27272a), 
                       borderRadius: BorderRadius.circular(20), 
                       border: Border.all(color: Colors.white.withOpacity(0.05))
                    ),
                    child: Row(
                       children: [
                          const Icon(Icons.flash_on_rounded, size: 16, color: Color(0xfff59e0b)),
                          const SizedBox(width: 8),
                          Text('$_score', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xfff4f4f5))),
                       ],
                    ),
                  ),
                ),
                Positioned(
                  top: 24,
                  right: 24,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                       color: const Color(0xff27272a), 
                       borderRadius: BorderRadius.circular(20), 
                       border: Border.all(color: Colors.white.withOpacity(0.05))
                    ),
                    child: Row(
                       children: [
                          const Icon(Icons.timer_outlined, size: 16, color: Color(0xffef4444)),
                          const SizedBox(width: 8),
                          Text('00:$_timeLeft', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xfff4f4f5))),
                       ],
                    ),
                  ),
                ),
                Positioned(
                  top: _top,
                  left: _left,
                  child: GestureDetector(
                    onTap: _onTargetTap,
                    child: Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xfff59e0b),
                        boxShadow: [
                           BoxShadow(color: const Color(0xfff59e0b).withOpacity(0.4), blurRadius: 24, spreadRadius: 4),
                        ],
                        border: Border.all(color: Colors.white, width: 2)
                      ),
                      child: const Center(
                        child: Icon(Icons.my_location_rounded, size: 32, color: Color(0xff09090b)),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Center(
              child: FrostedGlass(
                width: 340,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                           color: const Color(0xfff59e0b).withOpacity(0.1),
                           shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.fact_check_rounded, size: 64, color: Color(0xfff59e0b)),
                     ),
                     const SizedBox(height: 32),
                     const Text('Oturum Sonlandı', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xfff4f4f5))),
                     const SizedBox(height: 12),
                     Text('Sinyal Yakalama Verimliliği: $_score', style: const TextStyle(fontSize: 14, color: Color(0xffa1a1aa))),
                     const SizedBox(height: 48),
                     ElevatedButton(
                       onPressed: _startGame, 
                       style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xfff59e0b), 
                          minimumSize: const Size(double.infinity, 56)
                       ),
                       child: const Text('Yeni Oturum Başlat')
                     ),
                  ],
                ),
              ),
            ),
    );
  }
}
