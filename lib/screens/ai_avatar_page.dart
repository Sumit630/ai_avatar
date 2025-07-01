import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

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
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<UserProvider>(context, listen: false);
    provider.fetchUsers(); // Fetch only once here
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

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
                controller: TextEditingController(text: ''),
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
                    ? const Center(child: CircularProgressIndicator(color: Colors.blue))
                    : userProvider.filteredUsers.isEmpty
                    ? Center(child: Text("No users match filters.", style: inter.medium.get16.black))
                    : ListView.separated(
                  itemCount: userProvider.filteredUsers.length,
                  separatorBuilder: (_, __) => Divider(color: AppColors.colorTextFilBorder),
                  itemBuilder: (context, index) {
                    final user = userProvider.filteredUsers[index];
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AiAvatarDetailsPage(user: user),
                          ),
                        );
                      },
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          user.imageLarge,
                          width: 40.w,
                          height: 40.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(user.fullName, style: inter.bold.get16.black),
                      subtitle: Text('${user.age} • ${user.country}', style: inter.regular.get12),
                      trailing: Text("51 m", style: inter.regular.get12),
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
