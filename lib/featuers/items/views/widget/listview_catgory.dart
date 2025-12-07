import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/featuers/items/manager/categorie_cubit/categorie_cubit.dart';
import '../../../../core/utiles/app_colors.dart';
import '../../../../core/utiles/app_textstyle.dart';
import '../../../../core/widgets/CircleItemShimmer.dart';
import '../../../home/views/widgets/bestseller_circle_item.dart';
import '../../manager/categorie_cubit/categorie_states.dart';

class ListviewCatgory extends StatelessWidget {
  const ListviewCatgory({super.key});
  @override
  Widget build(BuildContext context){
    return BlocBuilder<CategorieCubit,CategorieStates>(
      builder: (context, state){
        final cubit = CategorieCubit.get(context);

        if(state is CategorieLoading){
          return SizedBox(
            height: 100.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 8,
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              itemBuilder: (_, __) => const CircleItemShimmer(),
            ),
          );
        }
        else if( state is CategorieSuccess){
          final cats = cubit.categories;
          return SizedBox(
            height: 100.h,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              scrollDirection: Axis.horizontal,
              itemCount: cats.length,
              itemBuilder: (context, index) {
                final category = cats[index];
                final isSelected = index == cubit.selectedIndex;

                return GestureDetector(
                  onTap: () {
                    cubit.selectCategoryByIndex(index);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                      ),
                      child: BestsellerCircleItem(
                        color: isSelected ? AppColors.primary : AppColors.grey1,
                        title: category.title ?? 'No Name',
                        imagePath: category.imagePath ?? '',
                        onTap: () {
                          cubit.selectCategoryByIndex(index);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
        else if (state is CategorieProductsSuccess || state is CategorieProductsLoading) {
          final cats = cubit.categories;
          if (cats.isEmpty) return const SizedBox.shrink();
          return SizedBox(
            height: 100.h,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              scrollDirection: Axis.horizontal,
              itemCount: cats.length,
              itemBuilder: (context, index) {
                final category = cats[index];
                final isSelected = index == cubit.selectedIndex;
                return GestureDetector(
                  onTap: () => cubit.selectCategoryByIndex(index),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                      ),
                      child: BestsellerCircleItem(
                        color: isSelected ? AppColors.primary : AppColors.grey1,
                        title: category.title ?? 'No Name',
                        imagePath: category.imagePath ?? '',
                        onTap: () => cubit.selectCategoryByIndex(index),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
        // error
        else if(state is CategorieError){
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.monstrat18smibold600.copyWith(
                      fontSize: 14.sp,
                      color: AppColors.grey1,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: () {
                      CategorieCubit.get(context).getCategorie();
                    },
                    child: const Text('retry'),
                  ),
                ],
              ),
            ),
          );
        }else{
          return const SizedBox.shrink();
        }
      },
    );
  }
}
