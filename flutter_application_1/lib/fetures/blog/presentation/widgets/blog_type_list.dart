import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_palate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class BlogTypeSelector extends StatefulWidget {
  final List<String>selectedTopics;
  final Function(List<String>) onTypeSelected;
  const BlogTypeSelector({super.key,required this.onTypeSelected,required this.selectedTopics});
  @override
  _BlogTypeSelectorState createState() => _BlogTypeSelectorState();
}

class _BlogTypeSelectorState extends State<BlogTypeSelector> {
  
  
  late Set<String> selectedTopics;

  @override
  void initState() {
    super.initState();
    selectedTopics = widget.selectedTopics.toSet();
  }

  @override
  Widget build(BuildContext context) {
        final local=AppLocalizations.of(context)!;

    final List<String> blogTypes = [local.tech, local.travel, local.food, local.health, local.lifestyle, local.finance];
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: blogTypes.length,
        itemBuilder: (context, index) {
          final topic = blogTypes[index];
          final isSelected = selectedTopics.contains(topic);

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    selectedTopics.remove(topic);
                  } else {
                    selectedTopics.add(topic);
                  }
                });

                // Call back with current selected list
                widget.onTypeSelected(selectedTopics.toList());
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? AppPallete.gradient2 : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppPallete.borderColor),
                ),
                child: Center(
                  child: Text(
                    topic,
                    style: const TextStyle(
                      
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
