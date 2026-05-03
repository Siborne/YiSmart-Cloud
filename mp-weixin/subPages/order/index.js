"use strict";
const common_vendor = require("../../common/vendor.js");
const pages_api_order = require("../../pages/api/order.js");
require("../../utils/request.js");
require("../../utils/env.js");
if (!Array) {
  const _component_NavBar = common_vendor.resolveComponent("NavBar");
  const _component_net_fail = common_vendor.resolveComponent("net-fail");
  (_component_NavBar + _component_net_fail)();
}
if (!Math) {
  (List + DeletePopup)();
}
const DeletePopup = () => "../../components/Operate/index.js";
const List = () => "./components/list.js";
const _sfc_main = {
  __name: "index",
  setup(__props) {
    const store = common_vendor.useStore();
    const users = store.state.user;
    const typeVal = common_vendor.ref(users.backLink);
    const deleteRef = common_vendor.ref(null);
    const itemData = common_vendor.ref([]);
    const moreStatus = common_vendor.ref("more");
    const netStatus = common_vendor.ref(true);
    const loading = common_vendor.ref(false);
    const orderId = common_vendor.ref();
    const errorTipText = common_vendor.ref({
      title: "",
      text: "您确定要删除订单么？"
    });
    let params = common_vendor.reactive({
      pageNum: 1,
      pageSize: 10
    });
    const pageNum = common_vendor.ref(1);
    const pages = common_vendor.ref(0);
    const isSendRequest = common_vendor.ref(false);
    const isback = common_vendor.ref(false);
    common_vendor.onShow(() => {
      params.status = users.orderStatus === "" ? "" : users.orderStatus;
      getNewData();
    });
    const getNewData = async () => {
      params = {
        pageSize: params.pageSize,
        pageNum: pageNum.value,
        status: params.status
      };
      if (isSendRequest.value) {
        return;
      }
      moreStatus.value = "loading";
      loading.value = false;
      await pages_api_order.getOrderList(params).then((res) => {
        if (res.code === 200) {
          const {
            data
          } = res;
          const items = data.records == null ? [] : data.records;
          moreStatus.value = items.length < 10 ? "no-more" : "more";
          params.pageNum == 1 ? itemData.value = void 0 : null;
          itemData.value = itemData.value ? [...itemData.value, ...items] : items;
          pages.value = data.pages;
          if (data.pages === pageNum.value) {
            isSendRequest.value = true;
            moreStatus.value = "noMore";
          }
          common_vendor.index.stopPullDownRefresh();
          netStatus.value = true;
          loading.value = true;
        }
      }).catch((err) => {
        common_vendor.index.showToast({
          title: err.msg,
          duration: 1e3,
          icon: "none"
        });
        netStatus.value = false;
      });
    };
    const subDelete = async () => {
      isSendRequest.value = false;
      await pages_api_order.orderDelete(orderId.value).then((res) => {
        if (res.code === 200) {
          itemData.value = [];
          pageNum.value = 1;
          getNewData();
          deleteRef.value.popup.close();
          common_vendor.index.showToast({
            title: "删除成功",
            duration: 1e3,
            icon: "none"
          });
        }
      }).catch((err) => {
        console.log(err);
      });
    };
    const setTabIndex = (index) => {
      if (index >= 1) {
        store.commit("user/setOrderStatus", index - 1);
        params.status = index - 1;
      } else {
        store.commit("user/setOrderStatus", "");
      }
      pageNum.value = 1;
      if (index === 0) {
        params.status = "";
      }
      isSendRequest.value = false;
      getNewData();
    };
    const onReachBottom = () => {
      if (pageNum.value >= pages.value) {
        moreStatus.value = "noMore";
        return false;
      }
      moreStatus.value = "loading";
      const times = setTimeout(() => {
        pageNum.value++;
        getNewData();
        clearTimeout(times);
      }, 1e3);
    };
    const handleDelete = (id) => {
      orderId.value = id;
      deleteRef.value.popup.open();
    };
    const handleToLink = () => {
      store.commit("user/setOrderStatus", "");
      isback.value = true;
      if (typeVal.value === "my") {
        store.commit("setFootStatus", 3);
        common_vendor.index.navigateBack({
          delta: 1
        });
      } else if (store.state.footStatus === 2 || store.state.footStatus === 3) {
        common_vendor.index.reLaunch({
          url: `/pages/my/index`
        });
        store.commit("setFootStatus", 3);
      } else {
        store.commit("setFootStatus", 0);
        common_vendor.index.reLaunch({
          url: `/pages/index/index`
        });
      }
    };
    const handleToRefresh = () => {
      params.value.pageNum = 1;
      getNewData();
    };
    return (_ctx, _cache) => {
      return common_vendor.e({
        a: common_vendor.p({
          title: "我的订单",
          isShowBack: true,
          handleToLink
        }),
        b: netStatus.value
      }, netStatus.value ? {
        c: common_vendor.o(setTabIndex),
        d: common_vendor.o(handleDelete),
        e: common_vendor.o(onReachBottom),
        f: common_vendor.p({
          itemData: itemData.value,
          moreStatus: moreStatus.value,
          loading: loading.value
        })
      } : {
        g: common_vendor.p({
          handleToRefresh
        })
      }, {
        h: common_vendor.sr(deleteRef, "fb08d78d-3", {
          "k": "deleteRef"
        }),
        i: common_vendor.o(subDelete),
        j: common_vendor.p({
          errorTipText: errorTipText.value
        })
      });
    };
  }
};
const MiniProgramPage = /* @__PURE__ */ common_vendor._export_sfc(_sfc_main, [["__scopeId", "data-v-fb08d78d"], ["__file", "D:/project/2024/project-zhyl-xcx-uniapp-java-hongbo-v2.0/project-zhyl-xcx-uniapp-java2.0/subPages/order/index.vue"]]);
wx.createPage(MiniProgramPage);
