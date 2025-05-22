import 'package:mawhebtak/core/exports.dart';

class DropdownTextFieldWidget<T> extends StatefulWidget {
  const DropdownTextFieldWidget({
    super.key,
    required this.dataLists,
    required this.hintText,
    required this.onChanged,
    this.displayText,
  });

  final List<T> dataLists;
  final String hintText;
  final Function(T) onChanged;
  final String Function(T)? displayText;

  @override
  State<DropdownTextFieldWidget<T>> createState() =>
      _DropdownTextFieldWidgetState<T>();
}

class _DropdownTextFieldWidgetState<T>
    extends State<DropdownTextFieldWidget<T>> {
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _key = GlobalKey();
  final TextEditingController _controller = TextEditingController();
  OverlayEntry? _overlayEntry;

  bool _isDropdownOpen = false;
  T? selectedItem;

  void _toggleDropdown() {
    if (_isDropdownOpen) {
      _overlayEntry?.remove();
      _isDropdownOpen = false;
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _overlayEntry = _createOverlayEntry();
        Overlay.of(context, rootOverlay: true).insert(_overlayEntry!);
        _isDropdownOpen = true;
      });
    }
  }


  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = _key.currentContext!.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height + 5,
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 5),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(10.r),
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: widget.dataLists.map((item) {
                final itemText =
                    widget.displayText?.call(item) ?? item.toString();
                return ListTile(
                  title: Text(itemText),
                  onTap: () {
                    _controller.text = itemText;
                    selectedItem = item;
                    widget.onChanged(item);
                    _toggleDropdown();
                    setState(() {});
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Container(
        key: _key,
        child: CustomTextField(
          controller: _controller,
          hintText: widget.hintText,
          hintTextSize: 18.sp,
          enabled: false,
          onTap: _toggleDropdown,
          suffixIcon: const Icon(Icons.keyboard_arrow_down_sharp, color: Colors.blue),
        ),
      ),
    );
  }
}
