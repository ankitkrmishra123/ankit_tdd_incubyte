class StringCalculator {

  int add(String numbers) {

     if(numbers.isEmpty) return 0;
     List<String> delimiters = [',', '\n'];
     String numbersPart = numbers;

     // custom delimiter
     if (numbers.startsWith('//')) {
       final delimiterEnd = numbers.indexOf('\n');
       final delimiterSection = numbers.substring(2, delimiterEnd);

       // Multiple delimiters case
       if (delimiterSection.startsWith('[') && delimiterSection.endsWith(']')) {
         final regex = RegExp(r'\[(.*?)\]');
         delimiters = regex.allMatches(delimiterSection).map((m) => m.group(1)!).toList();
       } else {
         delimiters = [delimiterSection];
       }

       numbersPart = numbers.substring(delimiterEnd + 1);
     }

     final delimiterPattern = delimiters.map(RegExp.escape).join('|');
     final tokens = numbersPart.split(RegExp(delimiterPattern));

     List<int> nums = [];
     List<int> negatives = [];

     for (var token in tokens) {
       if (token.trim().isEmpty) continue;
       int num = int.parse(token.trim());
       if (num < 0) negatives.add(num);
       nums.add(num);
     }

     if (negatives.isNotEmpty) {
       throw Exception("negative numbers not allowed ${negatives.join(",")}");
     }

     return nums.fold(0, (acc, val) => acc + val);

  }

}


