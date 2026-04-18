import 'package:flutter/material.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  final List<Map<String, String>> _faqs = [
    {
      "question": "Q1. What is Aapka Sarthi?",
      "answer": "Aapka Sarthi is a digital service platform designed to support vendors and citizens by providing easy access to essential services, documentation assistance, and business-related support through a single platform."
    },
    {
      "question": "Q2. Who can use Aapka Sarthi?",
      "answer": "Aapka Sarthi can be used by vendors, small business owners, and citizens who need assistance with services, certificates, or digital processes."
    },
    {
      "question": "Q3. Is Aapka Sarthi a government app?",
      "answer": "No, Aapka Sarthi is a private digital service platform that helps users access and manage services efficiently. It works as a support system and does not replace any government authority."
    },
    {
      "question": "Q4. How do I create an account on Aapka Sarthi?",
      "answer": "You can create an account through registration in registration form using 'click here' button on login page."
    },
    {
      "question": "Q5. Can I update my profile details later?",
      "answer": "Yes. You can update your personal and business details anytime from the Profile section."
    },
    {
      "question": "Q6. Who can register as a vendor?",
      "answer": "Street vendors, mobile vendors, fixed vendors, and small business operators can register on Aapka Sarthi."
    },
    {
      "question": "Q7. What type of vendors are supported?",
      "answer": "Both fixed-location vendors and mobile vendors are supported, subject to applicable rules and service availability."
    },
    {
      "question": "Q8. What documents are required for vendor services?",
      "answer": "Basic documents may include:\n• Identity proof \n • Address proof \n • Business orvending-related documents (if applicable) \n Exact requirements may vary based on the service."
    },
    {
      "question": "Q9. What is a vending certificate?",
      "answer": "A vending certificate is an official document that allows a vendor to conduct business in a permitted area as per applicable rules."
    },
    {
      "question": "Q10. How long is a vending certificate valid?",
      "answer": "The validity period is mentioned on the certificate itself."
    },
    {
      "question": "Q11. When should I apply for renewal?",
      "answer": "Vendors must apply for renewal at least one month before the expiry date of the certificate."
    },
    {
      "question": "Q12. Can I renew my certificate through Aapka Sarthi?",
      "answer": "Yes. If renewal support is available for your service area, you can apply through the app by submitting required documents."
    },
    {
      "question": "Q13. What goods or services can be sold?",
      "answer": "Vendors may sell goods or services permitted under applicable local rules. Prohibited or restricted items are not allowed."
    },
    {
      "question": "Q14. What is a vending zone?",
      "answer": "A vending zone is an area designated for vending activities, such as unrestricted or restricted vending zones."
    },
     {
      "question": "Q15. What are vending timings?",
      "answer": "Vending timings depend on local regulations and are mentioned in the vendor’s details or certificate (e.g., evening hours)."
    },
    {
      "question": "Q16. Are services on Aapka Sarthi paid?",
      "answer": "Some services may involve service charges, while others may be free. Charges, if any, are clearly shown before proceeding"
    },
    {
      "question": "Q17. What payment methods are supported?",
      "answer": "Available payment methods will be displayed in the app at the time-of-service request."
    },
    {
      "question": "Q18. Will I get a receipt for payments?",
      "answer": " A digital receipt will be available for all successful payments."
    },
    {
      "question": "Q19. how can I contact Aapka Sarthi support?",
      "answer": "You can contact support through the app or via the official contact details mentioned on the website."
    },
    {
      "question": "Q20. What should I do if my request is delayed?",
      "answer": "Please check the status in the app. If the issue persists, contact support with your request ID."
    },
    {
      "question": "Q21. How can I raise a complaint?",
      "answer": "Complaints can be raised through the support section in the app or via official communication channels."
    },
    {
      "question": "Q22. Is my data safe on Aapka Sarthi?",
      "answer": "Yes. Aapka Sarthi takes user data privacy seriously and uses appropriate security measures to protect information."
    },
    {
      "question": "Q23. Will my data be shared with others?",
      "answer": "User data is shared only when required for service delivery and as per the privacy policy."
    },
    {
      "question": "Q24. Where can I find updates or announcements?",
      "answer": "All-important updates are shared through the app and official website."
    },
    {
      "question": "Q25. What is the “Request a Callback” feature?",
      "answer": "The Request a Callback feature allows you to submit your issue or query and receive a call from an Aapka Sarthi support agent (sathi) for assistance."
    },
    {
      "question": "Q26. Who can request a callback?",
      "answer": "Any registered or unregistered user who needs help related to Aapka Sarthi services, vendor support, certificates, or general queries can request a callback."
    },
    {
      "question": "Q27. Is requesting a callback free?",
      "answer": "Yes, requesting a callback from Aapka Sarthi support is completely free."
    },
    {
      "question": "Q28. How do I request a callback?",
      "answer": "To request a callback:\n 1. Enter your full name\n 2. Enter your mobile number\n 3. Select or write the subject of your issue\n 4. Describe your issue briefly in the message box\n 5. Tap on Submit Request"
    },
    {
      "question": "Q29. What type of issues can I request a callback for?",
      "answer": "You can request a callback for:\n • ID or certificate renewal\n • Vendor-related queries\n • Application status\n • Harassment or complaint support\n • App usage or technical issues\n • General service-related questions"
    },
    {
      "question": "Q30. How soon will I receive a callback?",
      "answer": "Our support agent will contact you as soon as possible, usually within working hours, after your request is submitted."
    },
    {
      "question": "Q31.What are the working hours for callbacks?",
      "answer": "Callbacks are generally provided during official working hours. Response time may vary depending on request volume and issue type."
    },
    {
      "question": "Q32. Will I receive a confirmation after submitting the request?",
      "answer": "Yes. Once you submit the request, it is successfully recorded and forwarded to the support team for action."
    },
    {
      "question": "Q33. Can I submit multiple callback requests?",
      "answer": "Yes, but we recommend submitting only one request per issue to avoid delays or confusion."
    },
    {
      "question": "Q34. What should I write in the “Subject” field?",
      "answer": "In the Subject field, briefly mention your issue type, for example:\n • ID Renewal\n • Certificate Issue\n • Payment Query\n • Complaint / Harassment\n • Technical Support"
    },
    {
      "question": "Q35. What details should I include in the message?",
      "answer": "Please describe your issue clearly and briefly, including:\n • Type of problem\n • Relevant dates (if any)\n • Any reference or application details\n This helps the support agent assist you faster."
    },
    {
      "question": "Q36. What if I miss the callback?",
      "answer": "If you miss the callback, you may submit a new request or wait for the support team to try again based on availability."
    },
    {
      "question": "Q37. Is my information safe?",
      "answer": "Yes. Your name, phone number, and message are used only for support purposes and handled securely as per Aapka Sarthi’s privacy policy."
    },
    {
      "question": "Q38. Can I request a callback for someone else?",
      "answer": "Yes, but please ensure that the provided mobile number belongs to the person who needs support."
    },
    {
      "question": "Q39. What should I do if my issue is not resolved?",
      "answer": "If your issue is not resolved after the callback, you can submit another request or use other available support options in the app."
    },
    {
      "question": "Q40. What is the Help & Support section used for?",
      "answer": "The Help & Support section allows users to submit detailed issues or queries related to Aapka Sarthi services, payments, certificates, or app-related problems."
    },
    {
      "question": "Q41. Who can use the Help & Support form?",
      "answer": "Any user who needs assistance with Aapka Sarthi services can use the Help & Support form."
    },
    {
      "question": "Q42. How do I submit a Help & Support request?",
      "answer": "To submit a request:\n 1. Enter your full name\n 2. Enter your complete address\n 3. Enter your mobile number\n 4. Mention the subject of your issue\n 5. Describe your issue in detail\n 6. Tap on Submit"
    },
    {
      "question": "Q43. Is submitting a Help & Support request free??",
      "answer": "Yes, submitting a request through the Help & Support section is completely free."
    },
    {
      "question": "Q44. What type of issues can I raise through Help & Support?",
      "answer": "You can raise issues related to:\n • Payment problems\n • App bugs or technical issues\n • Vendor or certificate-related queries\n • Service delays\n • Complaints or grievances\n • General assistance"
    },
    {
      "question": "Q45. Why is my address required in the Help & Support form?",
      "answer": "Your address helps the support team understand your service location and provide accurate assistance when required."
    },
    {
      "question": "Q46. What should I write in the Subject field?",
      "answer": "In the Subject field, briefly mention the nature of your issue, such as:\n • Payment Issue\n • App Bug\n • Certificate Renewal\n • Vendor Support\n • Complaint"
    },
    {
      "question": "Q47. How detailed should my message be?",
      "answer": "Please describe your issue clearly and in detail, including any relevant dates, reference numbers, or background information. This helps in faster resolution."
    }, 
    {
      "question": "Q48. Will I receive a response after submitting the form?",
      "answer": "Yes. Once your request is submitted, the support team will review it and get back to you as soon as possible."
    },
    {
      "question": "Q49. How long does it take to get a response?",
      "answer": "Response time may vary depending on the nature of the issue and request volume, but the team aims to respond within a reasonable time during working hours."
    },
    {
      "question": "Q50. Can I submit more than one Help & Support request?",
      "answer": "Yes, but it is recommended to submit one request per issue to avoid confusion or delays."
    },
    {
      "question": "Q51.  Is my personal information safe?",
      "answer": "Yes. All information shared through the Help & Support form is used only for assistance purposes and is handled securely."
    },
    {
      "question": "Q52. What if my issue is urgent?",
      "answer": "For urgent issues, please clearly mention “Urgent” in the Subject field and describe the issue clearly in the message."
    },
    {
      "question": "Q53. What should I do if my issue is not resolved?",
      "answer": "If your issue remains unresolved, you may submit another request with reference to your previous submission."
    },
    {
      "question": "Q54. Do I need to be logged in to submit a Help & Support request?",
      "answer": "You may submit a Help & Support request even if you are not logged in, provided you enter valid contact details."
    },
    {
      "question": "Q55. Will I receive a call or message from support?",
      "answer": "Depending on your issue, a support agent may contact you via phone or other available communication methods."
    },
    {
      "question": "Q56. What is the Appointment feature in Aapka Sarthi?",
      "answer": "The Appointment feature allows users to book a time slot to consult or avail services such as licenses, policies, doctor consultation, advocate support, or other services."
    },
    {
      "question": "Q57. How do I book an appointment?",
      "answer": "To book an appointment:\n 1. Select a date from the calendar\n 2. Choose an available time slot\n 3. Select the service type\n 4. Enter the reason (if required)\n 5. Choose In-Person or On-Call\n 6. Tap on Submit"
    },
    {
      "question": "Q58. What services can I book an appointment for?",
      "answer": "You can book appointments for:\n • License-related services\n • Policy-related services\n• Doctor consultation\n • Advocate consultation\n • Other services (by entering the reason)"
    },
    {
      "question": "Q59. What does “Available Slots” mean?",
      "answer": "Available slots show the time periods during which appointments can be booked on the selected date."
    },
    {
      "question": "Q60. Can I book an appointment for a future date?",
      "answer": "Yes. You can select any available future date shown in the calendar and book an appointment accordingly"
    },
    {
      "question": "Q61. What happens if no slots are available on a selected date?",
      "answer": "If no slots are available, please select another date or check back later for updated availability."
    },
    {
      "question": "Q62. What is the difference between In-Person and On-Call appointments?",
      "answer": "• In-Person: You will meet the service provider physically at the designated location.\n • On-Call: The consultation will be conducted over a phone call."
    },
    {
      "question": "Q63. Is there any fee for booking an appointment?",
      "answer": "Appointment booking may be free or paid depending on the selected service. Any applicable charges will be communicated in advance."
    },
    {
      "question": "Q64. Can I cancel or reschedule my appointment?",
      "answer": "Cancellation or rescheduling depends on service availability and policies. Please contact support if you need changes"
    },
    {
      "question": "Q65. Will I receive a confirmation after booking an appointment?",
      "answer": "Yes. Once the appointment is successfully booked, you will receive a confirmation within the app."
    },
    {
      "question": "Q66.What should I write in the “Other Services” or reason field?",
      "answer": "Briefly describe the purpose of your appointment, such as:\n • Document verification\n • Certificate guidance\n • General consultation"
    },
    {
      "question": "Q67. What if I miss my appointment?",
      "answer": "If you miss your appointment, you may need to book a new slot based on availability"
    },
    {
      "question": "Q68. Can I book multiple appointments?",
      "answer": "Yes. You can book multiple appointments, but each appointment must be booked separately."
    },
    {
      "question": "Q69. Are appointments available on all days?",
      "answer": "Appointment availability depends on service providers and working schedules. Only available dates are shown in the calendar."
    },
    {
      "question": "Q70. Is my appointment information secure?",
      "answer": "Yes. All appointment details are stored securely and used only for service coordination."
    },
    {
      "question": "Q71. Whom should I contact for appointment-related issues?",
      "answer": "For any appointment-related issues, please use the Help & Support or Request Callback option in the app."
    },
    {
      "question": "Q72. What is the Licenses & Documentation section?",
      "answer": "This section provides information and support for applying, renewing, or understanding various licenses and official documents required for vendors and workers."
    },
    {
      "question": "Q73. What is a Certificate of Vending (CoV)?",
      "answer": "A Certificate of Vending (CoV) is an official document that allows street vendors to carry out vending activities in permitted areas as per applicable rules."
    },
    {
      "question": "Q74. Who needs a Certificate of Vending?",
      "answer": "Street vendors, mobile vendors, and fixed vendors operating in designated vending zones are required to have a valid Certificate of Vending."
    },
    {
      "question": "Q75. Can I apply for a Certificate of Vending through Aapka Sarthi?",
      "answer": "Aapka Sarthi provides assistance and guidance for applying or renewing a Certificate of Vending,subject to service availability in your area."
    },
    {
      "question": "Q76. What is FSSAI Food Safety Registration?",
      "answer": "FSSAI Food Safety Registration is mandatory for vendors involved in preparing, storing, or selling food items to ensure food safety standards."
    },
    {
      "question": "Q77. Who needs FSSAI registration?",
      "answer": "Any vendor or business involved in food-related activities, including street food vendors, must obtain FSSAI registration."
    },
    {
      "question": "Q78. What is a Trade License / Shop Establishment License?",
      "answer": "A Trade License or Shop Establishment License permits a business to operate legally from a fixed location as per local municipal rules."
    },
    {
      "question": "Q79. Who requires a Trade or Shop Establishment License?",
      "answer": "Shop owners, small businesses, and establishments operating from fixed premises generally require this license."
    },
    {
      "question": "Q80. What is a Hawker License?",
      "answer": "A Hawker License allows individuals to sell goods in public places under permitted conditions and locations."
    },
    {
      "question": "Q81. Is a Hawker License different from a Certificate of Vending?",
      "answer": "Yes. While both are related to vending, their applicability and issuing authorities may differ based on local regulations."
    },
    {
      "question": "Q82. What is a No Objection Certificate (NOC)?",
      "answer": "A No Objection Certificate (NOC) is an official document stating that an authority has no objection to a specific activity or operation."
    },
    {
      "question": "Q83. When is an NOC required?",
      "answer": "An NOC may be required for certain businesses, locations, or activities depending on applicable rules and regulations."
    },
    {
      "question": "Q84. What is a Labour Card / Unorganized Worker ID?",
      "answer": "A Labour Card or Unorganized Worker ID is issued to workers in the unorganized sector to help them access government welfare schemes and benefits"
    },
    {
      "question": "Q85. Who can apply for a Labour Card or Unorganized Worker ID?",
      "answer": "Workers in the unorganized sector, including daily wage workers and vendors, may apply for this identification."
    },
    {
      "question": "Q86. What documents are generally required for license-related services?",
      "answer": "Documents may include:\n • Identity proof\n • Address proof\n • Business or work-related details\n • Passport-size photograph\n Exact requirements depend on the license type."
    },
    {
      "question": "Q87. How long does it take to process license-related requests?",
      "answer": "Processing time varies based on the type of license, issuing authority, and completeness of documents."
    },
    {
      "question": "Q88. Are there any fees involved for licenses or documentation?",
      "answer": "Fees may apply as per government rules. Any service charges, if applicable, will be clearly communicated."
    },
    {
      "question": "Q89.  Can I track the status of my license or document request?",
      "answer": "If tracking is available for the service, you will be informed about the status through the app or support team."
    },
    {
      "question": "Q90. What should I do if my license expires or is about to expire?",
      "answer": "You should apply for renewal before the expiry date, preferably at least one month in advance."
    },
    {
      "question": "Q91. Whom should I contact for help related to licenses and documents?",
      "answer": "For any license or documentation-related assistance, use the Help & Support or Request Callback feature in the app"
    },
    {
      "question": "Q92. What is the Policies Information section?",
      "answer": "The Policies Information section provides details and guidance about central and state government schemes related to street vendors, workers, social security, insurance, pensions, and livelihood support."
    },
    {
      "question": "Q93. What is PM SVANidhi Scheme?",
      "answer": "PM SVANidhi (Prime Minister Street Vendor’s AtmaNirbhar Nidhi) is a government scheme that provides working capital loans to street vendors to help them restart and grow their businesses."
    },
    {
      "question": "Q94. Who is eligible for PM SVANidhi?",
      "answer": "Street vendors who were vending on or before the notified date and meet eligibility criteria as per the scheme guidelines can apply"
    },
    {
      "question": "Q95. What is the Street Vendors Act, 2014?",
      "answer": "The Street Vendors (Protection of Livelihood and Regulation of Street Vending) Act, 2014 protects the rights of street vendors and regulates vending activities through designated zones and rules."
    },
    {
      "question": "Q96. What is NULM – Support to Urban Street Vendors (SUSV)?",
      "answer": "NULM-SUSV is a program under the National Urban Livelihoods Mission that supports urban street vendors through financial assistance, skill development, and livelihood promotion."
    },
    {
      "question": "Q97. What is PM Jan Dhan Yojana?",
      "answer": "PM Jan Dhan Yojana is a financial inclusion scheme that ensures access to banking services such as savings accounts, insurance, and direct benefit transfers."
    },
    {
      "question": "Q98. What is e-Shram?",
      "answer": "e-Shram is a national database for unorganized workers that helps them access social security schemes and government benefits."
    },
    {
      "question": "Q99. Who should register on e-Shram?",
      "answer": "Unorganized sector workers, including street vendors, daily wage workers, and self-employed individuals, should register on e-Shram."
    },
    {
      "question": "Q100. What is PM Suraksha Bima Yojana (PMSBY)?",
      "answer": "PMSBY is an accident insurance scheme that provides coverage in case of accidental death or disability at an affordable premium."
    },
    {
      "question": "Q101. What is PM Jeevan Jyoti Bima Yojana (PMJJBY)?",
      "answer": "PMJJBY is a life insurance scheme that offers life cover to individuals at a low annual premium."
    },
    {
      "question": "Q102. What is Atal Pension Yojana (APY)?",
      "answer": "Atal Pension Yojana is a pension scheme designed to provide a guaranteed monthly pension to workers in the unorganized sector after retirement."
    },
    {
      "question": "Q103. What is the Madhya Pradesh Street Vendors Scheme, 2020?",
      "answer": "This scheme implements the Street Vendors Act in Madhya Pradesh and provides guidelines for vending zones, certificates, and vendor protection."
    },
    {
      "question": "Q104. What is Mukhyamantri Jan Kalyan (Sambal 2.0) Scheme?",
      "answer": "Sambal 2.0 is a Madhya Pradesh government scheme that offers social security benefits to unorganized workers, including health, education, and insurance support."
    },
    {
      "question": "Q105. What is Mukhyamantri Swarozgar / Self-Employment Scheme?",
      "answer": "This scheme supports self-employment and entrepreneurship by providing financial assistance and resources to eligible beneficiaries in Madhya Pradesh."
    },
    {
      "question": "Q106. What are MP Urban & Rural Livelihood Promotion Programs?",
      "answer": "These programs aim to promote livelihoods through skill development, employment opportunities, and income generation in urban and rural areas via ULBs and Panchayats."
    },
    {
      "question": "Q107. Can I apply for these schemes through Aapka Sarthi?",
      "answer": "Aapka Sarthi provides information, guidance, and assistance for applying to eligible schemes,subject to availability and applicable rules."
    },
    {
      "question": "Q108. Are these policies and schemes free to apply for?",
      "answer": "Most government schemes are free to apply for. Any applicable service assistance charges, if any, will be communicated clearly."
    },
    {
      "question": "Q109. How do I know which policy or scheme is suitable for me?",
      "answer": "You can explore policy details in this section or use the Help & Support or Appointment feature for guidance."
    },
    {
      "question": "Q110. Whom should I contact for policy-related assistance?",
      "answer": "For help related to any policy or scheme, please use the Help & Support or Request Callback option in the app."
    },
    

  ];

  @override
  Widget build(BuildContext context) {
    // Colors extracted from your screenshots
    const Color headerYellow = Color(0xFFFFD54F); // Mustard/Darker Yellow
    const Color bodyYellow = Color(0xFFFFF9C4);   // Pale/Light Yellow
    const Color scaffoldWhite = Colors.white;

    return Scaffold(
      backgroundColor: scaffoldWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 28),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: const Text(
          "FAQs",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: false,
        titleSpacing: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Top Heading Section ---
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Frequently Asked Questions",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Find answers to common questions about services, policies, and app usage.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 10),

          // --- Scrollable List Section ---
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              physics: const BouncingScrollPhysics(),
              itemCount: _faqs.length,
              separatorBuilder: (context, index) => const SizedBox(height: 15),
              itemBuilder: (context, index) {
                return Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Theme(
                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      collapsedBackgroundColor: headerYellow,
                      backgroundColor: headerYellow, 
                      iconColor: Colors.black87,
                      collapsedIconColor: Colors.black87,
                      textColor: Colors.black,
                      collapsedTextColor: Colors.black,
                      tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      
                      title: Text(
                        _faqs[index]["question"]!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      
                      // --- EXPANDED BODY ---
                      children: [
                        Container(
                          width: double.infinity,
                          color: bodyYellow, // The pale yellow background for text
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            _faqs[index]["answer"]!,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              height: 1.5, 
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          /// --- Bottom Spacing ---
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}