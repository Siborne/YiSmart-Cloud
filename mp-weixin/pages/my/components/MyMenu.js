"use strict";
const common_vendor = require("../../../common/vendor.js");
const _sfc_main = {
  __name: "MyMenu",
  emits: ["handleApp", "handleContract", "handleBill"],
  setup(__props, { emit }) {
    const handleApp = () => {
      emit("handleApp");
    };
    const handleContract = () => {
      emit("handleContract");
    };
    const handleBill = () => {
      emit("handleBill");
    };
    return (_ctx, _cache) => {
      return {
        a: common_vendor.o(handleApp),
        b: common_vendor.o(handleContract),
        c: common_vendor.o(handleBill)
      };
    };
  }
};
const Component = /* @__PURE__ */ common_vendor._export_sfc(_sfc_main, [["__file", "D:/project/2024/project-zhyl-xcx-uniapp-java-hongbo-v2.0/project-zhyl-xcx-uniapp-java2.0/pages/my/components/MyMenu.vue"]]);
wx.createComponent(Component);
