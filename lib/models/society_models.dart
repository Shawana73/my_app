// Data Models for Digital Housing Society Admin Panel
// Location: lib/models/society_models.dart

enum ApplicantStatus { pending, verified, rejected }
enum PlotStatus { available, booked, allocated }
enum PaymentStatus { pending, verified, rejected }

class Applicant {
  final String id;
  final String name;
  final String cnic;
  final String email;
  final String phone;
  final String documentUrl;
  final String sector;
  final ApplicantStatus status;
  final String applicationDate;

  Applicant({
    required this.id,
    required this.name,
    required this.cnic,
    required this.email,
    required this.phone,
    required this.documentUrl,
    required this.sector,
    required this.status,
    required this.applicationDate,
  });

  Applicant copyWith({ApplicantStatus? status}) {
    return Applicant(
      id: this.id,
      name: this.name,
      cnic: this.cnic,
      email: this.email,
      phone: this.phone,
      documentUrl: this.documentUrl,
      sector: this.sector,
      status: status ?? this.status,
      applicationDate: this.applicationDate,
    );
  }
}

class Plot {
  final String id;
  final String size;
  final String location;
  final double price;
  final String description;
  final PlotStatus status;

  Plot({
    required this.id,
    required this.size,
    required this.location,
    required this.price,
    required this.description,
    required this.status,
  });

  Plot copyWith({PlotStatus? status, String? size, String? location, double? price, String? description}) {
    return Plot(
      id: this.id,
      size: size ?? this.size,
      location: location ?? this.location,
      price: price ?? this.price,
      description: description ?? this.description,
      status: status ?? this.status,
    );
  }
}

class Payment {
  final String transactionId;
  final String applicantName;
  final String plotId;
  final double amount;
  final String date;
  final String receiptUrl;
  final PaymentStatus status;

  Payment({
    required this.transactionId,
    required this.applicantName,
    required this.plotId,
    required this.amount,
    required this.date,
    required this.receiptUrl,
    required this.status,
  });

  Payment copyWith({PaymentStatus? status}) {
    return Payment(
      transactionId: this.transactionId,
      applicantName: this.applicantName,
      plotId: this.plotId,
      amount: this.amount,
      date: this.date,
      receiptUrl: this.receiptUrl,
      status: status ?? this.status,
    );
  }
}

class BallotWinner {
  final Applicant applicant;
  final Plot plot;
  final String ballotId;
  final String drawDate;

  BallotWinner({
    required this.applicant,
    required this.plot,
    required this.ballotId,
    required this.drawDate,
  });
}

class Dealer {
  final String id;
  final String name;
  final String agencyName;
  final String phone;
  final String email;
  final String cnic;
  final String regNo;
  final bool isVerified;

  Dealer({
    required this.id,
    required this.name,
    required this.agencyName,
    required this.phone,
    required this.email,
    required this.cnic,
    required this.regNo,
    required this.isVerified,
  });
}
