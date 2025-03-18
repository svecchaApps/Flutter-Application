import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/auth/firebase_auth/auth_util.dart';

double multiplicationfunction(
  double? price,
  int? count,
) {
  double res = (double.parse((price! * count!).toStringAsFixed(2)));

  return res;
}

double newCustomFunction(List<CartStruct> totalcart) {
  // write a function to add all the values in totalcart datatype struct .total
  double sum = 0;
  for (var cart in totalcart) {
    double extra = cart.total * 0.12;
    sum += cart.total + extra;
  }
  return sum;
}

double totalfunction(
  double delievery,
  double discount,
  String totalvalue,
) {
  double totalValueDouble = double.tryParse(totalvalue) ?? 0.0;

  // Correct the calculation
  double totalamount = totalValueDouble + delievery - discount;

  return totalamount;
}

String orderid() {
  String temp = math.Random().nextInt(1000000000).toString();
  return temp;
}

dynamic createJson(
  String merchantId,
  String merchantTransactionId,
  String merchantUserId,
  double amount,
  String redirectUrl,
  String mobileNumber,
  String callbackUrl,
  String email,
  String redirectMode,
) {
  return {
    "merchantId": merchantId,
    "merchantTransactionId": merchantTransactionId,
    "merchantUserId": merchantUserId,
    "amount": amount,
    "redirectUrl": redirectUrl,
    "mobileNumber": mobileNumber,
    "redirectMode": redirectMode,
    "callbackUrl": callbackUrl,
    "email": email,
    "paymentInstrument": {"type": "PAY_PAGE"}
  };
}

String? converjsonyobase64(dynamic json) {
  String jsonString = jsonEncode(json);
  String base64String = base64.encode(utf8.encode(jsonString));
  return base64String;
}

double? stringtodouble(String? inputString) {
  if (inputString == null) {
    return null;
  }

  // Try parsing the string to a double
  try {
    double convertedValue = double.parse(inputString);
    return convertedValue;
  } catch (e) {
    // If parsing fails, return null
    return null;
  }
}

double? newCustomFunction2(String paise) {
  if (paise == null) {
    return null;
  }

  try {
    double paiseValue = double.parse(paise);
    double rupeesValue = paiseValue * 100.0; // Assuming 100 paise in 1 rupee
    return rupeesValue; // Format rupees with 2 decimal places
  } catch (e) {
    // Handle parsing errors or invalid input
    return null;
  }
}

double salePrice(
  double salepercent,
  double price,
) {
  double discountAmount = price * (salepercent / 100);
  double newPrice = price - discountAmount;
  return newPrice;
}

int decrementvalue(int quantity) {
  return quantity > 0 ? quantity - 1 : 0; // Return the new total value
}

String? functiontodisplaywholenumber(double? amount) {
  if (amount == null) return null; // Handle null input

  int roundedAmount = amount.round();
  return roundedAmount.toString();
}

int incrementValue(int quantity) {
  return quantity > 0 ? quantity + 1 : 0;
}

dynamic booleanJson(bool? boolean) {
  // If the boolean value is null, return a JSON null
  if (boolean == null) {
    return jsonEncode({"value": null});
  }

  // Return the boolean value wrapped in JSON
  return jsonEncode({"value": boolean});
}

bool? newCustomFunction3(
  dynamic likedBy,
  String userId,
) {
  if (likedBy is List && likedBy.contains(userId)) {
    return true; // Return true as a string
  }

  return false;
}

bool? newCustomFunction4(
  List<dynamic>? wishlistedBy,
  String? userId,
) {
  if (wishlistedBy is List && wishlistedBy.contains(userId)) {
    return true; // Return true as a string
  }
  return false;
}

dynamic newCustomFunction5(String? inputDelivered) {
  try {
    if (inputDelivered == null || inputDelivered.isEmpty) {
      return {'error': 'Input string is null or empty'};
    }
    final jsonData = json.decode(inputDelivered);
    return jsonData; // Successfully converted JSON object
  } catch (e) {
    return {'error': 'Invalid JSON string', 'details': e.toString()};
  }
}
