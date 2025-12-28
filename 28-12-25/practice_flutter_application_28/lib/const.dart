final RegExp EMAIL_VALIDATION_REGEX = RegExp(
  r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$",
);

final RegExp PASSWORD_VALIDATION_REGEX = RegExp(
  r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}$",
);

final RegExp NAME_VALIDATION_REGEX = RegExp(r"^[A-ZÀ-ÿ][A-Za-zÀ-ÿ' .-]{1,49}$");

final String PLACEHOLDER_TR =
    "https://t3.ftcdn.net/jpg/05/16/27/58/360_F_516275801_f3Fsp17x6HQk0xQgDQEELoTuERO4SsWV.jpg";
