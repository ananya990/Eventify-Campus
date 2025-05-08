import 'package:flutter/material.dart';
import '../models/event_model.dart';
import 'eventdetailspage2.dart';

class EventDescriptionPage extends StatelessWidget {
  final Event event;

  const EventDescriptionPage({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          'Event Details',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Event Image
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.network(
                      event.imageUrl,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Free or \$ Paid',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Event Info
              Row(
                children: [
                  const EventChip(label: 'In 2 Days', color: Colors.purple),
                  const SizedBox(width: 8),
                  Text(
                    '${event.time} · ${event.location}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                event.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              const Text('Club Name', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 8),

              // Avatars + Register
              Row(
                children: [
                  const _Avatar(
                    url:
                        'https://storage.googleapis.com/a1aa/image/SZqAbqfK_GjsVf9-jnFtW_-qdoSlEU2VfMMZ39XKfIc.jpg',
                  ),
                  const _Avatar(
                    url:
                        'https://storage.googleapis.com/a1aa/image/VV_fCEXYcT7DwbD09Mxj7s81WU2G8bq89u2z_vDGEqE.jpg',
                  ),
                  const _Avatar(
                    url:
                        'https://storage.googleapis.com/a1aa/image/fxoolKY9hlQWUzUWh0LOxfCfnLw3bZW0Rv8H-Xu37pA.jpg',
                  ),
                  const _Avatar(
                    url:
                        'https://storage.googleapis.com/a1aa/image/kI2dCAzONFMCj2XkVMP50kwWQFlfMw5Ov6qpS2GvuTo.jpg',
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const EventDetailsPage2(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                    ),
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.white, // Text color set to white
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Description
              const Text(
                'Event Description',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                event.description,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EventChip extends StatelessWidget {
  final String label;
  final Color color;
  const EventChip({super.key, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final String url;
  const _Avatar({required this.url});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: CircleAvatar(backgroundImage: NetworkImage(url)),
    );
  }
}
