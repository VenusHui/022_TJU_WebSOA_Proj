import 'dart:html';

import 'package:flutter/material.dart';
import '../../pages/homepage/home_page_show.dart';
import '../loginPage/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  String location = "上海";
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Scaffold(
          backgroundColor: Color.fromRGBO(8, 11, 32, 1),
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(8, 11, 32, 1),
            leading: Container(
                child: Row(
              children: [
                Text(
                  location,
                  style: TextStyle(color: Color.fromRGBO(161, 189, 245, 1)),
                ),
                IconButton(
                  onPressed: null,
                  icon:
                      Icon(Icons.room, color: Color.fromRGBO(161, 189, 245, 1)),
                  color: Color.fromRGBO(161, 189, 245, 1),
                ),
              ],
            )),
            actions: <Widget>[
              TextButton(
                child: CircleAvatar(
                    backgroundImage: AssetImage('assets/peeps-avatar.png')),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          login_page(title: "登录"),
                    ),
                  );
                },
              ),
            ],
            title: Container(
              width: 176,
              height: 29,
              decoration: BoxDecoration(
                  color: Color.fromARGB(126, 91, 107, 139),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(161, 189, 245, 0.5),
                      offset: Offset(0, 0),
                      blurStyle: BlurStyle.inner,
                      blurRadius: 5,
                      spreadRadius: 0,
                    )
                  ]),
            ),
            bottom: TabBar(
                unselectedLabelColor: Color.fromRGBO(94, 112, 146, 1),
                indicatorColor: Color.fromRGBO(161, 189, 245, 1),
                indicatorSize: TabBarIndicatorSize.label,
                indicatorWeight: 3.0,
                labelColor: Color.fromRGBO(161, 189, 245, 1),
                tabs: [
                  Tab(text: "综合"),
                  Tab(text: "音乐剧"),
                  Tab(text: "脱口秀"),
                  Tab(text: "音乐会"),
                  Tab(text: "舞蹈"),
                ]),
          ),
          body: TabBarView(children: [
            home_page_show(),
            home_page_show(),
            home_page_show(),
            home_page_show(),
            home_page_show(),
          ]),
        ));
  }
}

// /// 搜索AppBar
// class AppBarSearch extends StatefulWidget implements PreferredSizeWidget {
//   AppBarSearch({
//     Key? key,
//     this.borderRadius = 10,
//     this.autoFocus = false,
//     this.focusNode,
//     this.controller,
//     this.height = 40,
//     this.value,
//     this.leading,
//     this.backgroundColor,
//     this.suffix,
//     this.actions = const [],
//     this.hintText,
//     this.onTap,
//     this.onClear,
//     this.onCancel,
//     this.onChanged,
//     this.onSearch,
//     this.onRightTap,
//   }) : super(key: key);
//   final double? borderRadius;
//   final bool? autoFocus;
//   final FocusNode? focusNode;
//   final TextEditingController? controller;

//   // 输入框高度 默认40
//   final double height;

//   // 默认值
//   final String? value;

//   // 最前面的组件
//   final Widget? leading;

//   // 背景色
//   final Color? backgroundColor;

//   // 搜索框内部后缀组件
//   final Widget? suffix;

//   // 搜索框右侧组件
//   final List<Widget> actions;

//   // 输入框提示文字
//   final String? hintText;

//   // 输入框点击回调
//   final VoidCallback? onTap;

//   // 清除输入框内容回调
//   final VoidCallback? onClear;

//   // 清除输入框内容并取消输入
//   final VoidCallback? onCancel;

//   // 输入框内容改变
//   final ValueChanged<String>? onChanged;

//   // 点击键盘搜索
//   final ValueChanged<String>? onSearch;

//   // 点击右边widget
//   final VoidCallback? onRightTap;

//   @override
//   _AppBarSearchState createState() => _AppBarSearchState();

//   @override
//   Size get preferredSize => Size.fromHeight(height);
// }

// class _AppBarSearchState extends State<AppBarSearch> {
//   TextEditingController? _controller;
//   FocusNode? _focusNode;

//   bool get isFocus => _focusNode?.hasFocus ?? false; //是否获取焦点

//   bool get isTextEmpty => _controller?.text.isEmpty ?? false; //输入框是否为空

//   bool get isActionEmpty => widget.actions.isEmpty; // 右边布局是否为空

//   bool isShowCancel = false;

//   @override
//   void initState() {
//     _controller = widget.controller ?? TextEditingController();
//     _focusNode = widget.focusNode ?? FocusNode();
//     if (widget.value != null) _controller?.text = widget.value ?? "";
//     // 焦点获取失去监听
//     _focusNode?.addListener(() => setState(() {}));
//     // 文本输入监听
//     _controller?.addListener(() {
//       setState(() {});
//     });
//     super.initState();
//   }

//   // 清除输入框内容
//   void _onClearInput() {
//     setState(() {
//       _controller?.clear();
//     });
//     widget.onClear?.call();
//   }

//   // 取消输入框编辑失去焦点
//   void _onCancelInput() {
//     setState(() {
//       _controller?.clear();
//       _focusNode?.unfocus(); //失去焦点
//     });
//     // 执行onCancel
//     widget.onCancel?.call();
//   }

//   Widget _suffix() {
//     if (!isTextEmpty) {
//       return InkWell(
//         onTap: _onClearInput,
//         child: SizedBox(
//           width: widget.height,
//           height: widget.height,
//           child: Icon(Icons.cancel, size: 22, color: Color(0xFF999999)),
//         ),
//       );
//     }
//     return widget.suffix ?? SizedBox();
//   }

//   List<Widget> _actions() {
//     List<Widget> list = [];
//     if (isFocus || !isTextEmpty) {
//       list.add(InkWell(
//         onTap: widget.onRightTap ?? _onCancelInput,
//         child: Container(
//           constraints: const BoxConstraints(minWidth: 48),
//           alignment: Alignment.center,
//           child: const Text('搜索',
//               style: TextStyle(
//                   color: Color.fromRGBO(300, 100, 200, 1), fontSize: 14)),
//         ),
//       ));
//     } else if (!isActionEmpty) {
//       list.addAll(widget.actions);
//     }
//     return list;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: widget.backgroundColor,
//       //阴影z轴
//       elevation: 0,
//       // 标题与其他控件的间隔
//       titleSpacing: 0,
//       leadingWidth: 40,
//       // leading: widget.leading ??
//       // InkWell(
//       //   child: Icon(
//       //     Icons.arrow_back_ios_outlined,
//       //     color: Color.fromARGB(255, 169, 130, 201),
//       //     size: 16,
//       //   ),
//       //   onTap: () {
//       //     Routes.finish(context);
//       //   },
//       // ),
//       title: Container(
//           margin: EdgeInsetsDirectional.only(end: 10),
//           height: widget.height,
//           decoration: BoxDecoration(
//             color: const Color(0xFFF2F2F2),
//             borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
//           ),
//           child: Container(
//             child: Row(
//               children: [
//                 SizedBox(
//                   width: widget.height,
//                   height: widget.height,
//                   child: Icon(Icons.search, size: 20, color: Color(0xFF999999)),
//                 ),
//                 Expanded(
//                   // 权重
//                   flex: 1,
//                   child: TextField(
//                     autofocus: widget.autoFocus ?? false,
//                     // 是否自动获取焦点
//                     focusNode: _focusNode,
//                     // 焦点控制
//                     controller: _controller,
//                     // 与输入框交互控制器
//                     //装饰
//                     decoration: InputDecoration(
//                       isDense: true,
//                       border: InputBorder.none,
//                       hintText: widget.hintText ?? '请输入关键字',
//                       hintStyle: TextStyle(
//                           fontSize: 14,
//                           color: Color.fromARGB(255, 155, 209, 124)),
//                     ),
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Color.fromARGB(255, 155, 209, 124),
//                     ),
//                     // 键盘动作右下角图标
//                     textInputAction: TextInputAction.search,
//                     onTap: widget.onTap,
//                     // 输入框内容改变回调
//                     onChanged: widget.onChanged,
//                     onSubmitted: widget.onSearch, //输入框完成触发
//                   ),
//                 ),
//                 _suffix(),
//               ],
//             ),
//           )),
//       actions: _actions(),
//     );
//   }

//   @override
//   void dispose() {
//     _controller?.dispose();
//     _focusNode?.dispose();
//     super.dispose();
//   }
// }
