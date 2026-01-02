import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            title: const Text('GoRouter Testing Example'),
            floating: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Card.filled(
                  color: Colors.blue.withOpacity(0.1),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.blue.shade300),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            'To learn how to mock GoRouter for testing, check the /test folder',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue.shade100,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Navigation Methods',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 12),
                _NavigationCard(
                  icon: Icons.arrow_forward,
                  title: 'go()',
                  description: 'Navigate to /details',
                  onTap: () => context.go('/details'),
                ),
                _NavigationCard(
                  icon: Icons.label,
                  title: 'goNamed()',
                  description: 'Navigate to details',
                  onTap: () => context.goNamed('details'),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Stack Methods',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 12),
                _NavigationCard(
                  icon: Icons.add_circle_outline,
                  title: 'push()',
                  description: 'Push /details',
                  onTap: () => context.push('/details'),
                ),
                _NavigationCard(
                  icon: Icons.add_circle,
                  title: 'pushNamed()',
                  description: 'Push details',
                  onTap: () => context.pushNamed('details'),
                ),
                _NavigationCard(
                  icon: Icons.arrow_back,
                  title: 'pop()',
                  description: 'Go back (if possible)',
                  onTap: () {
                    if (context.canPop()) {
                      context.pop();
                    }
                  },
                  enabled: context.canPop(),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Generic Methods',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 12),
                _NavigationCard(
                  icon: Icons.add_box,
                  title: 'push<bool>()',
                  description: 'Push with return type',
                  onTap: () => context.push<bool>('/details'),
                ),
                _NavigationCard(
                  icon: Icons.logout,
                  title: 'pop<String>()',
                  description: 'Pop with result',
                  onTap: () {
                    if (context.canPop()) {
                      context.pop<String>('Result from Home');
                    }
                  },
                  enabled: context.canPop(),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Replacement Methods',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 12),
                _NavigationCard(
                  icon: Icons.swap_horiz,
                  title: 'pushReplacement()',
                  description: 'Replace with /details',
                  onTap: () => context.pushReplacement('/details'),
                ),
                _NavigationCard(
                  icon: Icons.swap_horizontal_circle,
                  title: 'pushReplacementNamed()',
                  description: 'Replace with details',
                  onTap: () => context.pushReplacementNamed('details'),
                ),
                _NavigationCard(
                  icon: Icons.change_circle,
                  title: 'replace()',
                  description: 'Replace with /details',
                  onTap: () => context.replace('/details'),
                ),
                _NavigationCard(
                  icon: Icons.change_circle_outlined,
                  title: 'replaceNamed()',
                  description: 'Replace with details',
                  onTap: () => context.replaceNamed('details'),
                ),
                const SizedBox(height: 16),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavigationCard extends StatelessWidget {
  const _NavigationCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
    this.enabled = true,
  });

  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        enabled: enabled,
        leading: Icon(icon),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(description),
        trailing: const Icon(Icons.chevron_right),
        onTap: enabled ? onTap : null,
      ),
    );
  }
}
