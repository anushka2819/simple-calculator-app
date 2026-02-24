class Calculator {
  double num1 = 0;
  String op = '';
  String display = '0';
  bool newNum = false;
  String expression = '';
  bool showResult = false;

  String _formatNumber(double n) {
    if (n % 1 == 0) {
      return n.toInt().toString();
    } else {
      // Round to 4 decimal places and remove trailing zeros
      String str = n.toStringAsFixed(4);
      str = str.replaceAll(RegExp(r'0+$'), '');
      str = str.replaceAll(RegExp(r'\.$'), '');
      return str;
    }
  }

  void addDigit(String digit) {
    showResult = false;
    if (digit == '.') {
      if (!display.contains('.')) display += '.';
    } else if (digit == '00') {
      if (display != '0') display += '00';
    } else {
      if (newNum) {
        display = digit;
        newNum = false;
      } else {
        if (display == '0') display = digit;
        else display += digit;
      }
    }
    
    // Update expression as user types
    if (op.isNotEmpty) {
      expression = '${_formatNumber(num1)}$op$display';
    }
  }

  void setOp(String o) {
    showResult = false;
    if (op.isNotEmpty && !newNum) {
      calculate();
    } else if (op.isEmpty) {
      num1 = double.parse(display);
    }
    op = o;
    newNum = true;
    expression = '${_formatNumber(num1)}$op';
  }

  void calculate() {
    if (op.isEmpty) return;
    double num2 = double.parse(display);
    expression = '${_formatNumber(num1)}$op${_formatNumber(num2)}';
    
    double res = 0;
    switch (op) {
      case '+': res = num1 + num2; break;
      case '-': res = num1 - num2; break;
      case '×': res = num1 * num2; break;
      case '÷': res = num2 != 0 ? num1 / num2 : 0; break;
    }

    display = _formatNumber(res);
    num1 = res;
    op = '';
    newNum = true;
    showResult = true;
  }

  void clear() {
    num1 = 0;
    op = '';
    display = '0';
    newNum = false;
    expression = '';
    showResult = false;
  }

  void backspace() {
    showResult = false;
    if (display.length > 1) {
      display = display.substring(0, display.length - 1);
    } else {
      display = '0';
    }
    
    // Update expression as user edits
    if (op.isNotEmpty) {
      expression = '${_formatNumber(num1)}$op$display';
    }
  }

  void toggleSign() {
    double n = double.parse(display);
    display = _formatNumber(-n);
  }
}
