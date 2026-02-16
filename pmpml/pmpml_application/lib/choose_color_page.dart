import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChooseColorPage extends StatefulWidget {
  final Function(Color) onColorSelected;

  const ChooseColorPage({Key? key, required this.onColorSelected})
      : super(key: key);

  @override
  State<ChooseColorPage> createState() => _ChooseColorPageState();
}

class _ChooseColorPageState extends State<ChooseColorPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Manual color adjustment values
  double _hue = 180; // Cyan default
  double _saturation = 0.5;
  double _lightness = 0.5;

  // Search functionality
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  Color get _manualColor =>
      HSLColor.fromAHSL(1.0, _hue, _saturation, _lightness).toColor();

  List<Map<String, dynamic>> _getFilteredColors(
      List<Map<String, dynamic>> allColors) {
    if (_searchQuery.isEmpty) {
      return allColors;
    }
    final query = _searchQuery.toLowerCase();
    return allColors.where((colorData) {
      final name = colorData['name'].toString().toLowerCase();
      return name.contains(query);
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> colors = [
      // Faint Light Colors (0-19)
      {'name': 'Faint Yellow', 'color': const Color(0xFFFFF9C4)},
      {'name': 'Faint Blue', 'color': const Color(0xFFEAF6FF)},
      {'name': 'Faint Red', 'color': const Color(0xFFFFEBEE)},
      {'name': 'Faint Green', 'color': const Color(0xFFE8F5E8)},
      {'name': 'Faint Purple', 'color': const Color(0xFFF3E5F5)},
      {'name': 'Faint Orange', 'color': const Color(0xFFFFF3E0)},
      {'name': 'Faint Pink', 'color': const Color(0xFFFCE4EC)},
      {'name': 'Faint Grey', 'color': const Color(0xFFF5F5F5)},
      {'name': 'Faint Cyan', 'color': const Color(0xFFE0F7FA)},
      {'name': 'Faint Lime', 'color': const Color(0xFFF9FBE7)},
      {'name': 'Faint Indigo', 'color': const Color(0xFFE8EAF6)},
      {'name': 'Faint Teal', 'color': const Color(0xFFE0F2F1)},
      {'name': 'Faint Brown', 'color': const Color(0xFFEFEBE9)},
      {'name': 'Faint Amber', 'color': const Color(0xFFFFF8E1)},
      {'name': 'Faint Deep Orange', 'color': const Color(0xFFFBE9E7)},
      {'name': 'Faint Light Blue', 'color': const Color(0xFFE1F5FE)},
      {'name': 'Faint Light Green', 'color': const Color(0xFFF1F8E9)},
      {'name': 'Faint Blue Grey', 'color': const Color(0xFFECEFF1)},
      {'name': 'Faint Deep Purple', 'color': const Color(0xFFEDE7F6)},
      {'name': 'Faint Light Pink', 'color': const Color(0xFFF8BBD9)},

      // Light Colors (20-39)
      {'name': 'Light Yellow', 'color': const Color(0xFFFFF176)},
      {'name': 'Light Blue', 'color': const Color(0xFF81D4FA)},
      {'name': 'Light Red', 'color': const Color(0xFFEF9A9A)},
      {'name': 'Light Green', 'color': const Color(0xFFA5D6A7)},
      {'name': 'Light Purple', 'color': const Color(0xFFCE93D8)},
      {'name': 'Light Orange', 'color': const Color(0xFFFFCC80)},
      {'name': 'Light Pink', 'color': const Color(0xFFF48FB1)},
      {'name': 'Light Grey', 'color': const Color(0xFFE0E0E0)},
      {'name': 'Light Cyan', 'color': const Color(0xFF80DEEA)},
      {'name': 'Light Lime', 'color': const Color(0xFFDCE775)},
      {'name': 'Light Indigo', 'color': const Color(0xFF9FA8DA)},
      {'name': 'Light Teal', 'color': const Color(0xFF80CBC4)},
      {'name': 'Light Brown', 'color': const Color(0xFFBCAAA4)},
      {'name': 'Light Amber', 'color': const Color(0xFFFFE082)},
      {'name': 'Light Deep Orange', 'color': const Color(0xFFFFAB91)},
      {'name': 'Light Light Blue', 'color': const Color(0xFFB3E5FC)},
      {'name': 'Light Light Green', 'color': const Color(0xFFC8E6C9)},
      {'name': 'Light Blue Grey', 'color': const Color(0xFFB0BEC5)},
      {'name': 'Light Deep Purple', 'color': const Color(0xFFB39DDB)},
      {'name': 'Light Light Pink', 'color': const Color(0xFFF8BBD0)},

      // Medium Light Colors (40-59)
      {'name': 'Medium Yellow', 'color': const Color(0xFFFFF59D)},
      {'name': 'Medium Blue', 'color': const Color(0xFF4FC3F7)},
      {'name': 'Medium Red', 'color': const Color(0xFFE57373)},
      {'name': 'Medium Green', 'color': const Color(0xFF81C784)},
      {'name': 'Medium Purple', 'color': const Color(0xFFBA68C8)},
      {'name': 'Medium Orange', 'color': const Color(0xFFFFB74D)},
      {'name': 'Medium Pink', 'color': const Color(0xFFF06292)},
      {'name': 'Medium Grey', 'color': const Color(0xFFBDBDBD)},
      {'name': 'Medium Cyan', 'color': const Color(0xFF4DD0E1)},
      {'name': 'Medium Lime', 'color': const Color(0xFFD4E157)},
      {'name': 'Medium Indigo', 'color': const Color(0xFF7986CB)},
      {'name': 'Medium Teal', 'color': const Color(0xFF4DB6AC)},
      {'name': 'Medium Brown', 'color': const Color(0xFFA1887F)},
      {'name': 'Medium Amber', 'color': const Color(0xFFFFD54F)},
      {'name': 'Medium Deep Orange', 'color': const Color(0xFFFF8A65)},
      {'name': 'Medium Light Blue', 'color': const Color(0xFF4FC3F7)},
      {'name': 'Medium Light Green', 'color': const Color(0xFFA5D6A7)},
      {'name': 'Medium Blue Grey', 'color': const Color(0xFF90A4AE)},
      {'name': 'Medium Deep Purple', 'color': const Color(0xFF9575CD)},
      {'name': 'Medium Light Pink', 'color': const Color(0xFFEC407A)},

      // Dark Colors (60-79)
      {'name': 'Dark Yellow', 'color': const Color(0xFFFBC02D)},
      {'name': 'Dark Blue', 'color': const Color(0xFF0288D1)},
      {'name': 'Dark Red', 'color': const Color(0xFFD32F2F)},
      {'name': 'Dark Green', 'color': const Color(0xFF388E3C)},
      {'name': 'Dark Purple', 'color': const Color(0xFF7B1FA2)},
      {'name': 'Dark Orange', 'color': const Color(0xFFF57C00)},
      {'name': 'Dark Pink', 'color': const Color(0xFFC2185B)},
      {'name': 'Dark Grey', 'color': const Color(0xFF616161)},
      {'name': 'Dark Cyan', 'color': const Color(0xFF0097A7)},
      {'name': 'Dark Lime', 'color': const Color(0xFFAFB42B)},
      {'name': 'Dark Indigo', 'color': const Color(0xFF3F51B5)},
      {'name': 'Dark Teal', 'color': const Color(0xFF00796B)},
      {'name': 'Dark Brown', 'color': const Color(0xFF5D4037)},
      {'name': 'Dark Amber', 'color': const Color(0xFFFFA000)},
      {'name': 'Dark Deep Orange', 'color': const Color(0xFFE64A19)},
      {'name': 'Dark Light Blue', 'color': const Color(0xFF0277BD)},
      {'name': 'Dark Light Green', 'color': const Color(0xFF2E7D32)},
      {'name': 'Dark Blue Grey', 'color': const Color(0xFF546E7A)},
      {'name': 'Dark Deep Purple', 'color': const Color(0xFF512DA8)},
      {'name': 'Dark Light Pink', 'color': const Color(0xFFAD1457)},

      // Darker Colors (80-99)
      {'name': 'Darker Yellow', 'color': const Color(0xFFF9A825)},
      {'name': 'Darker Blue', 'color': const Color(0xFF01579B)},
      {'name': 'Darker Red', 'color': const Color(0xFFB71C1C)},
      {'name': 'Darker Green', 'color': const Color(0xFF1B5E20)},
      {'name': 'Darker Purple', 'color': const Color(0xFF4A148C)},
      {'name': 'Darker Orange', 'color': const Color(0xFFE65100)},
      {'name': 'Darker Pink', 'color': const Color(0xFF880E4F)},
      {'name': 'Darker Grey', 'color': const Color(0xFF424242)},
      {'name': 'Darker Cyan', 'color': const Color(0xFF006064)},
      {'name': 'Darker Lime', 'color': const Color(0xFF827717)},
      {'name': 'Darker Indigo', 'color': const Color(0xFF1A237E)},
      {'name': 'Darker Teal', 'color': const Color(0xFF004D40)},
      {'name': 'Darker Brown', 'color': const Color(0xFF3E2723)},
      {'name': 'Darker Amber', 'color': const Color(0xFFFF8F00)},
      {'name': 'Darker Deep Orange', 'color': const Color(0xFFBF360C)},
      {'name': 'Darker Light Blue', 'color': const Color(0xFF014977)},
      {'name': 'Darker Light Green', 'color': const Color(0xFF1B5E20)},
      {'name': 'Darker Blue Grey', 'color': const Color(0xFF37474F)},
      {'name': 'Darker Deep Purple', 'color': const Color(0xFF311B92)},
      {'name': 'Darker Light Pink', 'color': const Color(0xFF880E4F)},

      // Vibrant Colors (100-119)
      {'name': 'Vibrant Red', 'color': const Color(0xFFFF0000)},
      {'name': 'Vibrant Blue', 'color': const Color(0xFF0000FF)},
      {'name': 'Vibrant Green', 'color': const Color(0xFF00FF00)},
      {'name': 'Vibrant Yellow', 'color': const Color(0xFFFFFF00)},
      {'name': 'Vibrant Cyan', 'color': const Color(0xFF00FFFF)},
      {'name': 'Vibrant Magenta', 'color': const Color(0xFFFF00FF)},
      {'name': 'Vibrant Orange', 'color': const Color(0xFFFF6600)},
      {'name': 'Vibrant Pink', 'color': const Color(0xFFFF1493)},
      {'name': 'Vibrant Purple', 'color': const Color(0xFF9400D3)},
      {'name': 'Vibrant Lime', 'color': const Color(0xFF32CD32)},
      {'name': 'Vibrant Teal', 'color': const Color(0xFF008080)},
      {'name': 'Vibrant Coral', 'color': const Color(0xFFFF7F50)},
      {'name': 'Vibrant Gold', 'color': const Color(0xFFFFD700)},
      {'name': 'Vibrant Silver', 'color': const Color(0xFFC0C0C0)},
      {'name': 'Vibrant Maroon', 'color': const Color(0xFF800000)},
      {'name': 'Vibrant Navy', 'color': const Color(0xFF000080)},
      {'name': 'Vibrant Olive', 'color': const Color(0xFF808000)},
      {'name': 'Vibrant Aqua', 'color': const Color(0xFF00CED1)},
      {'name': 'Vibrant Violet', 'color': const Color(0xFFEE82EE)},
      {'name': 'Vibrant Crimson', 'color': const Color(0xFFDC143C)},

      // Pastel Colors (120-139)
      {'name': 'Pastel Red', 'color': const Color(0xFFFFB3BA)},
      {'name': 'Pastel Blue', 'color': const Color(0xFFBAE1FF)},
      {'name': 'Pastel Green', 'color': const Color(0xFFBAFFC9)},
      {'name': 'Pastel Yellow', 'color': const Color(0xFFFFFFBA)},
      {'name': 'Pastel Cyan', 'color': const Color(0xFFBAFFFF)},
      {'name': 'Pastel Pink', 'color': const Color(0xFFFFBAE1)},
      {'name': 'Pastel Purple', 'color': const Color(0xFFE1BAFF)},
      {'name': 'Pastel Orange', 'color': const Color(0xFFFFE1BA)},
      {'name': 'Pastel Lavender', 'color': const Color(0xFFE6E6FA)},
      {'name': 'Pastel Mint', 'color': const Color(0xFF98FF98)},
      {'name': 'Pastel Peach', 'color': const Color(0xFFFFDAB9)},
      {'name': 'Pastel Mauve', 'color': const Color(0xFFE0BBE4)},
      {'name': 'Pastel Peach', 'color': const Color(0xFFFFCBA4)},
      {'name': 'Pastel Lemon', 'color': const Color(0xFFFFF44F)},
      {'name': 'Pastel Rose', 'color': const Color(0xFFFFC0CB)},
      {'name': 'Pastel Sky', 'color': const Color(0xFFADD8E6)},
      {'name': 'Pastel Cream', 'color': const Color(0xFFFFFDD0)},
      {'name': 'Pastel Coral', 'color': const Color(0xFFFF7F7F)},
      {'name': 'Pastel Sage', 'color': const Color(0xFFB2AC88)},
      {'name': 'Pastel Lilac', 'color': const Color(0xFFC8A2C8)},

      // Earth Tones (140-159)
      {'name': 'Earth Brown', 'color': const Color(0xFF8B4513)},
      {'name': 'Earth Tan', 'color': const Color(0xFFD2B48C)},
      {'name': 'Earth Olive', 'color': const Color(0xFF556B2F)},
      {'name': 'Earth Sienna', 'color': const Color(0xFFA0522D)},
      {'name': 'Earth Khaki', 'color': const Color(0xFFC3B091)},
      {'name': 'Earth Rust', 'color': const Color(0xFFB7410E)},
      {'name': 'Earth Sand', 'color': const Color(0xFFC2B280)},
      {'name': 'Earth Moss', 'color': const Color(0xFF8A9A5B)},
      {'name': 'Earth Clay', 'color': const Color(0xFFB66A50)},
      {'name': 'Earth Bronze', 'color': const Color(0xFFCD7F32)},
      {'name': 'Earth Walnut', 'color': const Color(0xFF5C4033)},
      {'name': 'Earth Cork', 'color': const Color(0xFFBDA55D)},
      {'name': 'Earth Umber', 'color': const Color(0xFF635147)},
      {'name': 'Earth Ochre', 'color': const Color(0xFFCC7722)},
      {'name': 'Earth Terracotta', 'color': const Color(0xFFE2725B)},
      {'name': 'Earth Sage Green', 'color': const Color(0xFF9DC183)},
      {'name': 'Earth Taupe', 'color': const Color(0xFF483C32)},
      {'name': 'Earth Wheat', 'color': const Color(0xFFF5DEB3)},
      {'name': 'Earth Bamboo', 'color': const Color(0xFFBDB76B)},
      {'name': 'Earth Mahogany', 'color': const Color(0xFF4A0000)},

      // Nature Colors (160-179)
      {'name': 'Nature Forest', 'color': const Color(0xFF228B22)},
      {'name': 'Nature Sky', 'color': const Color(0xFF87CEEB)},
      {'name': 'Nature Ocean', 'color': const Color(0xFF006994)},
      {'name': 'Nature Leaf', 'color': const Color(0xFF4CAF50)},
      {'name': 'Nature Sun', 'color': const Color(0xFFFFD700)},
      {'name': 'Nature Sunset', 'color': const Color(0xFFFD5E53)},
      {'name': 'Nature Moon', 'color': const Color(0xFFF4F6F0)},
      {'name': 'Nature Cloud', 'color': const Color(0xFFB0C4DE)},
      {'name': 'Nature Seafoam', 'color': const Color(0xFF20B2AA)},
      {'name': 'Nature Palm', 'color': const Color(0xFF2E8B57)},
      {'name': 'Nature Rose', 'color': const Color(0xFFDC143C)},
      {'name': 'Nature Violet', 'color': const Color(0xFF8B008B)},
      {'name': 'Nature Lavender', 'color': const Color(0xFF7B68EE)},
      {'name': 'Nature Mint', 'color': const Color(0xFF98FB98)},
      {'name': 'Nature Coral', 'color': const Color(0xFFFF6F61)},
      {'name': 'Nature Almond', 'color': const Color(0xFFEFDECD)},
      {'name': 'Nature Fern', 'color': const Color(0xFF4F7942)},
      {'name': 'Nature Honey', 'color': const Color(0xFFEB9605)},
      {'name': 'Nature Rain', 'color': const Color(0xFF6B8E9F)},
      {'name': 'Nature Stone', 'color': const Color(0xFF928E85)},

      // Neon Colors (180-199)
      {'name': 'Neon Red', 'color': const Color(0xFFFF073A)},
      {'name': 'Neon Blue', 'color': const Color(0xFF0044FF)},
      {'name': 'Neon Green', 'color': const Color(0xFF39FF14)},
      {'name': 'Neon Yellow', 'color': const Color(0xFFFFFF00)},
      {'name': 'Neon Pink', 'color': const Color(0xFFFF6EC7)},
      {'name': 'Neon Orange', 'color': const Color(0xFFFF5E00)},
      {'name': 'Neon Purple', 'color': const Color(0xFFB026FF)},
      {'name': 'Neon Cyan', 'color': const Color(0xFF00FFFF)},
      {'name': 'Neon Lime', 'color': const Color(0xFF32FF32)},
      {'name': 'Neon Magenta', 'color': const Color(0xFFFF00FF)},
      {'name': 'Neon Gold', 'color': const Color(0xFFFFD800)},
      {'name': 'Neon Silver', 'color': const Color(0xFFC0C0C0)},
      {'name': 'Neon Coral', 'color': const Color(0xFFFF4F50)},
      {'name': 'Neon Mint', 'color': const Color(0xFF00FFA0)},
      {'name': 'Neon Lavender', 'color': const Color(0xFFCE96FF)},
      {'name': 'Neon Peach', 'color': const Color(0xFFFFAB40)},
      {'name': 'Neon Turquoise', 'color': const Color(0xFF40E0D0)},
      {'name': 'Neon Cherry', 'color': const Color(0xFFFF0040)},
      {'name': 'Neon Lemon', 'color': const Color(0xFFFFFF00)},
      {'name': 'Neon Grape', 'color': const Color(0xFF6A0DAD)},

      // Material Design Colors (200-219)
      {'name': 'Material Red 50', 'color': const Color(0xFFFFEBEE)},
      {'name': 'Material Red 100', 'color': const Color(0xFFFFCDD2)},
      {'name': 'Material Red 200', 'color': const Color(0xFFEF9A9A)},
      {'name': 'Material Red 300', 'color': const Color(0xFFE57373)},
      {'name': 'Material Red 400', 'color': const Color(0xFFEF5350)},
      {'name': 'Material Red 500', 'color': const Color(0xFFF44336)},
      {'name': 'Material Red 600', 'color': const Color(0xFFE53935)},
      {'name': 'Material Red 700', 'color': const Color(0xFFD32F2F)},
      {'name': 'Material Red 800', 'color': const Color(0xFFC62828)},
      {'name': 'Material Red 900', 'color': const Color(0xFFB71C1C)},
      {'name': 'Material Blue 50', 'color': const Color(0xFFE3F2FD)},
      {'name': 'Material Blue 100', 'color': const Color(0xFFBBDEFB)},
      {'name': 'Material Blue 200', 'color': const Color(0xFF90CAF9)},
      {'name': 'Material Blue 300', 'color': const Color(0xFF64B5F6)},
      {'name': 'Material Blue 400', 'color': const Color(0xFF42A5F5)},
      {'name': 'Material Blue 500', 'color': const Color(0xFF2196F3)},
      {'name': 'Material Blue 600', 'color': const Color(0xFF1E88E5)},
      {'name': 'Material Blue 700', 'color': const Color(0xFF1976D2)},
      {'name': 'Material Blue 800', 'color': const Color(0xFF1565C0)},
      {'name': 'Material Blue 900', 'color': const Color(0xFF0D47A1)},

      // More Vibrant Colors (220-239)
      {'name': 'Electric Blue', 'color': const Color(0xFF7DF9FF)},
      {'name': 'Hot Pink', 'color': const Color(0xFFFF69B4)},
      {'name': 'Tangerine', 'color': const Color(0xFFFF9966)},
      {'name': 'Lime Green', 'color': const Color(0xFF32CD32)},
      {'name': 'Royal Blue', 'color': const Color(0xFF4169E1)},
      {'name': 'Tomato', 'color': const Color(0xFFFF6347)},
      {'name': 'Plum', 'color': const Color(0xFFDDA0DD)},
      {'name': 'Turquoise', 'color': const Color(0xFF40E0D0)},
      {'name': 'Salmon', 'color': const Color(0xFFFA8072)},
      {'name': 'Khaki', 'color': const Color(0xFFF0E68C)},
      {'name': 'Cyan', 'color': const Color(0xFF00BCD4)},
      {'name': 'Indigo', 'color': const Color(0xFF4B0082)},
      {'name': 'Chartreuse', 'color': const Color(0xFF7FFF00)},
      {'name': 'Orchid', 'color': const Color(0xFFDA70D6)},
      {'name': 'Wheat', 'color': const Color(0xFFF5DEB3)},
      {'name': 'Thistle', 'color': const Color(0xFFD8BFD8)},
      {'name': 'Bisque', 'color': const Color(0xFFFFE4C4)},
      {'name': 'Blanched Almond', 'color': const Color(0xFFFFEBCD)},
      {'name': 'Antique White', 'color': const Color(0xFFFAEBD7)},
      {'name': 'Beige', 'color': const Color(0xFFF5F5DC)},

      // Additional Rainbow Colors (240-259)
      {'name': 'Rainbow Red', 'color': const Color(0xFFFF4433)},
      {'name': 'Rainbow Orange', 'color': const Color(0xFFFF8833)},
      {'name': 'Rainbow Amber', 'color': const Color(0xFFFFAA33)},
      {'name': 'Rainbow Yellow', 'color': const Color(0xFFFFFF33)},
      {'name': 'Rainbow Chartreuse', 'color': const Color(0xFFAAFF33)},
      {'name': 'Rainbow Green', 'color': const Color(0xFF33FF55)},
      {'name': 'Rainbow Teal', 'color': const Color(0xFF33FFAA)},
      {'name': 'Rainbow Cyan', 'color': const Color(0xFF33FFFF)},
      {'name': 'Rainbow Azure', 'color': const Color(0xFF3388FF)},
      {'name': 'Rainbow Blue', 'color': const Color(0xFF3333FF)},
      {'name': 'Rainbow Violet', 'color': const Color(0xFF8833FF)},
      {'name': 'Rainbow Purple', 'color': const Color(0xFFFF33FF)},
      {'name': 'Rainbow Magenta', 'color': const Color(0xFFFF3388)},
      {'name': 'Rainbow Pink', 'color': const Color(0xFFFF3388)},
      {'name': 'Rainbow Rose', 'color': const Color(0xFFFF3366)},
      {'name': 'Rainbow Crimson', 'color': const Color(0xFFDC143C)},
      {'name': 'Rainbow Scarlet', 'color': const Color(0xFFFF2400)},
      {'name': 'Rainbow Vermilion', 'color': const Color(0xFFE34234)},
      {'name': 'Rainbow Carmine', 'color': const Color(0xFF960018)},
      {'name': 'Rainbow Ruby', 'color': const Color(0xFFE0115F)},

      // Gradient Base Colors (260-279)
      {'name': 'Gradient Sunrise', 'color': const Color(0xFFFF6B6B)},
      {'name': 'Gradient Sunset', 'color': const Color(0xFFFFA07A)},
      {'name': 'Gradient Dusk', 'color': const Color(0xFF4B0082)},
      {'name': 'Gradient Dawn', 'color': const Color(0xFFFFD700)},
      {'name': 'Gradient Noon', 'color': const Color(0xFF87CEEB)},
      {'name': 'Gradient Midnight', 'color': const Color(0xFF191970)},
      {'name': 'Gradient Ocean', 'color': const Color(0xFF006994)},
      {'name': 'Gradient Forest', 'color': const Color(0xFF228B22)},
      {'name': 'Gradient Desert', 'color': const Color(0xFFC2B280)},
      {'name': 'Gradient Arctic', 'color': const Color(0xFFE0FFFF)},
      {'name': 'Gradient Tropical', 'color': const Color(0xFF00CED1)},
      {'name': 'GradientAutumn', 'color': const Color(0xFFD2691E)},
      {'name': 'Gradient Winter', 'color': const Color(0xFFB0E0E6)},
      {'name': 'Gradient Spring', 'color': const Color(0xFF98FB98)},
      {'name': 'Gradient Summer', 'color': const Color(0xFFFFD700)},
      {'name': 'Gradient Candy', 'color': const Color(0xFFFFB6C1)},
      {'name': 'Gradient Berry', 'color': const Color(0xFF8B008B)},
      {'name': 'Gradient Lemon', 'color': const Color(0xFFFFF44F)},
      {'name': 'Gradient Cherry', 'color': const Color(0xFFFF0040)},
      {'name': 'Gradient Grape', 'color': const Color(0xFF6A0DAD)},

      // Additional Popular Colors (280-299)
      {'name': 'Pure White', 'color': const Color(0xFFFFFFFF)},
      {'name': 'Pure Black', 'color': const Color(0xFF000000)},
      {'name': 'Off White', 'color': const Color(0xFFFAF9F6)},
      {'name': 'Charcoal', 'color': const Color(0xFF36454F)},
      {'name': 'Slate', 'color': const Color(0xFF708090)},
      {'name': 'Snow', 'color': const Color(0xFFFFFAFA)},
      {'name': 'Ivory', 'color': const Color(0xFFFFFFF0)},
      {'name': 'Azure', 'color': const Color(0xFFF0FFFF)},
      {'name': 'Alice Blue', 'color': const Color(0xFFF0F8FF)},
      {'name': 'Ghost White', 'color': const Color(0xFFF8F8FF)},
      {'name': 'Honeydew', 'color': const Color(0xFFF0FFF0)},
      {'name': 'Lavender Blush', 'color': const Color(0xFFFFF0F5)},
      {'name': 'Misty Rose', 'color': const Color(0xFFE6E6FA)},
      {'name': 'Papaya Whip', 'color': const Color(0xFFFFEFD5)},
      {'name': 'Sea Shell', 'color': const Color(0xFFFFF5EE)},
      {'name': 'White Smoke', 'color': const Color(0xFFF5F5F5)},
      {'name': 'Gainsboro', 'color': const Color(0xFFDCDCDC)},
      {'name': 'Light Gray', 'color': const Color(0xFFD3D3D3)},
      {'name': 'Medium Gray', 'color': const Color(0xFF808080)},
      {'name': 'Dark Gray', 'color': const Color(0xFF404040)},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Background Color'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.black,
          tabs: const [
            Tab(text: 'Colors List'),
            Tab(text: 'Manual Adjust'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Colors List Tab
          Column(
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search colors (e.g., pink, dark, light...)',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {
                                _searchQuery = '';
                              });
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: _getFilteredColors(colors).isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.color_lens_outlined,
                                  size: 64, color: Colors.grey.shade400),
                              const SizedBox(height: 16),
                              Text(
                                'No colors found for "$_searchQuery"',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Try searching for: pink, dark, light, red, blue, green, etc.',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 1.8,
                          ),
                          itemCount: _getFilteredColors(colors).length,
                          itemBuilder: (context, index) {
                            final colorData = _getFilteredColors(colors)[index];
                            return GestureDetector(
                              onTap: () {
                                _showColorAdjustmentPopup(context,
                                    colorData['color'], colorData['name']);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: colorData['color'],
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: Colors.grey.shade400, width: 1),
                                ),
                                child: Center(
                                  child: Text(
                                    colorData['name'],
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color:
                                          _getContrastColor(colorData['color']),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ),
            ],
          ),

          // Manual Adjust Tab
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Adjust Color Manually',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),

                // Color Preview
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: _manualColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade400, width: 2),
                  ),
                  child: Center(
                    child: Text(
                      'Preview',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: _getContrastColor(_manualColor),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Hue Slider
                const Text('Hue (Color)',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                Slider(
                  value: _hue,
                  min: 0,
                  max: 360,
                  activeColor: HSLColor.fromAHSL(1.0, _hue, 1.0, 0.5).toColor(),
                  onChanged: (value) {
                    setState(() {
                      _hue = value;
                    });
                  },
                ),

                const SizedBox(height: 10),

                // Saturation Slider
                const Text('Saturation',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                Slider(
                  value: _saturation,
                  min: 0,
                  max: 1,
                  activeColor: _manualColor,
                  onChanged: (value) {
                    setState(() {
                      _saturation = value;
                    });
                  },
                ),

                const SizedBox(height: 10),

                // Lightness Slider (Brightness/Darkness)
                const Text('Brightness / Darkness',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                Slider(
                  value: _lightness,
                  min: 0.05,
                  max: 0.95,
                  activeColor: _manualColor,
                  onChanged: (value) {
                    setState(() {
                      _lightness = value;
                    });
                  },
                ),

                const Spacer(),

                // Apply Button
                ElevatedButton(
                  onPressed: () {
                    widget.onColorSelected(_manualColor);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _manualColor,
                    foregroundColor: _getContrastColor(_manualColor),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Apply This Color',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getContrastColor(Color color) {
    final luminance = color.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }

  void _showColorAdjustmentPopup(
      BuildContext context, Color initialColor, String colorName) {
    double adjustHue = 0;
    double adjustSaturation = 0;
    double adjustLightness = 0;

    // Get HSL values from initial color
    HSLColor hsl = HSLColor.fromColor(initialColor);
    double baseHue = hsl.hue;
    double baseSaturation = hsl.saturation;
    double baseLightness = hsl.lightness;

    Color adjustedColor = initialColor;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            // Calculate adjusted color
            adjustedColor = HSLColor.fromAHSL(
              1.0,
              (baseHue + adjustHue) % 360,
              (baseSaturation + adjustSaturation).clamp(0.0, 1.0),
              (baseLightness + adjustLightness).clamp(0.05, 0.95),
            ).toColor();

            return AlertDialog(
              title: Text('Adjust $colorName'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Color Preview
                    Container(
                      height: 80,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: adjustedColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      child: Center(
                        child: Text(
                          'Preview',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _getContrastColor(adjustedColor),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Hue Shift
                    const Text('Color Shift',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    Slider(
                      value: adjustHue,
                      min: -180,
                      max: 180,
                      onChanged: (value) {
                        setDialogState(() {
                          adjustHue = value;
                        });
                      },
                    ),

                    // Saturation Adjustment
                    const Text('Intensity',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    Slider(
                      value: adjustSaturation,
                      min: -0.5,
                      max: 0.5,
                      onChanged: (value) {
                        setDialogState(() {
                          adjustSaturation = value;
                        });
                      },
                    ),

                    // Lightness (Brightness/Darkness)
                    const Text('Brightness / Darkness',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    Slider(
                      value: adjustLightness,
                      min: -0.45,
                      max: 0.45,
                      onChanged: (value) {
                        setDialogState(() {
                          adjustLightness = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.onColorSelected(adjustedColor);
                    Navigator.pop(context); // Close dialog
                    Navigator.pop(context); // Close color page
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: adjustedColor,
                    foregroundColor: _getContrastColor(adjustedColor),
                  ),
                  child: const Text('Apply'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
