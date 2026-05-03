"use strict";
const common_vendor = require("../../common/vendor.js");
const _sfc_main = {
  __name: "index",
  props: {
    handleToRefresh: {
      // 用于自定义跳转
      type: Function
    }
  },
  setup(__props) {
    const props = __props;
    const capsuleBottom = ref();
    onLoad(() => {
      common_vendor.index.getSystemInfo({
        success: () => {
          capsuleBottom.value = common_vendor.index.getMenuButtonBoundingClientRect().bottom + 18;
        }
      });
    });
    const handleTo = () => {
      props.handleToRefresh();
    };
    return (_ctx, _cache) => {
      return {
        a: common_vendor.o(handleTo),
        b: common_vendor.unref(capsuleBottom) + "px"
      };
    };
  }
};
const Component = /* @__PURE__ */ common_vendor._export_sfc(_sfc_main, [["__scopeId", "data-v-44cb6724"], ["__file", "D:/project/2024/project-zhyl-xcx-uniapp-java-hongbo-v2.0/project-zhyl-xcx-uniapp-java2.0/components/NetFail/index.vue"]]);
wx.createComponent(Component);
