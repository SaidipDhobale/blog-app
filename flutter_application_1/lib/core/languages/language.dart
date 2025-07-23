import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectLanguageWidget extends StatelessWidget {
  final void Function(Locale locale) onLanguageSelected;
  final Locale selectedLocale;

  const SelectLanguageWidget({
    super.key,
    required this.onLanguageSelected,
    required this.selectedLocale,
  });

  @override
  Widget build(BuildContext context) {
    final local=AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
           local.selectLanguage,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          LanguageTile(
            icon: Icons.language,
            title: "English",
            subtitle: "Change language to English",
            isSelected: selectedLocale.languageCode == 'en',
            onTap: () => onLanguageSelected(const Locale('en')),
          ),
          LanguageTile(
            icon: Icons.translate,
            title: "हिंदी",
            subtitle: "ऐप की भाषा हिंदी करें",
            isSelected: selectedLocale.languageCode == 'hi',
            onTap: () => onLanguageSelected(const Locale('hi')),
          ),
          LanguageTile(
            icon: Icons.translate,
            title: "मराठी",
            subtitle: "अ‍ॅपची भाषा मराठी करा",
            isSelected: selectedLocale.languageCode == 'mr',
            onTap: () => onLanguageSelected(const Locale('mr')),
          ),
        ],
      ),
    );
  }
}

class LanguageTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isSelected;

  const LanguageTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isSelected ? Colors.blue.shade100 : Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: isSelected ? 4 : 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? Colors.blueAccent : Colors.blue,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Colors.blue[800] : Colors.black,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: isSelected ? Colors.blue[700] : Colors.grey[700],
          ),
        ),
        trailing: isSelected
            ? const Icon(Icons.check_circle, color: Colors.blue)
            : const Icon(Icons.circle_outlined,),
        onTap: onTap,
      ),
    );
  }
}
