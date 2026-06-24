import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';

class HireMeScreen extends StatelessWidget {
  const HireMeScreen({super.key});

  static const _email = 'christiangil2705@hotmail.com';
  static const _phone = '829-276-5204';
  static const _github = 'https://github.com/chrisfelixgil';
  static const _linkedin = 'https://www.linkedin.com/in/christianfgilc';

  Future<void> _openLink(BuildContext context, Uri uri) async {
    var launched = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
    if (!launched) {
      launched = await launchUrl(uri, mode: LaunchMode.platformDefault);
    }
    if (!context.mounted) return;
    if (!launched) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo abrir el enlace')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Contrátame'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Icon(
              Icons.fingerprint,
              color: AppColors.portalGreen.withValues(alpha: 0.85),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          Responsive.of(context).horizontalPadding,
          8,
          Responsive.of(context).horizontalPadding,
          24,
        ),
        child: ResponsiveContent(
          maxWidth: Responsive.of(context).cardMaxWidth,
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              const _ProfileCard(),
              const SizedBox(height: 20),
              _ContactTile(
                icon: Icons.email_outlined,
                label: _email,
                onTap: () => _openLink(
                  context,
                  Uri(scheme: 'mailto', path: _email),
                ),
              ),
              const SizedBox(height: 12),
              _ContactTile(
                icon: Icons.phone_outlined,
                label: _phone,
                onTap: () => _openLink(
                  context,
                  Uri(scheme: 'tel', path: '8292765204'),
                ),
              ),
              const SizedBox(height: 12),
              _ContactTile(
                icon: Icons.code,
                label: 'github.com/chrisfelixgil',
                onTap: () => _openLink(context, Uri.parse(_github)),
              ),
              const SizedBox(height: 12),
              _ContactTile(
                icon: Icons.business_center_outlined,
                label: 'linkedin.com/in/christianfgilc',
                onTap: () => _openLink(context, Uri.parse(_linkedin)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.portalGreen.withValues(alpha: 0.35),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.portalGreen.withValues(alpha: 0.12),
            blurRadius: 24,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.portalGreen, width: 3),
              boxShadow: [
                BoxShadow(
                  color: AppColors.portalGreen.withValues(alpha: 0.45),
                  blurRadius: 16,
                ),
              ],
            ),
            child: const CircleAvatar(
              radius: 62,
              backgroundImage: AssetImage('assets/images/christian.jpg'),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Christian Gil',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: AppColors.portalGreen,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: Divider(
                  color: AppColors.portalGreen.withValues(alpha: 0.35),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Icon(
                  Icons.fingerprint,
                  size: 18,
                  color: AppColors.portalGreen.withValues(alpha: 0.7),
                ),
              ),
              Expanded(
                child: Divider(
                  color: AppColors.portalGreen.withValues(alpha: 0.35),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          RichText(
            text: const TextSpan(
              style: TextStyle(fontSize: 16, color: AppColors.textPrimary),
              children: [
                TextSpan(text: 'Matrícula: '),
                TextSpan(
                  text: '2012-1036',
                  style: TextStyle(color: AppColors.portalBlue),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactTile extends StatelessWidget {
  const _ContactTile({
    required this.label,
    required this.onTap,
    required this.icon,
  });

  final String label;
  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.card,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: AppColors.portalGreen.withValues(alpha: 0.15),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.portalGreen.withValues(alpha: 0.15),
                  border: Border.all(
                    color: AppColors.portalGreen.withValues(alpha: 0.35),
                  ),
                ),
                child: Icon(icon, color: AppColors.portalGreen, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: AppColors.textSecondary.withValues(alpha: 0.7),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
