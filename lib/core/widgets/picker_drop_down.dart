import '../exports.dart';
import 'custom_text_form_field.dart';

class PriceDropdownTextField extends StatefulWidget {
  const PriceDropdownTextField({super.key,required this.prices});
  final List<String> prices ;

  @override
  State<PriceDropdownTextField> createState() => _PriceDropdownTextFieldState();
}

class _PriceDropdownTextFieldState extends State<PriceDropdownTextField> {
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _key = GlobalKey();
  final TextEditingController _controller = TextEditingController();
  OverlayEntry? _overlayEntry;

  bool _isDropdownOpen = false;

  void _toggleDropdown() {
    if (_isDropdownOpen) {
      _overlayEntry?.remove();
      _isDropdownOpen = false;
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _overlayEntry = _createOverlayEntry();
        Overlay.of(context)?.insert(_overlayEntry!);
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
              children:widget. prices.map((price) {
                return ListTile(
                  title: Text(price),
                  onTap: () {
                    _controller.text = price;
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
          hintText: '1000',
          hintTextSize: 18.sp,
          enabled: true,
          onTap: _toggleDropdown,

          suffixIcon: InkWell(
            onTap: _toggleDropdown,
            child: const Icon(Icons.keyboard_arrow_down_sharp),
          ),
        ),

      ),
    );
  }
}
