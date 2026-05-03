"use strict";
const common_vendor = require("../../../common/vendor.js");
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
  emits: ["handleOpen", "onReachBottom"],
  setup(__props, { emit }) {
    const store = common_vendor.useStore();
    const emptyInfo = common_vendor.ref("您暂时没有绑定的家人~");
    const contentText = common_vendor.ref({
      // 加载状态说明
      contentdown: "上拉加载更多",
      contentrefresh: "努力加载中...",
      contentnomore: "- 没有更多了 -"
    });
    const handleUnbind = (id) => {
      emit("handleOpen", id);
    };
    const handleBill = (val) => {
      store.commit("setFootStatus", 1);
      store.commit("user/setBackLike", "family");
      common_vendor.index.navigateTo({
        url: `/subPages/bill/index?id=${val.elderId}&name=${val.name}`
      });
    };
    common_vendor.onReachBottom(() => {
      emit("onReachBottom");
    });
    const handleToHealthyData = (item) => {
      common_vendor.index.navigateTo({
        url: `/subPages/healthy/index?item=${encodeURIComponent(JSON.stringify(item))}`
      });
    };
    return (_ctx, _cache) => {
      return common_vendor.e({
        a: __props.itemData && __props.itemData.length > 0
      }, __props.itemData && __props.itemData.length > 0 ? common_vendor.e({
        b: common_vendor.f(__props.itemData, (item, index, i0) => {
          return common_vendor.e({
            a: item.image,
            b: common_vendor.t(item.name),
            c: common_vendor.t(item.mremark),
            d: common_vendor.t(item.bedNumber !== void 0 ? item.typeName + "-" + item.bedNumber + "床" : "--"),
            e: common_vendor.o(($event) => handleBill(item), index),
            f: item.iotId
          }, item.iotId ? {
            g: common_vendor.o(($event) => handleToHealthyData(item), index)
          } : {}, {
            h: common_vendor.o(($event) => handleUnbind(item.mid), index),
            i: index
          });
        }),
        c: __props.itemData.length > 6
      }, __props.itemData.length > 6 ? {
        d: common_vendor.p({
          status: __props.moreStatus,
          ["content-text"]: contentText.value
        })
      } : {}) : {}, {
        e: __props.itemData.length === 0 && __props.loading
      }, __props.itemData.length === 0 && __props.loading ? {
        f: common_vendor.p({
          emptyInfo: emptyInfo.value
        })
      } : {});
    };
  }
};
const Component = /* @__PURE__ */ common_vendor._export_sfc(_sfc_main, [["__file", "D:/project/2024/project-zhyl-xcx-uniapp-java-hongbo-v2.0/project-zhyl-xcx-uniapp-java2.0/pages/family/components/List.vue"]]);
wx.createComponent(Component);
