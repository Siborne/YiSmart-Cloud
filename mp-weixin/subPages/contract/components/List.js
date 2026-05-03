"use strict";
const common_vendor = require("../../../common/vendor.js");
const utils_index = require("../../../utils/index.js");
if (!Array) {
  const _easycom_uni_load_more2 = common_vendor.resolveComponent("uni-load-more");
  _easycom_uni_load_more2();
}
const _easycom_uni_load_more = () => "../../../uni_modules/uni-load-more/components/uni-load-more/uni-load-more.js";
if (!Math) {
  (_easycom_uni_load_more + EmptyPage)();
}
const EmptyPage = () => "../../../components/EmptyPage/index.js";
const _sfc_main = {
  __name: "List",
  props: {
    itemData: {
      type: Array,
      default: () => []
    },
    moreStatus: {
      type: String,
      default: "noMore"
    },
    loading: {
      type: Boolean,
      default: false
    }
  },
  emits: ["handleOpen"],
  setup(__props, { emit }) {
    const emptyInfo = common_vendor.ref("您暂时没有合同信息哦~");
    const isClick = common_vendor.ref(false);
    const contentText = common_vendor.ref({
      // 加载状态说明
      contentdown: "上拉加载更多",
      contentrefresh: "努力加载中...",
      contentnomore: "- 没有更多了 -"
    });
    const previewPdf = (url) => {
      common_vendor.index.showToast({
        title: "努力加载中...",
        icon: "loading",
        mask: true
      });
      if (!isClick.value) {
        isClick.value = true;
        common_vendor.index.downloadFile({
          url,
          // 文件地址
          success(res) {
            const filePath = res.tempFilePath;
            if (res.errMsg === "downloadFile:ok") {
              setTimeout(() => {
                common_vendor.index.hideLoading();
                isClick.value = false;
              }, 3e3);
              common_vendor.index.openDocument({
                filePath,
                showMenu: false,
                // 这个参数可设置你预览的文件能否被直接转发，此次是设置是否展示分享菜单
                success(res2) {
                  console.log(res2);
                }
              });
            }
          }
        });
      }
    };
    const handleDownload = (item) => {
      emit("handleOpen", item);
    };
    return (_ctx, _cache) => {
      return common_vendor.e({
        a: common_vendor.f(__props.itemData, (item, index, i0) => {
          return common_vendor.e({
            a: common_vendor.t(item.contractNo),
            b: item.status === 0
          }, item.status === 0 ? {} : {}, {
            c: item.status === 1
          }, item.status === 1 ? {} : {}, {
            d: item.status === 2
          }, item.status === 2 ? {} : {}, {
            e: item.status === 3
          }, item.status === 3 ? {} : {}, {
            f: item.elderVo.image,
            g: common_vendor.t(item.name),
            h: common_vendor.t(item.elderVo.name),
            i: common_vendor.t(common_vendor.unref(utils_index.getNow)(item.signDate)),
            j: common_vendor.t(common_vendor.unref(utils_index.getNow)(item.startTime)),
            k: common_vendor.t(common_vendor.unref(utils_index.getNow)(item.endTime)),
            l: item.status === 3
          }, item.status === 3 ? {
            m: common_vendor.t(common_vendor.unref(utils_index.getNow)(item.releaseDate))
          } : {}, {
            n: common_vendor.o(($event) => previewPdf(item.pdfUrl), index),
            o: common_vendor.o(($event) => handleDownload(item), index),
            p: index
          });
        }),
        b: __props.itemData.length > 6
      }, __props.itemData.length > 6 ? {
        c: common_vendor.p({
          status: __props.moreStatus,
          ["content-text"]: contentText.value
        })
      } : {}, {
        d: __props.itemData.length === 0 && __props.loading
      }, __props.itemData.length === 0 && __props.loading ? {
        e: common_vendor.p({
          emptyInfo: emptyInfo.value
        })
      } : {});
    };
  }
};
const Component = /* @__PURE__ */ common_vendor._export_sfc(_sfc_main, [["__file", "D:/project/2024/project-zhyl-xcx-uniapp-java-hongbo-v2.0/project-zhyl-xcx-uniapp-java2.0/subPages/contract/components/List.vue"]]);
wx.createComponent(Component);
