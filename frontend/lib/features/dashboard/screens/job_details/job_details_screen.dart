import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/image_strings.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/device/device_utility.dart';
import 'package:frontend/data/models/job_model.dart';
import 'package:frontend/features/dashboard/providers/job_provider.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class JobDetailsScreen extends StatefulWidget {
  const JobDetailsScreen({Key? key, required this.jobId}) : super(key: key);
  final String jobId;

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  bool showBasicInfo = true;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _basicInfoKey = GlobalKey();
  final GlobalKey _jobDescriptionKey = GlobalKey();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final jobProvider = Provider.of<JobProvider>(context, listen: false);
      jobProvider.fetchJobById(widget.jobId);
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollTo(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final jobProvider = Provider.of<JobProvider>(context);
    // Loading and error handling
    if (jobProvider.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (jobProvider.error != null) {
      return Scaffold(
        body: Center(
          child: Text(
            jobProvider.error!.message,
            style: const TextStyle(color: Colors.red, fontSize: 18),
          ),
        ),
      );
    }

    final job = jobProvider.job;

    // No job data
    if (job == null) {
      return const Scaffold(
        body: Center(
          child: Text(
            "No job data found.",
            style: TextStyle(fontSize: 18, color: Colors.black54),
          ),
        ),
      );
    }

    // Main UI
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(KDeviceUtils.getAppBarHeight()),
        child: Material(
          elevation: 0.2,
          child: AppBar(
            title: Text(
              'Job Details',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontSize: 22,
                  ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              controller: _scrollController,
              // padding: const EdgeInsets.all(16),
              children: [
                // Header Section
                Row(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        // color: Colors.grey[200],
                        border: Border.all(
                          color: KColors.grey,
                        ),
                        borderRadius: BorderRadius.circular(KSizes.md),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(KSizes.md),
                        child: CachedNetworkImage(
                          imageUrl: job.company.logo.url,
                          placeholder: (context, url) => SizedBox(
                              child: Image.asset(KImages.defaultBuilding)),
                          errorWidget: (context, url, error) =>
                              Image.asset(KImages.defaultBuilding),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          jobProvider.job!.title,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        SizedBox(height: KSizes.xs),
                        Text(
                          job.company.name,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: KSizes.md),

                // Expiry Date
                Text(
                  'Expiry date: January 25, 2025',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: KColors.primary,
                        fontSize: 13,
                      ),
                ),
                const SizedBox(height: KSizes.defaultSpace),

                // Info Items
                InfoItem(
                  icon: Iconsax.location,
                  text: job.company.location.fullAddress,
                ),
                const SizedBox(height: KSizes.md),
                InfoItem(
                  icon: Icons.work_outline_rounded,
                  text: job.type,
                ),
                const SizedBox(height: KSizes.md),
                InfoItem(
                  icon: Icons.money,
                  text: "Rs. ${job.salary.toStringAsFixed(0)}",
                ),
                SizedBox(height: KSizes.sm),

                // Tabs
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() => showBasicInfo = true);
                        _scrollTo(_basicInfoKey);
                      },
                      child: Text(
                        'Basic Information',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: showBasicInfo
                                  ? KColors.primary
                                  : KColors.black,
                            ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() => showBasicInfo = false);
                        _scrollTo(_jobDescriptionKey);
                      },
                      child: Text(
                        'Job Description',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: !showBasicInfo
                                  ? KColors.primary
                                  : KColors.black,
                            ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: KSizes.sm),

                // Basic Information Section
                BasicInformationSection(
                  key: _basicInfoKey,
                  job: job,
                ),

                const SizedBox(height: KSizes.defaultSpace),

                // Job Description Section
                JobDescriptionSection(
                  key: _jobDescriptionKey,
                  job: job,
                ),

                SizedBox(height: 80.h), // Space for bottom bar
              ],
            ),
          ),

          // Bottom Action Bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.favorite_border),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFA726),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                      ),
                      child: const Text(
                        'Apply Now',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BasicInformationSection extends StatelessWidget {
  const BasicInformationSection({Key? key, required this.job})
      : super(key: key);
  final JobModel job;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(KSizes.md),
          decoration: BoxDecoration(
            color: KColors.secondaryBackground,
            borderRadius: BorderRadius.circular(KSizes.sm),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Basic Information",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: KColors.black,
                    ),
              ),
              SizedBox(height: KSizes.sm),
              InfoRow(
                  label: 'No.Of Vacancy',
                  value: job.basicInformation.noOfVacancy.toStringAsFixed(0)),
              InfoRow(
                label: 'Location',
                value: job.location.fullAddress,
              ),
              InfoRow(
                  label: 'Salary',
                  value: "Rs. ${job.salary.toStringAsFixed(0)}"),
              InfoRow(label: 'Job Level', value: job.basicInformation.jobLevel),
              InfoRow(label: 'Job Type', value: job.type),
              InfoRow(
                  label: 'Age',
                  value:
                      "${job.basicInformation.age.min} - ${job.basicInformation.age.max}"),
              InfoRow(label: 'Gender', value: job.basicInformation.gender),
              InfoRow(
                  label: 'Education', value: job.basicInformation.education),
              InfoRow(
                  label: 'Experience',
                  value:
                      "${job.basicInformation.experience.toStringAsFixed(0)} years"),
              InfoRow(label: 'Shift', value: job.basicInformation.shift),
            ],
          ),
        ),
        SizedBox(height: KSizes.defaultSpace),
        //skills container
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(KSizes.md),
          decoration: BoxDecoration(
            color: KColors.secondaryBackground,
            borderRadius: BorderRadius.circular(KSizes.sm),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Skills",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: KColors.black,
                    ),
              ),
              SizedBox(height: KSizes.sm),
              //skills list
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: job.skills
                    .map((skill) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: KColors.lightContainer,
                            borderRadius: BorderRadius.circular(KSizes.md),
                          ),
                          child: Text(
                            skill,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: KColors.black,
                                    ),
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
        SizedBox(height: KSizes.defaultSpace),
        //Personal qualities container
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(KSizes.md),
          decoration: BoxDecoration(
            color: KColors.secondaryBackground,
            borderRadius: BorderRadius.circular(KSizes.sm),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Personal Qualities",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: KColors.black,
                    ),
              ),
              SizedBox(height: KSizes.sm),
              //personal qualities list
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: job.personalQualities
                    .map((personalQuality) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: KColors.lightContainer,
                            borderRadius: BorderRadius.circular(KSizes.md),
                          ),
                          child: Text(
                            personalQuality,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: KColors.black,
                                    ),
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),

        SizedBox(height: KSizes.defaultSpace),
        //benefits container
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(KSizes.md),
          decoration: BoxDecoration(
            color: KColors.secondaryBackground,
            borderRadius: BorderRadius.circular(KSizes.sm),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Benefits",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: KColors.black,
                    ),
              ),
              SizedBox(height: KSizes.sm),
              //benefits list
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: job.benefits
                    .map((benefit) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: KColors.lightContainer,
                            borderRadius: BorderRadius.circular(KSizes.md),
                          ),
                          child: Text(
                            benefit,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: KColors.black,
                                    ),
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class JobDescriptionSection extends StatelessWidget {
  const JobDescriptionSection({Key? key, required this.job}) : super(key: key);
  final JobModel job;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDescriptionSection(
            'Job Description',
            'We are seeking a professional Receptionist to be the first point of contact for our company. The ideal candidate will have excellent communication skills and a pleasant personality.',
          ),
          const SizedBox(height: 16),
          _buildDescriptionSection(
            'Responsibilities',
            '• Welcoming visitors and directing them to the appropriate department\n'
                '• Managing incoming calls and maintaining call records\n'
                '• Receiving and sorting daily mail/deliveries\n'
                '• Scheduling meetings and maintaining office calendar\n'
                '• Maintaining office security by following safety procedures\n'
                '• Managing office supplies inventory',
          ),
          const SizedBox(height: 16),
          _buildDescriptionSection(
            'Requirements',
            '• +2 / Intermediate Pass in any discipline\n'
                '• Excellent verbal and written communication skills in English and Nepali\n'
                '• Proficiency in MS Office applications\n'
                '• Previous experience as a Receptionist is preferred\n'
                '• Strong organizational and multitasking abilities\n'
                '• Professional appearance and friendly demeanor',
          ),
          const SizedBox(height: 16),
          _buildDescriptionSection(
            'Benefits',
            '• Competitive salary package\n'
                '• Health insurance\n'
                '• Paid leaves\n'
                '• Festival bonuses\n'
                '• Performance-based incentives\n'
                '• Training and development opportunities',
          ),
          SizedBox(height: KSizes.md),
          job.allowFreshers
              ? Text(
                  "Note: Freshers are encouraged to apply",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w700,
                        color: KColors.black,
                      ),
                )
              : SizedBox(),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

class InfoItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoItem({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: KColors.darkerGrey,
        ),
        SizedBox(width: KSizes.sm),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: KColors.darkerGrey,
                ),
          ),
        ),
      ],
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: KSizes.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          const Text(': '),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}
