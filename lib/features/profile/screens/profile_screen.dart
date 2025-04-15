import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEditing = false;
  // File? _imageFile;

  final TextEditingController _nameController =
      TextEditingController(text: 'Juan');
  final TextEditingController _lastnameController =
      TextEditingController(text: 'Pérez');
  final TextEditingController _dobController =
      TextEditingController(text: '1995-08-21');
  final TextEditingController _bioController = TextEditingController(
      text: 'Apasionado por los idiomas y la cultura coreana.');

  Future<void> _pickImage() async {
    /* final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }*/
  }

  //usar camara
  /*
  Future<void> _pickImage() async {
  showModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Elegir de galería'),
              onTap: () async {
                Navigator.of(context).pop();
                final XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  setState(() {
                    _imageFile = File(pickedFile.path);
                  });
                }
                
                //guardar localmente
                final XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery); // o .camera
if (pickedFile != null) {
  await _saveImageLocally(pickedFile);
}

              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Tomar una foto'),
              onTap: () async {
                Navigator.of(context).pop();
                final XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
                if (pickedFile != null) {
                  setState(() {
                    _imageFile = File(pickedFile.path);
                  });
                }
                
                //guardar localmente
                final XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery); // o .camera
if (pickedFile != null) {
  await _saveImageLocally(pickedFile);
}

              },
            ),
          ],
        ),
      );
    },
  );
}
*/

  /*
   * 
   * dependencies:
  flutter:
    sdk: flutter
  image_picker: ^1.0.4
  path_provider: ^2.0.15
  shared_preferences: ^2.2.2
*/

  //que foto se guarde localmente
  /*Future<void> _saveImageLocally(XFile pickedFile) async {
  final directory = await getApplicationDocumentsDirectory();
  final String path = directory.path;
  final String fileName = 'profile_image.png';
  final File localImage = await File(pickedFile.path).copy('$path/$fileName');

  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('profile_image_path', localImage.path);

  setState(() {
    _imageFile = localImage;
  });
}*/

  //recuperar foto
  /*
  @override
void initState() {
  super.initState();
  _loadProfileImage();
}

Future<void> _loadProfileImage() async {
  final prefs = await SharedPreferences.getInstance();
  final imagePath = prefs.getString('profile_image_path');
  if (imagePath != null) {
    setState(() {
      _imageFile = File(imagePath);
    });
  }
}*/
  /*
  
  dependencies:
  image_picker: ^1.0.4


  */

  Widget _buildTextField(String label, TextEditingController controller,
      {int maxLines = 1}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        enabled: isEditing,
        maxLines: maxLines,
        style: TextStyle(color: isDark ? Colors.white : Colors.black),
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: isDark ? Colors.grey[800] : Colors.grey[200],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          labelStyle:
              TextStyle(color: isDark ? Colors.white70 : Colors.black87),
        ),
      ),
    );
  }

  void _toggleEdit() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  void _deleteAccount() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('¿Estás seguro?'),
        content: const Text('Esta acción eliminará permanentemente tu cuenta.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              // Aquí podrías manejar la lógica de eliminación
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cuenta eliminada')),
              );
            },
            child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tu Perfil'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.save : Icons.edit),
            onPressed: _toggleEdit,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            GestureDetector(
              onTap: isEditing ? _pickImage : null,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage:
                        //_imageFile != null
                        //   ? FileImage(_imageFile!)
                        //    :
                        const NetworkImage('https://i.pravatar.cc/300')
                            as ImageProvider,
                  ),
                  if (isEditing)
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black54,
                      ),
                      padding: const EdgeInsets.all(6),
                      child: const Icon(Icons.camera_alt,
                          size: 20, color: Colors.white),
                    )
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildTextField('Nombre', _nameController),
            _buildTextField('Apellido', _lastnameController),
            _buildTextField('Fecha de nacimiento', _dobController),
            _buildTextField('Bio', _bioController, maxLines: 3),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _deleteAccount,
              icon: const Icon(Icons.delete_forever),
              label: const Text('Cerrar cuenta'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
