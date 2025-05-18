import 'package:mawhebtak/core/exports.dart';

class DropdownTextFieldWidget extends StatefulWidget {
   DropdownTextFieldWidget({
    super.key,
    required this.dataLists,
    required this.hintText,
    this.isWithCurrency = false,
    this.currencyList = const ["L.E", "\$US", "€EU", "£GBP"], // عملات افتراضية
  });

  final List<String> dataLists;
   bool isWithCurrency ;
  final String hintText;
  final List<String> currencyList;

  @override
  State<DropdownTextFieldWidget> createState() => _DropdownTextFieldWidgetState();
}

class _DropdownTextFieldWidgetState extends State<DropdownTextFieldWidget> {
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _key = GlobalKey();
  final TextEditingController _controller = TextEditingController();
  OverlayEntry? _overlayEntry;

  bool _isDropdownOpen = false;
  String? selectedCurrency;

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
              children: widget.dataLists.map((item) {
                return ListTile(
                  title: Text(item),
                  onTap: () {
                    _controller.text = item;
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

  void _showCurrencyPicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: widget.currencyList.map((currency) {
            return ListTile(
              title: Text(currency, style: getRegularStyle()),
              onTap: () {
                setState(() => selectedCurrency = currency);
                // إذا عندك Cubit للعملة:
                // context.read<CurrencyCubit>().changeCurrency(currency);
                Navigator.pop(context);
              },
            );
          }).toList(),
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
          enabled: true,
          onTap: _toggleDropdown,
          suffixIcon: InkWell(
            onTap:widget.isWithCurrency? _showCurrencyPicker : null,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                 if(widget.isWithCurrency==true )
                   Text(
                  selectedCurrency ?? 'L.E',
                  style: getRegularStyle(color: Colors.blue, fontSize: 14.sp),
                ),
                const Icon(Icons.keyboard_arrow_down_sharp, color: Colors.blue),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
