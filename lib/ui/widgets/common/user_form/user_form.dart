import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../models/user_model.dart'; // Pour formater la date

class UserFormWidget extends StatefulWidget {
  final User? initialUser; // Utilisateur existant à modifier (optionnel)
  final Function(User user) onSave; // Callback pour sauvegarder l'utilisateur

  const UserFormWidget({
    Key? key,
    this.initialUser,
    required this.onSave,
  }) : super(key: key);

  @override
  State<UserFormWidget> createState() => _UserFormWidgetState();
}

class _UserFormWidgetState extends State<UserFormWidget> {
  final _formKey = GlobalKey<FormState>(); // Clé pour valider le formulaire
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _adresseController = TextEditingController();

  DateTime? _selectedDate;

  bool get _isEditing =>
      widget.initialUser != null; // Vérifie si on est en mode édition

  @override
  void initState() {
    super.initState();
    if (widget.initialUser != null) {
      _nomController.text = widget.initialUser!.nom;
      _prenomController.text = widget.initialUser!.prenom;
      _adresseController.text = widget.initialUser!.adresse;
      _selectedDate = widget.initialUser!.dateDeNaissance;
    }
  }

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _adresseController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_selectedDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Veuillez sélectionner une date de naissance')),
        );
        return;
      }

      String userId = _isEditing
          ? widget.initialUser!.id
          : DateTime.now()
              .millisecondsSinceEpoch
              .toString(); // ID simple pour démo, utilisez Uuid().v4() ou l'UID de Firebase Auth en prod

      final newUser = User(
        id: userId,
        nom: _nomController.text.trim(),
        prenom: _prenomController.text.trim(),
        dateDeNaissance: _selectedDate!,
        adresse: _adresseController.text.trim(),
      );

      widget.onSave(newUser);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          TextFormField(
            controller: _nomController,
            decoration: const InputDecoration(
              labelText: 'Nom',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer un nom';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _prenomController,
            decoration: const InputDecoration(
              labelText: 'Prénom',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer un prénom';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          GestureDetector(
            onTap: () => _selectDate(context),
            child: AbsorbPointer(
              child: TextFormField(
                controller: TextEditingController(
                  text: _selectedDate == null
                      ? ''
                      : DateFormat('dd/MM/yyyy').format(_selectedDate!),
                ),
                decoration: const InputDecoration(
                  labelText: 'Date de Naissance',
                  hintText: 'Sélectionnez une date',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
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
          TextFormField(
            controller: _adresseController,
            decoration: const InputDecoration(
              labelText: 'Adresse',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer une adresse';
              }
              return null;
            },
          ),
          const SizedBox(height: 24.0),
          ElevatedButton(
            onPressed: _submitForm,
            child: Text(_isEditing
                ? 'Modifier l\'utilisateur'
                : 'Créer l\'utilisateur'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              textStyle: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
