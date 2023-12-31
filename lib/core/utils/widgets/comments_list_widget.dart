import 'package:creen/core/themes/enums.dart';
import 'package:creen/core/utils/constants.dart';
import 'package:creen/core/utils/widgets/report_dialog.dart';
import 'package:creen/features/profile/viewModel/profile/profile_cubit.dart';
import 'package:creen/features/subject/repo/delete_comment_from_post_repo.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../features/drawer/presentaion/pages/naviigation_drawer.dart';
import '../../../features/reports/viewModel/createReport/create_report_cubit.dart';
import '../../../features/subject/model/blogs_model.dart';
import '../../../features/subject/view/widgets/comment_item.dart';
import '../responsive/sizes.dart';
import 'box_helper.dart';
import 'custom_awesome_dialog.dart';
bool editing = false;
class CommentsListWidget extends StatefulWidget {
   CommentsListWidget({
    Key? key,
    required this.comments,
    required this.isLike,
    required this.likesCount,
    required this.commentController,
    required this.commentFocus,
    required this.onSendComment,
    required this.onLike,
    this.onDelete  ,
  }) : super(key: key);
  final List<Comment>? comments;
  final bool? isLike;
  final String? likesCount;
  final TextEditingController commentController;
  final FocusNode commentFocus;
  final void Function() onSendComment;
  final void Function() onLike;
  final  Function()? onDelete ;

  @override
  State<CommentsListWidget> createState() => _CommentsListWidgetState();
}

class _CommentsListWidgetState extends State<CommentsListWidget> {
  late ProfileCubit pro;
  // late DeleteCommentCubit deleteComment;
  @override
  void initState() {
    pro = context.read<ProfileCubit>()..getProfile(context);

    // deleteComment = context.read<DeleteCommentCubit>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print("HelperFunctions.currentUser?.profile ${HelperFunctions.currentUser?.profile}");
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30.r),
        topRight: Radius.circular(30.r),
      ),
      child: Scaffold(
        drawer: const NavigationDrawer(),
        body: Container(
/*
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.black, Colors.black45],
                  begin: Alignment.topRight,
                  end: Alignment.topLeft,
                  tileMode: TileMode.clamp)),
*/
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  height: Sizes.screenHeight() * 0.87,
                  margin: EdgeInsets.only(bottom: Sizes.screenHeight() * 0.005),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: ()=>Navigator.of(context).pop(),
                                  child: Icon(Icons.close),
                                ),
                                Text('التعليقات  ${widget.comments?.length}'),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      widget.likesCount == null
                                          ? '0'
                                          : widget.likesCount.toString(),
                                    ),
                                  ].reversed.toList(),
                                ),
                              ],
                            ),
                          ),
                          const BoxHelper(
                            height: 5,
                          ),
                          ...List.generate(widget.comments!.length, (index) {
                            var comment = widget.comments![index];
                           /* print(
                                "comment profile ==> ${comment.user?.profile}");
                            print("comment ==> ${comment.comment}");
                            print("comment name ==> ${comment.user?.name}");
                            print("comment user id ==> ${comment.userId}");
                            print("comment user id ==> ${comment.userName}");
                            // print("comment user id ==> ${comment.}");
                            print("comment user id ==> ${comment.user?.id}");
*/
                            return CommentItem
                              (
                              userId: comment.userId,
                              text: comment.comment,
                              // image: comment.user?.profile?.toString() ?? '',
                              image: /*(comment.user?.id == HelperFunctions.currentUser?.id && comment.logo != null)?comment.logo:*/
                                  comment.logo,
                              // name: comment.user?.name,
                              name: /*(comment.user?.id == HelperFunctions.currentUser?.id && comment.userName != null)?comment.userName:*/
                                  comment.userName,
                              deleteIconTap: ()async{
                               await deleteCommentFromPost(context,commentId: comment.id,commentsList: widget.comments);
                                    // deleteComment.deleteCommentFromPost()
                                /*if(widget.onDelete != null) {
                                  widget.onDelete !() ;
                                }*/
                                // comment.id
                              }, editingIconTap: () {
                              widget.commentFocus.requestFocus();
                              widget.commentController.text = comment.comment !;
                              editing = true;

                            },
                              reportIconTap: () {

                                showDialog(
                                  context: context,
                                  builder: (context) =>
                                      BlocProvider(
                                        create: (context) => CreateReportCubit(),
                                        child: ReportDialog(
                                          reportType: ReportType.comment,
                                          reportTypeId: comment.id,
                                        ),
                                      ),
                                );
                              },
                            );
                          })
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.r),
                      child: CircleAvatar(
                        radius: 20.r,
                        backgroundColor: Colors.white,
                        backgroundImage: pro.profileData?.profile == null ||
                                pro.profileData?.profile.isEmpty == true
                            ? const AssetImage(
                                personProfile)
                            : NetworkImage(pro.profileData?.profile)
                                as ImageProvider,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(left: 4.r),
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        // width: Sizes.screenWidth() * 0.8,
                        height: Sizes.screenHeight() * 0.07,
                        decoration:  BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        child: TextField(
                          cursorColor: Colors.black,
                          controller: widget.commentController,
                          focusNode: widget.commentFocus,
                          onTap: (){
                            editing = false;
                            print("create comment");
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'أضف تعليق',
                            // suffix: InkWell(child: Icon(Icons.emoji_emotions)),
                            suffixIcon: InkWell(child: Icon(Icons.emoji_emotions_outlined,color: Color.fromARGB(255, 35, 131, 38),)),
                          ),
                        ),
                        // const Text('أضف تعليق'),
                      ),
                    ),
                    InkWell(
                      onTap: () => widget.onSendComment(),
                      child: const CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.send,
                          color: Color.fromARGB(255, 35, 131, 38),
                        ),
                      ),
                    ),
                    const BoxHelper(
                      width: 3,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Future<void> deleteCommentFromPost(BuildContext context,{required int? commentId,List<Comment>? commentsList})async{
    CustomAwesomeDialog().showOptionsDialog(
      context: context,
      // message: 'logout_confirm'.translate,
      message: 'do you want to delete this comment',
      btnOkText: 'delete',
      btnCancelText: 'cancel',
      onConfirm: () async{
        await DeleteCommentFromPostRepo.deleteCommentFromPost(
            context,
            commentId:commentId
        ).then((value) {
          print("delete Comment from post response ===> $value");
          setState(() {
            commentsList!.removeWhere((element) => element.id == commentId);
          });
          Fluttertoast.showToast(msg: "Comment deleted successfully");
        }).catchError((e)=>Fluttertoast.showToast(msg: "refresh the main view and try deleting again"));

      },
      type: DialogType.warning,
    );


  }
}

