"use strict";
const common_vendor = require("../../../common/vendor.js");
const _sfc_main = {
  __name: "HotList",
  props: {
    // 房型信息
    baseData: {
      type: Array,
      default: () => []
    }
  },
  setup(__props) {
    return (_ctx, _cache) => {
      return {
        a: common_vendor.f(__props.baseData, (item, index, i0) => {
          return {
            a: item.photo,
            b: common_vendor.t(item.name),
            c: common_vendor.t(item.introduction),
            d: index
          };
        })
      };
    };
  }
};
const Component = /* @__PURE__ */ common_vendor._export_sfc(_sfc_main, [["__file", "D:/project/2024/project-zhyl-xcx-uniapp-java-hongbo-v2.0/project-zhyl-xcx-uniapp-java2.0/pages/index/components/HotList.vue"]]);
wx.createComponent(Component);
