// lib/models.dart

enum Status { pending, verified, rejected }

class Applicant {
  final String id;
  final String name;
  final String cnic;
  final String phone;
  final String email;
  final String requestedSector;
  Status status;

  Applicant({
    required this.id,
    required this.name,
    required this.cnic,
    required this.phone,
    required this.email,
    required this.requestedSector,
    this.status = Status.pending,
  });
}

class Payment {
  final String id;
  final String txId;
  final String applicantName;
  final double amount;
  final String date;
  final String plotNo;
  final String receiptImage;
  Status status;

  Payment({
    required this.id,
    required this.txId,
    required this.applicantName,
    required this.amount,
    required this.date,
    required this.plotNo,
    required this.receiptImage,
    this.status = Status.pending,
  });
}

enum PlotStatus { available, booked, allocated }

class Plot {
  final String id;
  final String size;
  final String location;
  final double price;
  final PlotStatus status;
  final String description;

  Plot({
    required this.id,
    required this.size,
    required this.location,
    required this.price,
    required this.status,
    required this.description,
  });
}

class Dealer {
  final String id;
  final String agencyName;
  final String corporatePartner;
  final String cell;
  final String cnic;
  Status status;

  Dealer({
    required this.id,
    required this.agencyName,
    required this.corporatePartner,
    required this.cell,
    required this.cnic,
    this.status = Status.pending,
  });
}

class AppNotification {
  final String id;
  final String title;
  final String description;
  final String time;
  bool isRead;

  AppNotification({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    this.isRead = false,
  });
}
