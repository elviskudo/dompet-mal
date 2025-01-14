import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ShareButton extends StatelessWidget {
  final String contentToShare;

  const ShareButton({
    Key? key,
    required this.contentToShare,
  }) : super(key: key);

  void _showShareOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.width * 0.35,
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: const Text(
                  'Bagikan ke:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 90,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _ShareOption(
                      icon: Icons.message,
                      label: 'WhatsApp',
                      color: Colors.green,
                      onTap: () {
                        _shareToWhatsApp(contentToShare);
                        Navigator.pop(context);
                      },
                    ),
                    _ShareOption(
                      icon: Icons.telegram,
                      label: 'Telegram',
                      color: Colors.blue,
                      onTap: () {
                        _shareToTelegram(contentToShare);
                        Navigator.pop(context);
                      },
                    ),
                    _ShareOption(
                      icon: Icons.facebook,
                      label: 'Facebook',
                      color: Colors.indigo,
                      onTap: () {
                        _shareToFacebook(contentToShare);
                        Navigator.pop(context);
                      },
                    ),
                    _ShareOption(
                      icon: Icons.copy,
                      label: 'Copy Link',
                      color: Colors.grey,
                      onTap: () => _copyToClipboard(context, contentToShare),
                    ),
                    _ShareOption(
                      icon: Icons.more_horiz,
                      label: 'More',
                      color: Colors.orange,
                      onTap: () {
                        _shareWithDefault(contentToShare);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _shareToWhatsApp(String content) async {
    final whatsappUrl = "whatsapp://send?text=${Uri.encodeComponent(content)}";
    try {
      if (await canLaunch(whatsappUrl)) {
        await launch(whatsappUrl);
      } else {
        await Share.share(content);
      }
    } catch (e) {
      debugPrint('Error sharing to WhatsApp: $e');
      await Share.share(content);
    }
  }

  void _shareToTelegram(String content) async {
    final telegramUrl = "tg://msg?text=${Uri.encodeComponent(content)}";
    try {
      if (await canLaunch(telegramUrl)) {
        await launch(telegramUrl);
      } else {
        await Share.share(content);
      }
    } catch (e) {
      debugPrint('Error sharing to Telegram: $e');
      await Share.share(content);
    }
  }

  void _shareToFacebook(String content) async {
    try {
      final facebookUrl =
          "https://www.facebook.com/sharer/sharer.php?u=${Uri.encodeComponent(content)}";
      if (await canLaunch(facebookUrl)) {
        await launch(facebookUrl);
      } else {
        await Share.share(content);
      }
    } catch (e) {
      debugPrint('Error sharing to Facebook: $e');
      await Share.share(content);
    }
  }

  void _copyToClipboard(BuildContext context, String content) async {
    await Clipboard.setData(ClipboardData(text: content));
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Link berhasil disalin!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _shareWithDefault(String content) async {
    await Share.share(content, subject: 'Bagikan');
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.share),
      onPressed: () => _showShareOptions(context),
    );
  }
}

class _ShareOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ShareOption({
    Key? key,
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                icon,
                color: color,
                size: 30,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
