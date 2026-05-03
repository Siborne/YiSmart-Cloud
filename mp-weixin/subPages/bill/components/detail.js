"use strict";
const common_vendor = require("../../../common/vendor.js");
const utils_index = require("../../../utils/index.js");
if (!Array) {
  const _easycom_uni_popup2 = common_vendor.resolveComponent("uni-popup");
  _easycom_uni_popup2();
}
const _easycom_uni_popup = () => "../../../uni_modules/uni-popup/components/uni-popup/uni-popup.js";
if (!Math) {
  _easycom_uni_popup();
}
const _sfc_main = {
  __name: "detail",
  props: {
    // 选择的时间
    baseDate: {
      type: Object,
      default: () => ({})
    },
    isPoput: {
      type: Boolean,
      default: false
    }
  },
  setup(__props, { expose }) {
    const popup = common_vendor.ref(null);
    const visible = common_vendor.ref(true);
    const handleClose = () => {
      popup.value.close();
    };
    expose({
      popup,
      visible
    });
    return (_ctx, _cache) => {
      return {
        a: common_vendor.t(__props.baseDate.totalDays),
        b: common_vendor.t(common_vendor.unref(utils_index.getNow)(__props.baseDate.billStartTime)),
        c: common_vendor.t(common_vendor.unref(utils_index.getNow)(__props.baseDate.billEndTime)),
        d: common_vendor.o(handleClose),
        e: common_vendor.t(__props.baseDate.lname),
        f: common_vendor.t(common_vendor.unref(utils_index.decimalsReplenish)(__props.baseDate.checkInConfigVo.bedCost)),
        g: common_vendor.t(__props.baseDate.typeName),
        h: common_vendor.t(common_vendor.unref(utils_index.decimalsReplenish)(__props.baseDate.checkInConfigVo.nursingCost)),
        i: common_vendor.t(common_vendor.unref(utils_index.decimalsReplenish)(__props.baseDate.checkInConfigVo.otherCost)),
        j: common_vendor.t(common_vendor.unref(utils_index.decimalsReplenish)(__props.baseDate.checkInConfigVo.medicalInsurancePayment)),
        k: common_vendor.t(common_vendor.unref(utils_index.decimalsReplenish)(__props.baseDate.checkInConfigVo.governmentSubsidy)),
        l: common_vendor.t(common_vendor.unref(utils_index.decimalsReplenish)(__props.baseDate.checkInConfigVo.monthCost)),
        m: common_vendor.t(common_vendor.unref(utils_index.decimalsReplenish)(__props.baseDate.currentCost)),
        n: common_vendor.t(common_vendor.unref(utils_index.decimalsReplenish)(__props.baseDate.depositAmount)),
        o: common_vendor.t(common_vendor.unref(utils_index.decimalsReplenish)(__props.baseDate.billAmount)),
        p: common_vendor.t(common_vendor.unref(utils_index.decimalsReplenish)(__props.baseDate.prepaidAmount)),
        q: common_vendor.t(common_vendor.unref(utils_index.decimalsReplenish)(__props.baseDate.payableAmount)),
        r: _ctx.type === "left" || _ctx.type === "right" ? 1 : "",
        s: common_vendor.sr(popup, "4dbaaa3c-0", {
          "k": "popup"
        })
      };
    };
  }
};
const Component = /* @__PURE__ */ common_vendor._export_sfc(_sfc_main, [["__file", "D:/project/2024/project-zhyl-xcx-uniapp-java-hongbo-v2.0/project-zhyl-xcx-uniapp-java2.0/subPages/bill/components/detail.vue"]]);
wx.createComponent(Component);
