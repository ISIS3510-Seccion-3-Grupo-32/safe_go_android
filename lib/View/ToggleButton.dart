import 'package:flutter/material.dart';

const List<Widget> languages = <Widget>[
  Text('English'),
  Text('Español'),
  Text('French')
];

class ToggleButton extends StatefulWidget {
  const ToggleButton({
    Key? key,
  }) : super(key: key);

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  final List<bool> _selectedLanguage = <bool>[true, false, false];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // ToggleButtons with a single selection.
            Text('Language', style: theme.textTheme.titleSmall),
            const SizedBox(height: 5),
            ToggleButtons(
              direction: Axis.horizontal,
              onPressed: (int index) {
                setState(() {
                  // The button that is tapped is set to true, and the others to false.
                  for (int i = 0; i < _selectedLanguage.length; i++) {
                    _selectedLanguage[i] = i == index;
                  }
                });
              },
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              selectedBorderColor: Colors.red[700],
              selectedColor: Colors.white,
              fillColor: Colors.red[200],
              color: Colors.red[400],
              constraints: const BoxConstraints(
                minHeight: 40.0,
                minWidth: 80.0,
              ),
              isSelected: _selectedLanguage,
              children: languages,
            ),
          ],
        ),
      ),
    );
  }
}
