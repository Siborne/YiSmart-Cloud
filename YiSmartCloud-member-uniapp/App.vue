<script>
export default {
  globalData: {
    footStatus: 0,
    router: ''
  },
  onLaunch() {},
  onShow() {},
  onHide() {}
}
</script>

<style>
page {
  --ys-primary: #ff8455;
  --ys-primary-dark: #ff7447;
  --ys-primary-light: #ffb08f;
  --ys-bg: #f3f3f5;
  --ys-card: #ffffff;
  --ys-text: #222222;
  --ys-text-secondary: #555555;
  --ys-text-muted: #8b8b8b;
  --ys-border: #ebebeb;
  --ys-danger: #dd524d;
  --ys-danger-soft: #fff0ef;
  --ys-success: #2eb872;
  --ys-success-soft: #e8f8ef;
  --ys-warning-soft: #fff4e5;
  --ys-radius: 16rpx;
  --ys-radius-lg: 20rpx;
  --ys-shadow: 0 8rpx 28rpx rgba(0, 0, 0, 0.06);
  --ys-font-title: 34rpx;
  --ys-font-body: 28rpx;
  --ys-font-caption: 24rpx;
  background-color: var(--ys-bg);
  color: var(--ys-text);
  font-size: var(--ys-font-body);
  box-sizing: border-box;
}

view,
text,
input,
textarea,
button {
  box-sizing: border-box;
}

button::after {
  border: none;
}

.main-page {
  min-height: 100vh;
  padding-bottom: 120rpx;
}

.section {
  margin: 20rpx;
  padding: 24rpx;
  background: var(--ys-card);
  border-radius: var(--ys-radius-lg);
  box-shadow: var(--ys-shadow);
}

.ys-page-tint {
  background-color: var(--ys-bg);
  min-height: 100vh;
}

.ys-card {
  background: var(--ys-card);
  border-radius: var(--ys-radius-lg);
  box-shadow: var(--ys-shadow);
  padding: 24rpx;
}

.ys-btn-primary {
  height: 88rpx;
  line-height: 88rpx;
  border-radius: var(--ys-radius);
  background: linear-gradient(180deg, var(--ys-primary) 0%, var(--ys-primary-dark) 100%);
  color: #fff;
  font-size: 30rpx;
  font-weight: 600;
  box-shadow: 0 10rpx 24rpx rgba(255, 132, 85, 0.35);
  padding: 0;
  margin: 0;
}

.ys-btn-primary[disabled] {
  opacity: 0.45;
  box-shadow: none;
}

.ys-btn-outline {
  height: 88rpx;
  line-height: 88rpx;
  border-radius: var(--ys-radius);
  background: #fff;
  color: var(--ys-primary);
  font-size: 30rpx;
  font-weight: 600;
  border: 2rpx solid var(--ys-primary);
  padding: 0;
  margin: 0;
}

.ys-btn-ghost {
  height: 64rpx;
  line-height: 64rpx;
  border-radius: 999rpx;
  background: #fff;
  color: var(--ys-text-secondary);
  font-size: 26rpx;
  border: 2rpx solid var(--ys-border);
  padding: 0 28rpx;
  margin: 0;
}

.ys-btn-ghost--primary {
  color: var(--ys-primary);
  border-color: rgba(255, 132, 85, 0.45);
  background: rgba(255, 132, 85, 0.06);
}

.ys-btn-pill {
  height: 64rpx;
  line-height: 64rpx;
  border-radius: 999rpx;
  padding: 0 32rpx;
  font-size: 26rpx;
  font-weight: 600;
  margin: 0;
}

.ys-field {
  width: 100%;
  min-height: 88rpx;
  padding: 0 24rpx;
  background: var(--ys-bg);
  border: 2rpx solid var(--ys-border);
  border-radius: var(--ys-radius);
  font-size: 28rpx;
  color: var(--ys-text);
}

.ys-field-area {
  width: 100%;
  min-height: 200rpx;
  padding: 20rpx 24rpx;
  background: var(--ys-bg);
  border: 2rpx solid var(--ys-border);
  border-radius: var(--ys-radius);
  font-size: 28rpx;
  color: var(--ys-text);
}

.ys-loading-wrap {
  min-height: 280rpx;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 20rpx;
}

.ys-loading-dot {
  width: 14rpx;
  height: 14rpx;
  border-radius: 50%;
  background: var(--ys-primary);
  animation: ys-pulse 0.9s ease-in-out infinite alternate;
}

.ys-loading-text {
  font-size: var(--ys-font-caption);
  color: var(--ys-text-muted);
}

@keyframes ys-pulse {
  from {
    opacity: 0.35;
    transform: scale(0.85);
  }
  to {
    opacity: 1;
    transform: scale(1);
  }
}
</style>
