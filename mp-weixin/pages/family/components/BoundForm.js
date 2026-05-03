"use strict";
const common_vendor = require("../../../common/vendor.js");
const utils_index = require("../../../utils/index.js");
const _sfc_main = {
  __name: "BoundForm",
  setup(__props, { expose }) {
    const formData = common_vendor.ref({});
    const handleInput = (e) => {
      formData.value.name = utils_index.warnBlank(e.detail.value).substring(0, 10);
    };
    const handleCard = (e) => {
      formData.value.remark = utils_index.warnBlank(e.detail.value).substring(0, 10);
    };
    const handleBlur = (e) => {
      const text = utils_index.warnBlank(e.detail.value);
      formData.value.idCard = text.substring(0, 18);
    };
    const clearFrom = () => {
      formData.value = {};
    };
    expose({
      formData,
      clearFrom
    });
    return (_ctx, _cache) => {
      return {
        a: common_vendor.o(handleInput),
        b: formData.value.name,
        c: common_vendor.o(($event) => formData.value.name = $event.detail.value),
        d: common_vendor.o(handleBlur),
        e: formData.value.idCard,
        f: common_vendor.o(($event) => formData.value.idCard = $event.detail.value),
        g: common_vendor.o(handleCard),
        h: formData.value.remark,
        i: common_vendor.o(($event) => formData.value.remark = $event.detail.value)
      };
    };
  }
};
const Component = /* @__PURE__ */ common_vendor._export_sfc(_sfc_main, [["__file", "D:/project/2024/project-zhyl-xcx-uniapp-java-hongbo-v2.0/project-zhyl-xcx-uniapp-java2.0/pages/family/components/BoundForm.vue"]]);
wx.createComponent(Component);
