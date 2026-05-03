"use strict";
const isPhone = (value) => {
  const reg = /^[1][3-9][0-9]{9}$/;
  if (!reg.test(value)) {
    return false;
  } else {
    return true;
  }
};
const validateIdentityCard = (value) => {
  const accountreg = /(^\d{15}$)|(^\d{17}(\d|X|x)$)/g;
  if (value === void 0 || value === "") {
    return false;
  } else if (!accountreg.test(value)) {
    return false;
  } else {
    return true;
  }
};
exports.isPhone = isPhone;
exports.validateIdentityCard = validateIdentityCard;
