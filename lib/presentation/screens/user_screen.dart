import 'package:fittracker/presentation/providers/user_Provider.dart';
import 'package:fittracker/utils/profile_images.dart';
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
          padding: const EdgeInsets.all(30),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
          ),
          itemCount: profileImages.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {_selectedImageId = index + 1;});
                Navigator.pop(context);
              },
              child: CircleAvatar(
                radius: 10,
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
                  radius: 60,
                  backgroundImage: AssetImage(getProfileImageById(_selectedImageId)),                  
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
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(1, 4),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child : ElevatedButton(
                  onPressed: _saveChanges,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF34D399),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                  ),
                  child: const Text("GUARDAR"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
