"use strict";
const common_vendor = require("../../common/vendor.js");
const pages_api_contract = require("../../pages/api/contract.js");
require("../../utils/request.js");
require("../../utils/env.js");
if (!Array) {
  const _component_NavBar = common_vendor.resolveComponent("NavBar");
  const _component_net_fail = common_vendor.resolveComponent("net-fail");
  (_component_NavBar + _component_net_fail)();
}
if (!Math) {
  (List + PdfPopup)();
}
const List = () => "./components/List.js";
const PdfPopup = () => "./components/PdfPopup.js";
const _sfc_main = {
  __name: "index",
  setup(__props) {
    const popup = common_vendor.ref(null);
    const itemData = common_vendor.ref([]);
    const moreStatus = common_vendor.ref("more");
    const loading = common_vendor.ref(false);
    const netStatus = common_vendor.ref(true);
    let params = common_vendor.reactive({
      pageNum: 1,
      pageSize: 10
    });
    const pageNum = common_vendor.ref(1);
    const pages = common_vendor.ref(0);
    const isSendRequest = common_vendor.ref(false);
    const pdfData = common_vendor.ref({});
    const capsuleBottom = common_vendor.ref();
    common_vendor.onLoad(() => {
      common_vendor.index.getSystemInfo({
        success: () => {
          capsuleBottom.value = common_vendor.index.getMenuButtonBoundingClientRect().bottom + 13;
        }
      });
    });
    common_vendor.onShow(() => {
      getNewData();
    });
    const getNewData = async () => {
      params = {
        ...params,
        page: pageNum.value
      };
      if (isSendRequest.value) {
        return;
      }
      moreStatus.value = "loading";
      loading.value = false;
      await pages_api_contract.getContractList(params).then((res) => {
        if (res.code === 200) {
          const {
            data
          } = res;
          const items = data.records == null ? [] : data.records;
          moreStatus.value = items.length < 10 ? "no-more" : "more";
          params.page == 1 ? itemData.value = void 0 : null;
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
    const handleToLink = () => {
      common_vendor.index.navigateBack({
        delta: 1
      });
    };
    const handleDownload = (val) => {
      pdfData.value = val;
      popup.value.popup.open();
    };
    const handleToRefresh = () => {
      params.value.pageNum = 1;
      getNewData();
    };
    return (_ctx, _cache) => {
      return common_vendor.e({
        a: common_vendor.p({
          title: "我的合同",
          isShowBack: true,
          handleToLink
        }),
        b: netStatus.value
      }, netStatus.value ? {
        c: common_vendor.o(handleDownload),
        d: common_vendor.o(onReachBottom),
        e: common_vendor.p({
          itemData: itemData.value,
          moreStatus: moreStatus.value,
          loading: loading.value
        }),
        f: capsuleBottom.value + "px"
      } : {
        g: common_vendor.p({
          handleToRefresh
        })
      }, {
        h: common_vendor.sr(popup, "9fe4b4af-3", {
          "k": "popup"
        }),
        i: common_vendor.o(_ctx.subUnbind),
        j: common_vendor.p({
          pdfData: pdfData.value
        })
      });
    };
  }
};
const MiniProgramPage = /* @__PURE__ */ common_vendor._export_sfc(_sfc_main, [["__scopeId", "data-v-9fe4b4af"], ["__file", "D:/project/2024/project-zhyl-xcx-uniapp-java-hongbo-v2.0/project-zhyl-xcx-uniapp-java2.0/subPages/contract/index.vue"]]);
wx.createPage(MiniProgramPage);
