import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../models/user_model.dart';
import '../../../common/app_theme_extras.dart';

class UserFormWidget extends StatefulWidget {
  final User? initialUser;
  final Function(User user) onSave;

  const UserFormWidget({
    Key? key,
    this.initialUser,
    required this.onSave,
  }) : super(key: key);

  @override
  State<UserFormWidget> createState() => _UserFormWidgetState();
}

class _UserFormWidgetState extends State<UserFormWidget> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nomController;
  late final TextEditingController _prenomController;
  late final TextEditingController _adresseController;
  late final TextEditingController _dateController;

  DateTime? _selectedDate;

  bool get _isEditing => widget.initialUser != null;

  @override
  void initState() {
    super.initState();

    _nomController = TextEditingController(
      text: widget.initialUser?.nom ?? '',
    );
    _prenomController = TextEditingController(
      text: widget.initialUser?.prenom ?? '',
    );
    _adresseController = TextEditingController(
      text: widget.initialUser?.adresse ?? '',
    );

    _selectedDate = widget.initialUser?.dateDeNaissance;
    _dateController = TextEditingController(
      text: _selectedDate == null
          ? ''
          : DateFormat('dd/MM/yyyy').format(_selectedDate!),
    );
  }

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _adresseController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final now = DateTime.now();
    final initial = _selectedDate ?? DateTime(now.year - 25);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(1900),
      lastDate: now,
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez sélectionner une date de naissance'),
        ),
      );
      return;
    }

    final userId = _isEditing
        ? widget.initialUser!.id
        : DateTime.now().millisecondsSinceEpoch.toString();

    final newUser = User(
      id: userId,
      nom: _nomController.text.trim(),
      prenom: _prenomController.text.trim(),
      dateDeNaissance: _selectedDate!,
      adresse: _adresseController.text.trim(),
    );

    widget.onSave(newUser);
  }

  InputDecoration _inputDecoration(
    BuildContext context, {
    required String label,
    String? hint,
    Widget? suffixIcon,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final extras = theme.extension<AppThemeExtras>();
    final textTheme = theme.textTheme;

    final radius = extras?.radiusMd ?? 10.0;
    final fillColor = extras?.inputBackground ?? colorScheme.surface;
    final borderColor = colorScheme.outline.withOpacity(0.3);
    final focusColor = colorScheme.primary;

    OutlineInputBorder buildBorder(Color color) {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(
          color: color,
          width: 1.2,
        ),
      );
    }

    return InputDecoration(
      labelText: label,
      hintText: hint,
      labelStyle: textTheme.bodyMedium?.copyWith(
        color: theme.hintColor,
      ),
      filled: true,
      fillColor: fillColor,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      border: buildBorder(borderColor),
      enabledBorder: buildBorder(borderColor),
      focusedBorder: buildBorder(focusColor),
      suffixIcon: suffixIcon,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Nom
          TextFormField(
            controller: _nomController,
            decoration: _inputDecoration(context, label: 'Nom'),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Veuillez entrer un nom';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),

          // Prénom
          TextFormField(
            controller: _prenomController,
            decoration: _inputDecoration(context, label: 'Prénom'),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Veuillez entrer un prénom';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),

          // Date de naissance
          GestureDetector(
            onTap: () => _selectDate(context),
            child: AbsorbPointer(
              child: TextFormField(
                controller: _dateController,
                decoration: _inputDecoration(
                  context,
                  label: 'Date de naissance',
                  hint: 'Sélectionnez une date',
                  suffixIcon: const Icon(Icons.calendar_today, size: 20),
                ),
                validator: (value) {
                  if (_selectedDate == null) {
                    return 'Veuillez sélectionner une date de naissance';
                  }
                  return null;
                },
              ),
            ),
          ),
          const SizedBox(height: 16.0),

          // Adresse
          TextFormField(
            controller: _adresseController,
            decoration: _inputDecoration(context, label: 'Adresse'),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Veuillez entrer une adresse';
              }
              return null;
            },
          ),
          const SizedBox(height: 24.0),

          // Bouton de validation
          SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    (Theme.of(context).extension<AppThemeExtras>()?.radiusLg) ??
                        12.0,
                  ),
                ),
                textStyle: textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              child: Text(
                _isEditing ? 'Modifier l’utilisateur' : 'Créer l’utilisateur',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
