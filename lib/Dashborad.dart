import 'package:flutter/material.dart';

class Complaint {
  final String id;
  final String details;
  String status;
  final List<String> history;

  Complaint({required this.id, required this.details, required this.status, required this.history});
}

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<Complaint> complaints = [
    Complaint(id: "C001", details: "Issue with billing", status: "Pending", history: ["Submitted"]),
    Complaint(id: "C002", details: "Product issue", status: "Resolved", history: ["Submitted", "In Progress", "Resolved"]),
  ];

  void updateStatus(Complaint complaint, String newStatus) {
    setState(() {
      complaint.status = newStatus;
      complaint.history.add(newStatus);
    });

    // Here you would trigger an email/SMS notification using a service like Firebase, Twilio, etc.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Dashboard"),
        backgroundColor: Colors.green, // Green color for the app bar
      ),
      body: ListView.builder(
        itemCount: complaints.length,
        itemBuilder: (context, index) {
          final complaint = complaints[index];
          return Card(
            margin: EdgeInsets.all(10),
            color: Colors.green[50], // Light green background for each card
            child: ListTile(
              title: Text("Complaint ID: ${complaint.id}", style: TextStyle(color: Colors.green)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Details: ${complaint.details}"),
                  Text("Status: ${complaint.status}", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                  SizedBox(height: 5),
                  ElevatedButton(
                    onPressed: () {
                      // Update status to "In Progress" (for demonstration)
                      updateStatus(complaint, "In Progress");
                    },
                    child: Text("Update Status"),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.green, // White text color
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // View complaint history
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HistoryLogPage(complaint: complaint)),
                      );
                    },
                    child: Text("View History Log", style: TextStyle(color: Colors.green)),
                  ),
                  // DAQ Button

                  // Feedback Button

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class HistoryLogPage extends StatelessWidget {
  final Complaint complaint;

  HistoryLogPage({required this.complaint});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("History Log for ${complaint.id}"), backgroundColor: Colors.green),
      body: ListView.builder(
        itemCount: complaint.history.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("Status changed to: ${complaint.history[index]}"),
          );
        },
      ),
    );
  }
}
