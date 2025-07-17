import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:provider/provider.dart';
import 'package:crypto_app/themes/myTheme_Provider.dart';

class ThemeSelectorDialog extends StatelessWidget {
  const ThemeSelectorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    final schemes = [
      FlexScheme.mandyRed,
      FlexScheme.shadYellow,
      FlexScheme.green,
    ];

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 300),
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Choose Theme",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 70,
                  width: 250,
                  child: GridView.builder(
                    itemCount: schemes.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                        ),
                    itemBuilder: (_, index) {
                      final scheme = schemes[index];
                      return GestureDetector(
                        onTap: () {
                          themeProvider.setTheme(scheme);
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                FlexColor.schemes[scheme]?.light.primary ??
                                Colors.grey,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
