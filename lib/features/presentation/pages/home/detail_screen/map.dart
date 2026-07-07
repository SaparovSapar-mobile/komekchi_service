// Vyzyvay pervый bottomsheet:
import 'package:flutter/material.dart';
import 'package:komekchi_service/core/utils/theme/const.dart';

import '../../../../../core/utils/theme/app_colors.dart';
import '../map_screen.dart';

void showSalgyBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => const _SalgyBottomSheet(),
  );
}

// ============ ПЕРВЫЙ BOTTOMSHEET ============
class _SalgyBottomSheet extends StatefulWidget {
  const _SalgyBottomSheet();

  @override
  State<_SalgyBottomSheet> createState() => _SalgyBottomSheetState();
}

class _SalgyBottomSheetState extends State<_SalgyBottomSheet> {
  int _selectedIndex = -1;

  final List<_SalgyItem> _items = [
    _SalgyItem(
      image: "assets/images/onboarding/image1.png",
      title: 'Öý salgym',
      subtitle: '14-nji ýabyr',
      color: Colors.blue,
    ),
    _SalgyItem(
      image: "assets/images/onboarding/image2.png",
      title: 'Iş salgym',
      subtitle: 'G. Kulyýew köç.',
      color: Colors.blue,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColor.bgPageDark : AppColor.bgPageLight;
    final cardBg = isDark ? AppColor.bgBlogDark : AppColor.bgBlogLight;
    // final borderColor = isDark ? const Color(0xFF333333) : AppColor.borderColor;

    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),

      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Salgy ady',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),

          // Dynamic items
          ...List.generate(_items.length, (index) {
            final item = _items[index];
            final isSelected = _selectedIndex == index;
            return GestureDetector(
              onTap: () {
                setState(() => _selectedIndex = index);
                Navigator.pop(context, _items[index]);
              },

              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Image.asset(item.image, width: 38, height: 38),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            item.subtitle,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected
                              ? AppColor.primary
                              : Colors.grey.shade300,
                          width: isSelected ? 6 : 1.5,
                        ),
                        color: isDark ? AppColor.bgPageDark : Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),

          // Divider

          // Başga
          GestureDetector(
            onTap: () {
              // final rootContext = Navigator.of(
              //   context,
              //   rootNavigator: true,
              // ).context;
              // Navigator.pop(context);
              // Future.delayed(const Duration(milliseconds: 300), () {
              //   showSalgyAtiandyrBottomSheet(
              //     rootContext,
              //     onLocationAdded: (name) {
              //       Future.delayed(const Duration(milliseconds: 300), () {
              //         showSalgyBottomSheet(rootContext);
              //       });
              //     },
              //   );
              // });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/onboarding/image3.png",
                    width: 38,
                    height: 38,
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Başga',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _SalgyItem {
  final String image;
  final String title;
  final String subtitle;
  final Color color;

  _SalgyItem({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.color,
  });
}

// ============ VTOROY BOTTOMSHEET ============
void showSalgyAtiandyrBottomSheet(
  BuildContext context, {
  required ValueChanged<String> onLocationAdded,
  String initialText = '', // ← добавь
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => _SalgyAtiandyrBottomSheet(
      onLocationAdded: onLocationAdded,
      initialText: initialText, // ← передай
    ),
  );
}

class _SalgyAtiandyrBottomSheet extends StatefulWidget {
  final ValueChanged<String> onLocationAdded;
  final String initialText;
  const _SalgyAtiandyrBottomSheet({
    required this.onLocationAdded,
    required this.initialText,
  });

  @override
  State<_SalgyAtiandyrBottomSheet> createState() =>
      _SalgyAtiandyrBottomSheetState();
}

class _SalgyAtiandyrBottomSheetState extends State<_SalgyAtiandyrBottomSheet> {
  late final TextEditingController _controller;
  String _selectedLocation = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.initialText,
    ); // ← инициализируй тут
    _selectedLocation = widget.initialText;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Salgy atiandyr',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),

            // Text field
            TextField(
              controller: _controller,
              onChanged: (val) => setState(() => _selectedLocation = val),
              decoration: InputDecoration(
                hintText: 'Howly jaý',
                hintStyle: TextStyle(color: Colors.grey.shade400),
                filled: true,
                fillColor: const Color(0xFFF6F8FD),
                suffixIcon: _controller.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.cancel, color: Colors.grey),
                        onPressed: () {
                          _controller.clear();
                          setState(() => _selectedLocation = '');
                        },
                      )
                    : null,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFFEEEEEE)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFFEEEEEE)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColor.primary),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Yerinizi girizin — otkryvaet map
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                // Otkryvay map screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MapScreen(
                      onLocationSelected: (locationName) {
                        Future.delayed(const Duration(milliseconds: 300), () {
                          showSalgyAtiandyrBottomSheet(
                            context,
                            onLocationAdded: widget.onLocationAdded,
                            initialText: locationName, // ← передаём текст сюда
                          );
                        });
                      },
                    ),
                  ),
                );
              },
              child: Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F0FF),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: AppColor.primary,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Salgym',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColor.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Ýeriňizi giriziň',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey.shade500,
                    size: 18,
                  ),
                ],
              ),
            ),

            // Tassyklamak button (esli vveden tekst)
            if (_selectedLocation.isNotEmpty) ...[
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    widget.onLocationAdded(_selectedLocation);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Goşmak',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

// ============ MAP SCREEN ============
