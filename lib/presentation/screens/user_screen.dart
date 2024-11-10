import 'package:fittracker/presentation/providers/user_Provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserScreen extends ConsumerStatefulWidget {
  static const String name = 'Usuario';

  const UserScreen({super.key});

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends ConsumerState<UserScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  int? _selectedImageId;
  final List<String> profileImages = [
    'lib/assets/images/profile1.png',
    'lib/assets/images/profile2.png',
    'lib/assets/images/profile3.png',
    'lib/assets/images/profile4.png',
    'lib/assets/images/profile5.png',
  ];

  @override
  void initState() {
    super.initState();
    final currentUser = ref.read(userProvider);
    _nameController = TextEditingController(text: currentUser?.username ?? "");
    _selectedImageId = currentUser?.idImage;
  }

  Future<void> _saveChanges() async {
    if (_formKey.currentState!.validate()) {
      final newName = _nameController.text;
      await ref.read(userProvider.notifier).updateUser(
        newName: newName,
        newImageId: _selectedImageId,
      );
      Navigator.pop(context);
    }
  }

  void _selectProfileImage() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return GridView.builder(
          padding: const EdgeInsets.all(8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemCount: profileImages.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {_selectedImageId = index + 1;});
                Navigator.pop(context);
              },
              child: CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage(profileImages[index]),
              ),
            );
          },
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Usuario"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: _selectProfileImage,
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(
                    profileImages[(_selectedImageId ?? ref.read(userProvider)?.idImage ?? 1) - 1],
                  ),
                ),
              ),
              const SizedBox(height: 20),              
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveChanges,
                child: const Text("Guardar cambios"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
