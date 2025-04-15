// Pantalla Principal de Administración
import 'package:flutter/material.dart';

class AdminMainScreen extends StatelessWidget {
  const AdminMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel de Administración'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1.2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            _buildAdminCard(
              context: context,
              icon: Icons.category,
              title: 'Categorías',
              count: 15,
              onTap: () => _navigateToEntityList(context, 'Categorías'),
            ),
            _buildAdminCard(
              context: context,
              icon: Icons.text_snippet,
              title: 'Palabras',
              count: 342,
              onTap: () => _navigateToEntityList(context, 'Palabras'),
            ),
            _buildAdminCard(
              context: context,
              icon: Icons.people,
              title: 'Usuarios',
              count: 23,
              onTap: () => _navigateToEntityList(context, 'Usuarios'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdminCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required int count,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: isDark
              ? [Colors.deepPurple.shade800, Colors.purple.shade900]
              : [Colors.purple.shade200, Colors.deepPurple.shade200],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black54 : Colors.purple.shade100,
            blurRadius: 8,
            offset: const Offset(2, 4),
          )
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.white),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '$count registros',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToEntityList(BuildContext context, String entityType) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (_, __, ___) => EntityListPage(entityType: entityType),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOutBack,
            )),
            child: child,
          );
        },
      ),
    );
  }
}

// Pantalla de Listado de Entidades
class EntityListPage extends StatefulWidget {
  final String entityType;

  const EntityListPage({super.key, required this.entityType});

  @override
  State<EntityListPage> createState() => _EntityListPageState();
}

class _EntityListPageState extends State<EntityListPage> {
  final List<Map<String, dynamic>> _entities = List.generate(
      10,
      (index) => {
            'id': index + 1,
            // 'nombre': '${widget.entityType} ${index + 1}',
            'nombre': 'widget.entityType ${index + 1}',
            'usuario': 'admin',
            'fechaCreacion': DateTime.now().subtract(Duration(days: index)),
            'activo': index % 2 == 0,
          });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('Gestión de ${widget.entityType}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showEditForm(),
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _entities.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _buildEntityCard(_entities[index], index, isDark),
          );
        },
      ),
    );
  }

  Widget _buildEntityCard(Map<String, dynamic> entity, int index, bool isDark) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: isDark ? Colors.deepPurple.shade800 : Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () => _showEditForm(entity: entity, index: index),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    entity['nombre'],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.deepPurple,
                    ),
                  ),
                  Switch(
                    value: entity['activo'],
                    onChanged: (value) => _toggleActive(index, value),
                    activeColor: Colors.green,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Creado por: ${entity['usuario']}',
                style: TextStyle(
                  color: isDark ? Colors.white70 : Colors.grey.shade600,
                ),
              ),
              Text(
                // 'Fecha creación: ${DateFormat('dd/MM/yyyy').format(entity['fechaCreacion'])}',
                'Fecha creación: ${entity['fechaCreacion']}',
                style: TextStyle(
                  color: isDark ? Colors.white70 : Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleActive(int index, bool value) {
    setState(() {
      _entities[index]['activo'] = value;
    });
  }

  void _showEditForm({Map<String, dynamic>? entity, int? index}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => EditEntityForm(
        entity: entity,
        onSave: (editedEntity) {
          if (index != null) {
            setState(() => _entities[index] = editedEntity);
          }
        },
        onDelete: () {
          if (index != null) {
            setState(() => _entities.removeAt(index));
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}

// Formulario de Edición
class EditEntityForm extends StatefulWidget {
  final Map<String, dynamic>? entity;
  final Function(Map<String, dynamic>)? onSave;
  final VoidCallback? onDelete;

  const EditEntityForm({super.key, this.entity, this.onSave, this.onDelete});

  @override
  State<EditEntityForm> createState() => _EditEntityFormState();
}

class _EditEntityFormState extends State<EditEntityForm> {
  late TextEditingController _nameController;
  late bool _isActive;
  late DateTime _creationDate;

  @override
  void initState() {
    super.initState();
    _nameController =
        TextEditingController(text: widget.entity?['nombre'] ?? '');
    _isActive = widget.entity?['activo'] ?? true;
    _creationDate = widget.entity?['fechaCreacion'] ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.deepPurple.shade900 : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 24,
        right: 24,
        top: 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Nombre',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 16),
          ListTile(
            title: const Text('Activo'),
            trailing: Switch(
              value: _isActive,
              onChanged: (value) => setState(() => _isActive = value),
            ),
          ),
          ListTile(
            title: const Text('Fecha de creación'),
            // subtitle: Text(DateFormat('dd/MM/yyyy').format(_creationDate)),
            subtitle: Text(_creationDate.toString()),
            trailing: IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _creationDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                );
                if (date != null) {
                  setState(() => _creationDate = date);
                }
              },
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              final editedEntity = {
                'nombre': _nameController.text,
                'activo': _isActive,
                'fechaCreacion': _creationDate,
                'usuario': 'admin',
              };
              widget.onSave?.call(editedEntity);
              Navigator.pop(context);
            },
            child: const Text('Guardar Cambios'),
          ),
          if (widget.entity != null)
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Eliminar Registro'),
                    content: const Text(
                        '¿Estás seguro de eliminar este registro permanentemente?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () {
                          widget.onDelete?.call();
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: const Text('Eliminar',
                            style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Eliminar Registro',
                  style: TextStyle(color: Colors.red)),
            ),
        ],
      ),
    );
  }
}
