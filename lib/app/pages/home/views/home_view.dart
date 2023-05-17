import 'package:flutter_svg/svg.dart';
import 'package:foodapp/app/core.dart';
import 'package:flutter/material.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LimitedScaleFactor(
      child: _buildBody(context),
    );
  }

  void _roomOnClick(int index) {
    controller.roomClick(index);
  }

  void _chapterClick(int index, ChapterModel chapter) {
    controller.chapterClick(chapter);
    controller.keyChapter.currentState?.closeDrawer();
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      key: controller.keyChapter,
      backgroundColor: AppColors.defaultBackground,
      drawer: _drawerChapter(context),
      appBar: AppBar(
        backgroundColor: AppColors.main.shade300,
        iconTheme: const IconThemeData(color: AppColors.white),
        centerTitle: true,
        title: Text(S.of(context).cntt),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(AssetsConst.homeGarden),
            const SizedBox(height: 20),
            _mainHome(context),
            const SizedBox(height: 20),
            Center(
              child: SvgPicture.asset(
                AssetsConst.dot,
                height: 50,
              ),
            ),
            // _voucherWidget(context),
          ],
        ),
      ),
    );
  }

  Widget _mainHome(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: AppColors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _mainItem(
            context,
            AssetsConst.room1,
            "Room 1",
            0,
          ),
          const SizedBox(width: 80),
          _mainItem(
            context,
            AssetsConst.room2,
            "Room 2",
            1,
          ),
        ],
      ),
    );
  }

  Widget _mainItem(BuildContext context, String icon, String name, int index) {
    return GestureDetector(
      onTap: () {
        _roomOnClick(index);
      },
      child: Column(
        children: [
          SvgPicture.asset(
            icon,
            height: 60,
          ),
          const SizedBox(height: 10),
          Text(
            name,
            style: AppTextStyles.body1(),
          ),
        ],
      ),
    );
  }

  Widget _voucherWidget(BuildContext context) {
    List<String> vouchers = [
      AssetsConst.voucher,
      AssetsConst.voucher,
      AssetsConst.voucher,
      AssetsConst.voucher,
      AssetsConst.voucher
    ];
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              S.of(context).news,
              style: AppTextStyles.subHeading1().copyWith(
                color: AppColors.main.shade300,
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 110,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, int index) {
                  return SvgPicture.asset(vouchers[index]);
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(width: 0),
                itemCount: vouchers.length),
          )
        ],
      ),
    );
  }

  Widget _drawerChapter(BuildContext context) {
    return Drawer(
      child: Scaffold(
        backgroundColor: AppColors.main.shade300,
        body: Padding(
          padding: const EdgeInsets.only(top: 70),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  controller.logoutClick();
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).logout,
                      style: AppTextStyles.heading2().copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Icon(
                      Icons.logout,
                      color: AppColors.black,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              controller.subjectModel != null &&
                      controller.subjectModel!.chapters != null
                  ? Column(
                      children: controller.subjectModel!.chapters!
                          .asMap()
                          .entries
                          .map((e) {
                        return _itemChapter(
                            context,
                            controller.subjectModel!.chapters![e.key],
                            e.key, () {
                          _chapterClick(
                              e.key, controller.subjectModel!.chapters![e.key]);
                        });
                      }).toList(),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemChapter(
    BuildContext context,
    ChapterModel chapter,
    int index,
    void Function()? handle,
  ) {
    return GestureDetector(
      onTap: handle,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.white, width: 1),
          ),
        ),
        child: Center(
          child: Text(
            chapter.nameChapter ?? "",
            style: AppTextStyles.heading2().copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
