// store.js
import { createStore } from 'vuex';

export default createStore({
  state: {
    // 初始状态
    buttonText: '未评分'
  },
  mutations: {
    // 更改状态的方法
    setButtonText(state, newText) {
      state.buttonText = newText;
    }
  },
  actions: {
    // 可以包含异步操作的方法
    asyncUpdateButton({ commit }, newText) {
      commit('setButtonText', newText);
    }
  },
  getters: {
    // 可以用于访问状态的计算属性
    buttonText: state => state.buttonText
  }
});