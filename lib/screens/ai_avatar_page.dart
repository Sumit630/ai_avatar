import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../provider/user_provider.dart';
import '../utils/color.dart';
import '../utils/cons.dart';
import '../utils/text_style.dart';
import '../wigets/drop_down.dart';
import '../wigets/search_textfild.dart';
import 'ai_avatar_details_page.dart';

class AiAvatarPage extends StatefulWidget {
  const AiAvatarPage({super.key});

  @override
  State<AiAvatarPage> createState() => _AiAvatarPageState();
}

class _AiAvatarPageState extends State<AiAvatarPage> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();

    // Fetch users once after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<UserProvider>(context, listen: false);
      provider.fetchUsers();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    // Optional: keep previous query visible
    if (_searchController.text != userProvider.searchQuery) {
      _searchController.text = userProvider.searchQuery;
      _searchController.selection = TextSelection.fromPosition(
        TextPosition(offset: _searchController.text.length),
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.colorBackGraund,
        body: Padding(
          padding: const EdgeInsets.all(defaultPadding * 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("AI Avatar Explorer", style: inter.bold.get18.black),
              2.ph,
              CustomSearchTextField(
                controller: _searchController,
                backgroundColor: AppColors.colorTextFilBG,
                onChanged: (value) {
                  userProvider.updateSearchQuery(value);
                },
              ),
              2.ph,
              Row(
                children: [
                  Expanded(
                    child: TDropDown(
                      label: "Gender",
                      items: ['Male', 'Female', 'Other'],
                      selectedValue: userProvider.selectedGender,
                      onChanged: (value) {
                        userProvider.updateGender(value);
                      },
                    ),
                  ),
                  2.pw,
                  Expanded(
                    child: TDropDown(
                      label: "Age Range",
                      items: ['18-30', '31-45', '45+'],
                      selectedValue: userProvider.selectedAgeRange,
                      onChanged: (value) {
                        userProvider.updateAgeRange(value);
                      },
                    ),
                  ),
                ],
              ),
              2.ph,
              Expanded(
                child: userProvider.isLoading
                    ? ListView.separated(
                  itemCount: 6,
                  separatorBuilder: (_, __) =>
                      Divider(color: AppColors.colorTextFilBorder),
                  itemBuilder: (context, index) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: ListTile(
                        leading: Container(
                          width: 40.w,
                          height: 40.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                        title: Container(
                          height: 16.h,
                          width: 120.w,
                          color: Colors.white,
                        ),
                        subtitle: Container(
                          height: 14.h,
                          width: 80.w,
                          margin: EdgeInsets.only(top: 8.h),
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                )
                    : userProvider.filteredUsers.isEmpty
                    ? Center(
                  child: Text(
                    "No users match filters.",
                    style: inter.medium.get16.black,
                  ),
                )
                    : ListView.separated(
                  itemCount: userProvider.filteredUsers.length,
                  separatorBuilder: (_, __) =>
                      Divider(color: AppColors.colorTextFilBorder),
                  itemBuilder: (context, index) {
                    final user = userProvider.filteredUsers[index];
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AiAvatarDetailsPage(user: user),
                          ),
                        );
                      },
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CircleAvatar(
                          radius: 20.w,
                          child: ClipOval(
                            child: Image.network(
                              user.imageLarge,
                              width: 40.w,
                              height: 40.w,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  user.gender.toLowerCase() == 'male'
                                      ? Icons.male
                                      : Icons.female,
                                  color: AppColors.colorDeemBlackOP,
                                  size: 24.w,
                                );
                              },
                            ),
                          ),
                        ),

                      ),
                      title:
                      Text(user.fullName, style: inter.bold.get16.black),
                      subtitle: Text('${user.age} • ${user.country}',
                          style: inter.regular.get12),
                      trailing:
                      Text("51 m", style: inter.regular.get12),
                    );
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
