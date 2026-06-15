import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import '../../services/api_config.dart';

class NotifikasiScreen extends StatefulWidget {
  const NotifikasiScreen({super.key});

  @override
  State<NotifikasiScreen> createState() => _NotifikasiScreenState();
}

class _NotifikasiScreenState extends State<NotifikasiScreen> {
  List notifications = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final idUser = prefs.getInt("idUser");

    if (idUser == null) {
      setState(() => isLoading = false);
      return;
    }

    try {
      final res = await http.get(
        Uri.parse("${ApiConfig.baseUrl}/notifikasi/user/$idUser"),
      );

      if (res.statusCode == 200) {
        setState(() {
          notifications = jsonDecode(res.body);
          notifications.sort((a, b) => b["waktu"].compareTo(a["waktu"]));
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
      }
    } catch (e) {
      print("Error fetch notifications: $e");
      setState(() => isLoading = false);
    }
  }

  Future<void> markAllAsRead() async {
    final prefs = await SharedPreferences.getInstance();
    final idUser = prefs.getInt("idUser");

    if (idUser == null) return;

    try {
      final res = await http.put(
        Uri.parse("${ApiConfig.baseUrl}/notifikasi/read-all/$idUser"),
      );

      if (res.statusCode == 200) {
        fetchNotifications();
      }
    } catch (e) {
      print("Error marking notifications as read: $e");
    }
  }

  Future<void> markAsRead(int id) async {
    try {
      final res = await http.put(
        Uri.parse("${ApiConfig.baseUrl}/notifikasi/read/$id"),
      );

      if (res.statusCode == 200) {
        fetchNotifications();
      }
    } catch (e) {
      print("Error marking notification as read: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifikasi"),
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all),
            onPressed: markAllAsRead,
            tooltip: "Tandai semua dibaca",
          )
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : notifications.isEmpty
              ? _buildEmptyState()
              : RefreshIndicator(
                  onRefresh: fetchNotifications,
                  child: ListView.builder(
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      final item = notifications[index];
                      final isRead = item["dibaca"] ?? false;

                      return Container(
                        color: isRead ? Colors.transparent : Colors.blue.withOpacity(0.05),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: _getIconColor(item["judul"]),
                            child: const Icon(Icons.notifications, color: Colors.white),
                          ),
                          title: Text(
                            item["judul"] ?? "Notifikasi",
                            style: TextStyle(
                              fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item["isi"] ?? ""),
                              const SizedBox(height: 5),
                              Text(
                                _formatWaktu(item["waktu"]),
                                style: const TextStyle(fontSize: 11, color: Colors.grey),
                              ),
                            ],
                          ),
                          onTap: () {
                            if (!isRead) {
                              markAsRead(item["id"]);
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_off_outlined, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 10),
          const Text("Tidak ada notifikasi baru", style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Color _getIconColor(String? title) {
    if (title == null) return Colors.blue;
    String t = title.toLowerCase();
    if (t.contains("peringatan") || t.contains("belum")) {
      return Colors.orange;
    }
    return Colors.blue;
  }

  String _formatWaktu(String? waktuRaw) {
    if (waktuRaw == null) return "";
    try {
      DateTime dt = DateTime.parse(waktuRaw);
      return DateFormat('dd MMM, HH:mm').format(dt);
    } catch (e) {
      return waktuRaw;
    }
  }
}
