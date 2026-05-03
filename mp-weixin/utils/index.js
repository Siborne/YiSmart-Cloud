"use strict";
const common_vendor = require("../common/vendor.js");
const addZero = (s) => {
  return s < 10 ? "0" + s : s;
};
const getTate = (val, time) => {
  const timeVal = val.split(".");
  const year = timeVal[0];
  const month = timeVal[1];
  const day = timeVal[2];
  let m = null;
  if (time === void 0) {
    m = year + "-" + month + "-" + day + ":00";
  } else {
    m = year + "-" + month + "-" + day + " " + time + ":00";
  }
  return m;
};
const getNow = (val) => {
  let date = new Date(val);
  let y = date.getFullYear();
  let m = date.getMonth() + 1;
  let d = date.getDate();
  return addZero(y) + "." + addZero(m) + "." + addZero(d);
};
const getNowMonth = (val) => {
  return val.replace("-", ".");
};
const getTime = (val) => {
  let date = new Date(val);
  let h = date.getHours();
  let min = date.getMinutes();
  return addZero(h) + ":" + addZero(min);
};
const getAllTime = (val) => {
  let date = new Date(val);
  let y = date.getFullYear();
  let m = date.getMonth() + 1;
  let d = date.getDate();
  let h = date.getHours();
  let min = date.getMinutes();
  let sec = date.getSeconds();
  return addZero(y) + "." + addZero(m) + "." + addZero(d) + " " + addZero(h) + ":" + addZero(min) + ":" + addZero(
    sec
  );
};
const timeToSec = (time) => {
  if (time != null) {
    let s = "";
    let hour = time.split(":")[0];
    let min = time.split(":")[1];
    s = Number(hour) * 60 + Number(min);
    return s;
  }
};
const getTateTime = (time) => {
  const t = time.replace(/\./g, "/");
  return t;
};
const getTSec = (time) => {
  const timeVal = time.split(".");
  const year = timeVal[0];
  const month = timeVal[1];
  const day = timeVal[2];
  return year + "/" + month + "/" + day;
};
const getDsec = (time) => {
  const times = getTSec(time);
  const sec = new Date(times).getTime();
  return sec;
};
const tostTip = (val) => {
  common_vendor.index.showToast({
    title: val,
    icon: "none",
    background: "#ffaa00",
    duration: 1500,
    position: "bottom"
  });
};
function decimalsReplenish(value) {
  value = typeof value === "string" ? Number(value) : value;
  if (!value)
    return "0.00";
  value = value.toFixed(2);
  const intPart = Math.trunc(value);
  let intPartFormat = intPart.toString().replace(/(\d)(?=(?:\d{3})+$)/g, "$1,");
  if (intPartFormat.indexOf(",") !== -1) {
    intPartFormat = intPartFormat.split(",").join("");
  }
  let floatPart = ".00";
  const value2Array = value.split(".");
  if (value2Array.length === 2) {
    floatPart = value2Array[1].toString();
    if (floatPart.length === 1) {
      return `${intPartFormat}.${floatPart}0`;
    }
    return `${intPartFormat}.${floatPart}`;
  }
  return intPartFormat + floatPart;
}
const warnBlank = (val) => {
  let data = "";
  if (val.detail !== void 0 && val.detail.value !== void 0) {
    data = val.detail.value;
  } else {
    data = val;
  }
  return data.replace(/\s/g, "");
};
exports.addZero = addZero;
exports.decimalsReplenish = decimalsReplenish;
exports.getAllTime = getAllTime;
exports.getDsec = getDsec;
exports.getNow = getNow;
exports.getNowMonth = getNowMonth;
exports.getTate = getTate;
exports.getTateTime = getTateTime;
exports.getTime = getTime;
exports.timeToSec = timeToSec;
exports.tostTip = tostTip;
exports.warnBlank = warnBlank;
