"use strict";
const common_vendor = require("../../../common/vendor.js");
if (!Array) {
  const _easycom_uni_popup2 = common_vendor.resolveComponent("uni-popup");
  _easycom_uni_popup2();
}
const _easycom_uni_popup = () => "../../../uni_modules/uni-popup/components/uni-popup/uni-popup.js";
if (!Math) {
  _easycom_uni_popup();
}
const _sfc_main = {
  __name: "VisitPopup",
  setup(__props, { expose }) {
    const popup = common_vendor.ref(null);
    const handleClose = () => {
      popup.value.close();
    };
    expose({
      popup
    });
    return (_ctx, _cache) => {
      return {
        a: common_vendor.o(handleClose),
        b: _ctx.type === "left" || _ctx.type === "right" ? 1 : "",
        c: common_vendor.sr(popup, "eadbaf72-0", {
          "k": "popup"
        })
      };
    };
  }
};
const Component = /* @__PURE__ */ common_vendor._export_sfc(_sfc_main, [["__file", "D:/project/2024/project-zhyl-xcx-uniapp-java-hongbo-v2.0/project-zhyl-xcx-uniapp-java2.0/pages/index/components/VisitPopup.vue"]]);
wx.createComponent(Component);
