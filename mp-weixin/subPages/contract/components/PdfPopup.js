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
  __name: "PdfPopup",
  props: {
    // 选择的时间
    pdfData: {
      type: Object,
      default: () => ({})
    }
  },
  setup(__props, { expose }) {
    const props = __props;
    const popup = common_vendor.ref(null);
    const handleClose = () => {
      popup.value.close();
    };
    const handleCopy = () => {
      common_vendor.index.setClipboardData({
        data: props.pdfData.pdfUrl,
        success: () => {
          handleClose();
        }
      });
    };
    expose({
      popup
    });
    return (_ctx, _cache) => {
      return {
        a: common_vendor.t(__props.pdfData.name),
        b: common_vendor.o(handleCopy),
        c: common_vendor.o(handleClose),
        d: _ctx.type === "left" || _ctx.type === "right" ? 1 : "",
        e: common_vendor.sr(popup, "a3144254-0", {
          "k": "popup"
        })
      };
    };
  }
};
const Component = /* @__PURE__ */ common_vendor._export_sfc(_sfc_main, [["__file", "D:/project/2024/project-zhyl-xcx-uniapp-java-hongbo-v2.0/project-zhyl-xcx-uniapp-java2.0/subPages/contract/components/PdfPopup.vue"]]);
wx.createComponent(Component);
